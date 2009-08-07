From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 1/2] OMAP2: Add funcs for writing SMS_ROT_* registers
Date: Fri,  7 Aug 2009 11:29:56 +0300
Message-ID: <1249633796-12266-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:56909 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757106AbZHGIaZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 04:30:25 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n778U2Xr009389
	for <linux-omap@vger.kernel.org>; Fri, 7 Aug 2009 03:30:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

SMS_ROT_* registers are used by VRFB rotation engine.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/mach-omap2/sdrc.c             |   16 ++++++++++++++++
 arch/arm/plat-omap/include/mach/sdrc.h |    8 +++++++-
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index 2045441..56f6dab 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -111,3 +111,19 @@ void __init omap2_sdrc_init(struct omap_sdrc_params *sp)
 		(1 << SDRC_POWER_PAGEPOLICY_SHIFT);
 	sdrc_write_reg(l, SDRC_POWER);
 }
+
+void omap2_sms_write_rot_control(u32 val, unsigned ctx)
+{
+	sms_write_reg(val, SMS_ROT_CONTROL(ctx));
+}
+
+void omap2_sms_write_rot_size(u32 val, unsigned ctx)
+{
+	sms_write_reg(val, SMS_ROT_SIZE(ctx));
+}
+
+void omap2_sms_write_rot_physical_ba(u32 val, unsigned ctx)
+{
+	sms_write_reg(val, SMS_ROT_PHYSICAL_BA(ctx));
+}
+
diff --git a/arch/arm/plat-omap/include/mach/sdrc.h b/arch/arm/plat-omap/include/mach/sdrc.h
index adc7352..4199c19 100644
--- a/arch/arm/plat-omap/include/mach/sdrc.h
+++ b/arch/arm/plat-omap/include/mach/sdrc.h
@@ -75,7 +75,10 @@
 
 /* SMS register offsets - read/write with sms_{read,write}_reg() */
 
-#define SMS_SYSCONFIG		0x010
+#define SMS_SYSCONFIG			0x010
+#define SMS_ROT_CONTROL(context)	(0x180 + 0x10 * context)
+#define SMS_ROT_SIZE(context)		(0x184 + 0x10 * context)
+#define SMS_ROT_PHYSICAL_BA(context)	(0x188 + 0x10 * context)
 /* REVISIT: fill in other SMS registers here */
 
 
@@ -104,6 +107,9 @@ struct omap_sdrc_params {
 
 void __init omap2_sdrc_init(struct omap_sdrc_params *sp);
 struct omap_sdrc_params *omap2_sdrc_get_params(unsigned long r);
+void omap2_sms_write_rot_control(u32 val, unsigned ctx);
+void omap2_sms_write_rot_size(u32 val, unsigned ctx);
+void omap2_sms_write_rot_physical_ba(u32 val, unsigned ctx);
 
 #ifdef CONFIG_ARCH_OMAP2
 
-- 
1.6.4

