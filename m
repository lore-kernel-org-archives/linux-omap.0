From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 0/2] crypto: omap-sham: Misc updates for driver
Date: Tue, 20 Aug 2013 20:32:33 +0530
Message-ID: <1377010955-5605-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40775 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013Ab3HTPCp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Aug 2013 11:02:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: herbert@gondor.hengli.com.au
Cc: linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org, rnayak@ti.com, nsekhar@ti.com, lokeshvutla@ti.com

This patch series updates the following for the driver:
-> Enable polling mode if DMA fails.
-> Correct the DMA burst size.

Lokesh Vutla (2):
  crypto: omap-sham: Enable Polling mode if DMA fails
  crypto: omap-sham: correct dma burst size

 drivers/crypto/omap-sham.c |   72 ++++++++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 26 deletions(-)

-- 
1.7.9.5

