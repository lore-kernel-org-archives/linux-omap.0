From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
Subject: [PATCH 0/1] omap-sham: use prefetch mechanism to increase transfer speed
Date: Thu,  2 Sep 2010 17:17:34 +0300
Message-ID: <cover.1283436919.git.dmitry.kasatkin@nokia.com>
Return-path: <linux-crypto-owner@vger.kernel.org>
Sender: linux-crypto-owner@vger.kernel.org
To: herbert@gondor.hengli.com.au
Cc: linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Samu Onkalo (1):
  crypto: omap-sham: Adjust DMA parameters

 drivers/crypto/omap-sham.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)
