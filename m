From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH] ARM: OMAP3+: Fix kernel panic on boot
Date: Mon, 11 Feb 2013 14:26:19 -0600
Message-ID: <1360614380-20114-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56197 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932170Ab3BKU0e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Feb 2013 15:26:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Commit 8a6aaa3 (mfd: twl-core: Collect global variables behind one
private structure (global)) removed the variable "inuse" that is used
to determine if the device has been initialised and now use the
twl_priv structure instead. This is causing the kernel to panic on
OMAP3+ devices using the twl driver, because we try to access the
twl_priv->ready member before checking if twl_priv is initialised. Fix
this and move this test to the beginning of the twl_i2c_read/write
function because twl_get_last_module() also uses the twl_priv structure.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl-core.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 557f9ee..89ab4d9 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -316,12 +316,12 @@ int twl_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
 	int sid;
 	struct twl_client *twl;
 
-	if (unlikely(mod_no >= twl_get_last_module())) {
-		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
+	if (unlikely(!twl_priv || !twl_priv->ready)) {
+		pr_err("%s: not initialized\n", DRIVER_NAME);
 		return -EPERM;
 	}
-	if (unlikely(!twl_priv->ready)) {
-		pr_err("%s: not initialized\n", DRIVER_NAME);
+	if (unlikely(mod_no >= twl_get_last_module())) {
+		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
 		return -EPERM;
 	}
 
@@ -355,12 +355,12 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
 	int sid;
 	struct twl_client *twl;
 
-	if (unlikely(mod_no >= twl_get_last_module())) {
-		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
+	if (unlikely(!twl_priv || !twl_priv->ready)) {
+		pr_err("%s: not initialized\n", DRIVER_NAME);
 		return -EPERM;
 	}
-	if (unlikely(!twl_priv->ready)) {
-		pr_err("%s: not initialized\n", DRIVER_NAME);
+	if (unlikely(mod_no >= twl_get_last_module())) {
+		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
 		return -EPERM;
 	}
 
-- 
1.7.10.4

