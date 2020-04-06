import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import tensorflow as tf

class BaseModel(object):
    """Generic class for general methods that are not specific to NER"""
    def __init__(self, config):
        """Defines self.config and self.logger
        Args:
            config: (Config instance) class with hyper parameters,
                vocab and embeddings
        """
        self.config = config
        self.logger = config.logger 
        self.session = None        # sess probably is session
        self.saver = None

    def init_session(self):
        self.logger.info("Initializing tf session")
        self.session = tf.Session()
        self.session.run(tf.global_variables_initializer())
        self.saver = tf.train.Saver 
        
