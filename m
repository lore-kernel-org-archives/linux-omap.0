From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 4/9] bus: ti-sysc: Make omap_hwmod_sysc_fields into sysc_regbits platform data
Date: Fri, 15 Dec 2017 10:08:55 -0800
Message-ID: <20171215180900.3243-5-tony@atomide.com>
References: <20171215180900.3243-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171215180900.3243-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

We want to be able to configure hwmod sysc data from ti-sysc driver using
platform data callbacks. So let's make struct omap_hwmod_sysc_fields into
struct sysc_data and have it available for both ti-sysc driver and hwmod
code.

Note that we can make it use s8 instead of u8 as the hwmod code uses the
feature flags to check for this field. However, for ti-sysc we can use
-ENODEV to indicate a feature is not supported in the hardware and can
simplify the code that way.

And let's add also emufree_shift as the dts files will be describing the
hardware for the SYSCONFIG register capbilities mask.

Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/mach-omap2/omap_hwmod.c             |  2 ++
 arch/arm/mach-omap2/omap_hwmod.h             | 40 +++++++---------------------
 arch/arm/mach-omap2/omap_hwmod_common_data.c | 21 ++++++++-------
 include/linux/platform_data/ti-sysc.h        | 29 ++++++++++++++++++++
 4 files changed, 53 insertions(+), 39 deletions(-)
 create mode 100644 include/linux/platform_data/ti-sysc.h

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -143,6 +143,8 @@
 #include <linux/of_address.h>
 #include <linux/bootmem.h>
 
+#include <linux/platform_data/ti-sysc.h>
+
 #include <asm/system_misc.h>
 
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -37,15 +37,15 @@
 
 struct omap_device;
 
-extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type1;
-extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2;
-extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type3;
-extern struct omap_hwmod_sysc_fields omap34xx_sr_sysc_fields;
-extern struct omap_hwmod_sysc_fields omap36xx_sr_sysc_fields;
-extern struct omap_hwmod_sysc_fields omap3_sham_sysc_fields;
-extern struct omap_hwmod_sysc_fields omap3xxx_aes_sysc_fields;
-extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_mcasp;
-extern struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_usb_host_fs;
+extern struct sysc_regbits omap_hwmod_sysc_type1;
+extern struct sysc_regbits omap_hwmod_sysc_type2;
+extern struct sysc_regbits omap_hwmod_sysc_type3;
+extern struct sysc_regbits omap34xx_sr_sysc_fields;
+extern struct sysc_regbits omap36xx_sr_sysc_fields;
+extern struct sysc_regbits omap3_sham_sysc_fields;
+extern struct sysc_regbits omap3xxx_aes_sysc_fields;
+extern struct sysc_regbits omap_hwmod_sysc_type_mcasp;
+extern struct sysc_regbits omap_hwmod_sysc_type_usb_host_fs;
 
 /*
  * OCP SYSCONFIG bit shifts/masks TYPE1. These are for IPs compliant
@@ -290,26 +290,6 @@ struct omap_hwmod_ocp_if {
 #define CLOCKACT_TEST_ICLK	0x2
 #define CLOCKACT_TEST_NONE	0x3
 
-/**
- * struct omap_hwmod_sysc_fields - hwmod OCP_SYSCONFIG register field offsets.
- * @midle_shift: Offset of the midle bit
- * @clkact_shift: Offset of the clockactivity bit
- * @sidle_shift: Offset of the sidle bit
- * @enwkup_shift: Offset of the enawakeup bit
- * @srst_shift: Offset of the softreset bit
- * @autoidle_shift: Offset of the autoidle bit
- * @dmadisable_shift: Offset of the dmadisable bit
- */
-struct omap_hwmod_sysc_fields {
-	u8 midle_shift;
-	u8 clkact_shift;
-	u8 sidle_shift;
-	u8 enwkup_shift;
-	u8 srst_shift;
-	u8 autoidle_shift;
-	u8 dmadisable_shift;
-};
-
 /**
  * struct omap_hwmod_class_sysconfig - hwmod class OCP_SYS* data
  * @rev_offs: IP block revision register offset (from module base addr)
@@ -341,7 +321,7 @@ struct omap_hwmod_class_sysconfig {
 	u32 sysc_offs;
 	u32 syss_offs;
 	u16 sysc_flags;
-	struct omap_hwmod_sysc_fields *sysc_fields;
+	struct sysc_regbits *sysc_fields;
 	u8 srst_udelay;
 	u8 idlemodes;
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.c b/arch/arm/mach-omap2/omap_hwmod_common_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.c
@@ -16,6 +16,9 @@
  * data and their integration with other OMAP modules and Linux.
  */
 
+#include <linux/types.h>
+#include <linux/platform_data/ti-sysc.h>
+
 #include "omap_hwmod.h"
 
 #include "omap_hwmod_common_data.h"
@@ -27,7 +30,7 @@
  * if the device ip is compliant with the original PRCM protocol
  * defined for OMAP2420.
  */
-struct omap_hwmod_sysc_fields omap_hwmod_sysc_type1 = {
+struct sysc_regbits omap_hwmod_sysc_type1 = {
 	.midle_shift	= SYSC_TYPE1_MIDLEMODE_SHIFT,
 	.clkact_shift	= SYSC_TYPE1_CLOCKACTIVITY_SHIFT,
 	.sidle_shift	= SYSC_TYPE1_SIDLEMODE_SHIFT,
@@ -43,7 +46,7 @@ struct omap_hwmod_sysc_fields omap_hwmod_sysc_type1 = {
  * device ip is compliant with the new PRCM protocol defined for new
  * OMAP4 IPs.
  */
-struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2 = {
+struct sysc_regbits omap_hwmod_sysc_type2 = {
 	.midle_shift	= SYSC_TYPE2_MIDLEMODE_SHIFT,
 	.sidle_shift	= SYSC_TYPE2_SIDLEMODE_SHIFT,
 	.srst_shift	= SYSC_TYPE2_SOFTRESET_SHIFT,
@@ -54,7 +57,7 @@ struct omap_hwmod_sysc_fields omap_hwmod_sysc_type2 = {
  * struct omap_hwmod_sysc_type3 - TYPE3 sysconfig scheme.
  * Used by some IPs on AM33xx
  */
-struct omap_hwmod_sysc_fields omap_hwmod_sysc_type3 = {
+struct sysc_regbits omap_hwmod_sysc_type3 = {
 	.midle_shift	= SYSC_TYPE3_MIDLEMODE_SHIFT,
 	.sidle_shift	= SYSC_TYPE3_SIDLEMODE_SHIFT,
 };
@@ -64,32 +67,32 @@ struct omap_dss_dispc_dev_attr omap2_3_dss_dispc_dev_attr = {
 	.has_framedonetv_irq	= 0
 };
 
-struct omap_hwmod_sysc_fields omap34xx_sr_sysc_fields = {
+struct sysc_regbits omap34xx_sr_sysc_fields = {
 	.clkact_shift	= 20,
 };
 
-struct omap_hwmod_sysc_fields omap36xx_sr_sysc_fields = {
+struct sysc_regbits omap36xx_sr_sysc_fields = {
 	.sidle_shift	= 24,
 	.enwkup_shift	= 26,
 };
 
-struct omap_hwmod_sysc_fields omap3_sham_sysc_fields = {
+struct sysc_regbits omap3_sham_sysc_fields = {
 	.sidle_shift	= 4,
 	.srst_shift	= 1,
 	.autoidle_shift	= 0,
 };
 
-struct omap_hwmod_sysc_fields omap3xxx_aes_sysc_fields = {
+struct sysc_regbits omap3xxx_aes_sysc_fields = {
 	.sidle_shift	= 6,
 	.srst_shift	= 1,
 	.autoidle_shift	= 0,
 };
 
-struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_mcasp = {
+struct sysc_regbits omap_hwmod_sysc_type_mcasp = {
 	.sidle_shift	= 0,
 };
 
-struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_usb_host_fs = {
+struct sysc_regbits omap_hwmod_sysc_type_usb_host_fs = {
 	.midle_shift	= 4,
 	.sidle_shift	= 2,
 	.srst_shift	= 1,
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
new file mode 100644
--- /dev/null
+++ b/include/linux/platform_data/ti-sysc.h
@@ -0,0 +1,29 @@
+#ifndef __TI_SYSC_DATA_H__
+#define __TI_SYSC_DATA_H__
+
+/**
+ * struct sysc_regbits - TI OCP_SYSCONFIG register field offsets
+ * @midle_shift: Offset of the midle bit
+ * @clkact_shift: Offset of the clockactivity bit
+ * @sidle_shift: Offset of the sidle bit
+ * @enwkup_shift: Offset of the enawakeup bit
+ * @srst_shift: Offset of the softreset bit
+ * @autoidle_shift: Offset of the autoidle bit
+ * @dmadisable_shift: Offset of the dmadisable bit
+ * @emufree_shift; Offset of the emufree bit
+ *
+ * Note that 0 is a valid shift, and for ti-sysc.c -ENODEV can be used if a
+ * feature is not available.
+ */
+struct sysc_regbits {
+	s8 midle_shift;
+	s8 clkact_shift;
+	s8 sidle_shift;
+	s8 enwkup_shift;
+	s8 srst_shift;
+	s8 autoidle_shift;
+	s8 dmadisable_shift;
+	s8 emufree_shift;
+};
+
+#endif	/* __TI_SYSC_DATA_H__ */
-- 
2.15.0
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
