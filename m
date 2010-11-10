From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
Subject: [PATCH 0/7] omap-sham off mode and error handling fixes.
Date: Wed, 10 Nov 2010 19:28:08 +0200
Message-ID: <cover.1289410038.git.dmitry.kasatkin@nokia.com>
Return-path: <linux-crypto-owner@vger.kernel.org>
Sender: linux-crypto-owner@vger.kernel.org
To: herbert@gondor.hengli.com.au
Cc: linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Dmitry Kasatkin (7):
  crypto: updates omap sham device related platform code
  crypto: omap-sham - omap sha1 & md5 driver
  omap-sham: OMAP macros corrected
  omap-sham: uses digest buffer in request context
  omap-sham: DMA initialization fixes for off mode
  omap-sham: error handling improved
  omap-sham: removed redundunt locking
