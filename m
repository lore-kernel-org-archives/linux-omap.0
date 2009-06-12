From: Ulrik Bech Hald <ubh@ti.com>
Subject: [PATCH 1/1] OMAP3:Re-introduce omap_type()
Date: Fri, 12 Jun 2009 15:58:31 -0500
Message-ID: <1244840311-11809-1-git-send-email-ubh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41107 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854AbZFLUx6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Jun 2009 16:53:58 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5CKrtUf018059
	for <linux-omap@vger.kernel.org>; Fri, 12 Jun 2009 15:54:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ulrik Bech Hald <ubh@ti.com>

The functionality of omap_type() is needed for eg. watchdog
device registration to distinguish different device types.

Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
---
 arch/arm/mach-omap2/id.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 arch/arm/mach-omap2/id.c

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
old mode 100644
new mode 100755
index 458990e..9fa61b4
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -48,6 +48,27 @@ int omap_chip_is(struct omap_chip_id oci)
 }
 EXPORT_SYMBOL(omap_chip_is);
 
+int omap_type(void)
+{
+	u32 val = 0;
+
+	if (cpu_is_omap24xx()) {
+		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
+	} else if (cpu_is_omap34xx()) {
+		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
+	} else {
+		pr_err("Cannot detect omap type!\n");
+		goto out;
+	}
+
+	val &= OMAP2_DEVICETYPE_MASK;
+	val >>= 8;
+
+out:
+	return val;
+}
+EXPORT_SYMBOL(omap_type);
+
 /*----------------------------------------------------------------------------*/
 
 #define OMAP_TAP_IDCODE		0x0204
-- 
1.5.4.3

