From: jean.pihet@newoldbits.com
Subject: [PATCH 13/26] OMAP: SmartReflex driver interface: allow core to override eFuse data
Date: Tue, 22 Nov 2011 16:05:57 +0100
Message-ID: <1321974370-25800-14-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38321 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757113Ab1KVPHN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:07:13 -0500
Received: by mail-fx0-f46.google.com with SMTP id n18so497590fag.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:07:13 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>, Thara Gopinath <thara@ti.com>, Nishanth Menon <nm@ti.com>

From: Paul Walmsley <paul@pwsan.com>

Sometimes, the automatic voltage scaling control loop parameters in
the SoC eFuse data are not present or are incorrect.  Nevertheless,
some boards may wish to use SmartReflex anyway, with conservative
values provided by the SoC manufacturer.  This patch adds code to
allow board files to specify or override the SmartReflex eFuse data.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/sr_device.c |   40 ++++++++++++++++++++++----------------
 arch/arm/mach-omap2/voltage.h   |    2 +
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 8fe836f..2dec827 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -7,8 +7,9 @@
  * Copyright (C) 2010 Texas Instruments, Inc.
  * Thara Gopinath <thara@ti.com>
  *
- * Copyright (C) 2008 Nokia Corporation
+ * Copyright (C) 2008, 2011 Nokia Corporation
  * Kalle Jokiniemi
+ * Paul Walmsley
  *
  * Copyright (C) 2007 Texas Instruments, Inc.
  * Lesly A M <x0080970@ti.com>
@@ -54,31 +55,36 @@ static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
 	for (i = 0, j = 0; i < count; i++) {
 		u32 v;
 
-		/*
-		 * In OMAP4 the efuse registers are 24 bit aligned.
-		 * A __raw_readl will fail for non-32 bit aligned address
-		 * and hence the 8-bit read and shift.
-		 */
-		if (cpu_is_omap44xx()) {
-			u16 offset = volt_data[i].sr_efuse_offs;
-
-			v = omap_ctrl_readb(offset) |
-				omap_ctrl_readb(offset + 1) << 8 |
-				omap_ctrl_readb(offset + 2) << 16;
+		if (volt_data[i].sr_nvalue != 0) {
+			v = volt_data[i].sr_nvalue;
 		} else {
-			v = omap_ctrl_readl(volt_data[i].sr_efuse_offs);
+			/*
+			 * In OMAP4 the efuse registers are 24 bit
+			 * aligned.  A __raw_readl will fail for
+			 * non-32 bit aligned address and hence the
+			 * 8-bit read and shift.
+			 */
+			if (cpu_is_omap44xx()) {
+				u16 offset = volt_data[i].sr_efuse_offs;
+
+				v = omap_ctrl_readb(offset) |
+					omap_ctrl_readb(offset + 1) << 8 |
+					omap_ctrl_readb(offset + 2) << 16;
+			} else {
+				v = omap_ctrl_readl(volt_data[i].sr_efuse_offs);
+			}
 		}
 
 		/*
 		 * Many OMAP SoCs don't have the eFuse values set.
 		 * For example, pretty much all OMAP3xxx before
 		 * ES3.something.
-		 *
-		 * XXX There needs to be some way for board files or
-		 * userspace to add these in.
 		 */
-		if (v == 0)
+		if (v == 0) {
+			pr_debug("SR: %s: voltage %d: no N value; skipping\n",
+				 sr_data->voltdm->name, volt_data[i].volt_nominal);
 			continue;
+		}
 
 		nvalue_table[j].nvalue = v;
 		nvalue_table[j].errminlimit = volt_data[i].sr_errminlimit;
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 16a1b09..ebd8899 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -96,6 +96,7 @@ struct voltagedomain {
  * @sr_efuse_offs:	The offset of the efuse register(from system
  *			control module base address) from where to read
  *			the n-target value for the smartreflex module.
+ * @sr_nvalue: the SR N value for this OPP.  Use to override bogus eFuse vals
  * @sr_errminlimit:	Error min limit value for smartreflex. This value
  *			differs at differnet opp and thus is linked
  *			with voltage.
@@ -105,6 +106,7 @@ struct voltagedomain {
 struct omap_volt_data {
 	u32	volt_nominal;
 	u32	sr_efuse_offs;
+	u32	sr_nvalue;
 	u8	sr_errminlimit;
 	u8	vp_errgain;
 };
-- 
1.7.5.4

