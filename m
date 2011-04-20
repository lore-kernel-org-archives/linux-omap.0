From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
Subject: [PATCH 0/4] crypto: omap-sham driver fixes
Date: Wed, 20 Apr 2011 13:34:54 +0300
Message-ID: <cover.1303295558.git.dmitry.kasatkin@nokia.com>
Return-path: <linux-crypto-owner@vger.kernel.org>
Sender: linux-crypto-owner@vger.kernel.org
To: herbert@gondor.hengli.com.au
Cc: linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Here is few patches with couple of important fixes...

Regards,
Dmitry

Dmitry Kasatkin (3):
  crypto: omap-sham - remove debug print
  crypto: omap-sham - enable driver for EMU chips
  crypto: omap-sham - hmac calculation bug fix for sha1 base hash

Markku Kylanpaa (1):
  crypto: omap-sham - fix concurrent sha1 calculations

 drivers/crypto/omap-sham.c |   78 +++++++++++++++++++-------------------------
 1 files changed, 34 insertions(+), 44 deletions(-)
