From: Unknown <unknown@unknown.invalid>
Subject: [PATCH 3/3] i2c-omap: Enable workaround for Errata 1.153 based on
Date: Mon, 17 Aug 2009 17:42:11 -0500
Message-ID: <35903.6713526168$1250548667@news.gmane.org>
References: <1250548931-18279-1-git-send-email-n>
 <1250548931-18279-2-git-send-email-n>
 <1250548931-18279-3-git-send-email-n>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35567 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758257AbZHQWhW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Aug 2009 18:37:22 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7HMbICp015205
	for <linux-omap@vger.kernel.org>; Mon, 17 Aug 2009 17:37:23 -0500
From: n@lina0132712
In-Reply-To: <1250548931-18279-3-git-send-email-n>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Moiz Sonasath <m-sonasath@ti.com>

From: Moiz Sonasath <m-sonasath@ti.com>

Silicon Errata 1.153 has been fixed on OMAP 3630|4430 with the use of a later
version of I2C IP block.

The errata impacts OMAP 2420|2430|3430, enable the workaround for these based 
on I2C IP block revision number instead of OMAP CPU type

Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 16b39f4..827da08 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -784,7 +784,7 @@ complete:
 				 * memory to the I2C interface.
 				 */
 
-				if (cpu_is_omap34xx()) {
+				if (dev->rev <= OMAP_I2C_REV_ON_3430) {
 						while (!(stat & OMAP_I2C_STAT_XUDF)) {
 							if (stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
 								omap_i2c_ack_stat(dev, stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
-- 
1.5.6.3

