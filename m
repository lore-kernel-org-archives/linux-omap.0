From: Moiz Sonasath <m-sonasath@ti.com>
Subject: [PATCH 0/3] *** SUBJECT HERE ***
Date: Mon, 17 Aug 2009 17:45:43 -0500
Message-ID: <1250549146-18362-1-git-send-email-m-sonasath@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35728 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758272AbZHQWk7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Aug 2009 18:40:59 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7HMeuTX017236
	for <linux-omap@vger.kernel.org>; Mon, 17 Aug 2009 17:41:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Moiz Sonasath <m-sonasath@ti.com>, Vikram Pandita <vikram.pandita@ti.com>

i2c-omap: I2C clean-up patch

This patch includes the following fixes:
-Fix I2C status ACK
-ACK pending [R/X]DR and [R/X]RDY interrupts in the error/completeion path
-Enable workaround for Errata 1.153 based on I2C IP block

Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>

Moiz Sonasath (3):
  i2c-omap: Fix I2C status ACK
  i2c-omap: ACK pending [R/X]DR and [R/X]RDY interrupts in the
    error/completeion path
  i2c-omap: Enable workaround for Errata 1.153 based on I2C IP block

 drivers/i2c/busses/i2c-omap.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

