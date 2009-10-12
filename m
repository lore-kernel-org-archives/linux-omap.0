From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] OMAP3 PM export chip IDCODE, Production ID and Die ID
Date: Mon, 12 Oct 2009 17:51:09 +0300
Message-ID: <1255359069-9621-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:30254 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932415AbZJLOw5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Oct 2009 10:52:57 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9CEpAjH028557
	for <linux-omap@vger.kernel.org>; Mon, 12 Oct 2009 09:51:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "De-Schrijver Peter (Nokia-D/Helsinki)" <Peter.De-Schrijver@nokia.com>, Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

From: De-Schrijver Peter (Nokia-D/Helsinki) <Peter.De-Schrijver@nokia.com>

This patch exports the OMAP3 IDCODE, Production ID and Die ID to userspace via
sysfs. This can be used to track down silicon specific issues. The info is
exported via sysfs because it should be possible to include this in corematic
dumps.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/id.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 2c5e0a3..97670e2 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -70,6 +70,10 @@ EXPORT_SYMBOL(omap_type);
 /*----------------------------------------------------------------------------*/
 
 #define OMAP_TAP_IDCODE		0x0204
+#define OMAP_TAP_PROD_ID_0      0x0208
+#define OMAP_TAP_PROD_ID_1      0x020c
+#define OMAP_TAP_PROD_ID_2      0x0210
+#define OMAP_TAP_PROD_ID_3      0x0214
 #define OMAP_TAP_DIE_ID_0	0x0218
 #define OMAP_TAP_DIE_ID_1	0x021C
 #define OMAP_TAP_DIE_ID_2	0x0220
@@ -77,6 +81,10 @@ EXPORT_SYMBOL(omap_type);
 
 #define read_tap_reg(reg)	__raw_readl(tap_base  + (reg))
 
+static ssize_t idcode_show(struct kobject *, struct kobj_attribute *, char *);
+static struct kobj_attribute idcode_attr = __ATTR(idcode, 0444, idcode_show,
+							NULL);
+
 struct omap_id {
 	u16	hawkeye;	/* Silicon type (Hawkeye id) */
 	u8	dev;		/* Device type from production_id reg */
@@ -96,6 +104,23 @@ static struct omap_id omap_ids[] __initdata = {
 static void __iomem *tap_base;
 static u16 tap_prod_id;
 
+static ssize_t idcode_show(struct kobject *kobj, struct kobj_attribute *attr,
+				char *buf)
+{
+	return sprintf(buf, "IDCODE: %08x\nProduction ID: %08x %08x %08x %08x\n"
+				"Die ID: %08x %08x %08x %08x\n",
+			read_tap_reg(OMAP_TAP_IDCODE),
+			read_tap_reg(OMAP_TAP_PROD_ID_0),
+			read_tap_reg(OMAP_TAP_PROD_ID_1),
+			read_tap_reg(OMAP_TAP_PROD_ID_2),
+			read_tap_reg(OMAP_TAP_PROD_ID_3),
+			read_tap_reg(OMAP_TAP_DIE_ID_0),
+			read_tap_reg(OMAP_TAP_DIE_ID_1),
+			read_tap_reg(OMAP_TAP_DIE_ID_2),
+			read_tap_reg(OMAP_TAP_DIE_ID_3));
+
+}
+
 void __init omap24xx_check_revision(void)
 {
 	int i, j;
@@ -259,3 +284,14 @@ void __init omap2_set_globals_tap(struct omap_globals *omap2_globals)
 	else
 		tap_prod_id = 0x0208;
 }
+
+void __init export_omapid(void)
+{
+	int error;
+
+	error = sysfs_create_file(power_kobj, &idcode_attr.attr);
+	if (error)
+		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
+}
+
+late_initcall(export_omapid);
-- 
1.6.2.4

