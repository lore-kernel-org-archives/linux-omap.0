From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 30/86] [ARM] omap: i2c: remove armxor_ck
Date: Thu, 12 Mar 2009 11:27:40 -0700
Message-ID: <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756517AbZCLSbF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:31:05 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:31:03 -0700 (PDT)
In-Reply-To: <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

On OMAP1, the I2C functional clock (fck) is the armxor_ck, so there's
no need to get "armxor_ck" separately.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/i2c/busses/i2c-omap.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 19f86e1..96814fb 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -312,15 +312,14 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 
 	if (cpu_class_is_omap1()) {
-		struct clk *armxor_ck;
-
-		armxor_ck = clk_get(NULL, "armxor_ck");
-		if (IS_ERR(armxor_ck))
-			dev_warn(dev->dev, "Could not get armxor_ck\n");
-		else {
-			fclk_rate = clk_get_rate(armxor_ck);
-			clk_put(armxor_ck);
-		}
+		/*
+		 * The I2C functional clock is the armxor_ck, so there's
+		 * no need to get "armxor_ck" separately.  Now, if OMAP2420
+		 * always returns 12MHz for the functional clock, we can
+		 * do this bit unconditionally.
+		 */
+		fclk_rate = clk_get_rate(dev->fclk);
+
 		/* TRM for 5912 says the I2C clock must be prescaled to be
 		 * between 7 - 12 MHz. The XOR input clock is typically
 		 * 12, 13 or 19.2 MHz. So we should have code that produces:
-- 
1.6.1.2

