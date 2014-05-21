From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/7] mfd: twl4030-power: Add recommended idle
 configuration
Date: Tue, 20 May 2014 19:44:02 -0700
Message-ID: <20140521024402.GC17417@atomide.com>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
 <1400031250-29542-5-git-send-email-tony@atomide.com>
 <20140520151428.GZ24991@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65066 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbaEUCoL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2014 22:44:11 -0400
Content-Disposition: inline
In-Reply-To: <20140520151428.GZ24991@lee--X1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>, Samuel Ortiz <sameo@linux.intel.com>

* Lee Jones <lee.jones@linaro.org> [140520 08:15]:
> 
> Assuming the magic numbers are replaced by transparent #defines:
> 
>   Acked-by: Lee Jones <lee.jones@linaro.org>

Updated the defines to use a define for the default delay. Did
not touch the number for resource group init order but added some
comments for those. Updated patch below.

Regards,

Tony

8< --------------------------
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 20 May 2014 11:17:54 -0700
Subject: [PATCH] mfd: twl4030-power: Add recommended idle configuration

These settings are based on the "Recommended Sleep Sequences for
the Zoom Platform".

The settings assume most of the regulators are under control of
Linux, and twl4030 only cuts off VDD1 and VDD2 during off-idle as
Linux cannot do it.

For any board specific changes to these, let's patch them in as
changes to the generic data in the follow-up patches. This keeps
the board specific changes small.

Note that this does not consider the twl5030 errata 27 and 28.
That can be added later on after it has been tested. For more
information about errata 27 and 28.

Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/Documentation/devicetree/bindings/mfd/twl4030-power.txt
+++ b/Documentation/devicetree/bindings/mfd/twl4030-power.txt
@@ -8,10 +8,14 @@ Required properties:
 - compatible : must be one of the following
 	"ti,twl4030-power"
 	"ti,twl4030-power-reset"
+	"ti,twl4030-power-idle"
 
 The use of ti,twl4030-power-reset is recommended at least on
 3530 that needs a special configuration for warm reset to work.
 
+When using ti,twl4030-power-idle, the TI recommended configuration
+for idle modes is loaded to the tlw4030 PMIC.
+
 Optional properties:
 - ti,use_poweroff: With this flag, the chip will initiates an ACTIVE-to-OFF or
 		   SLEEP-to-OFF transition when the system poweroffs.
diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index cb5b0cb..2bfbb40 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -145,6 +145,7 @@ enum {
  * omap3 has been made DT only.
  */
 #define TWL_DFLT_DELAY		2	/* typically 2 32 KiHz cycles */
+#define TWL_DEV_GRP_P123	(DEV_GRP_P1 | DEV_GRP_P2 | DEV_GRP_P3)
 #define TWL_RESOURCE_SET(res, state)					\
 	{ MSG_SINGULAR(DEV_GRP_NULL, (res), (state)), TWL_DFLT_DELAY }
 #define TWL_RESOURCE_ON(res)	TWL_RESOURCE_SET(res, RES_STATE_ACTIVE)
@@ -154,14 +155,26 @@ enum {
  * It seems that type1 and type2 is just the resource init order
  * number for the type1 and type2 group.
  */
+#define TWL_RESOURCE_SET_ACTIVE(res, state)			       	\
+	{ MSG_SINGULAR(DEV_GRP_NULL, (res), RES_STATE_ACTIVE), (state) }
 #define TWL_RESOURCE_GROUP_RESET(group, type1, type2)			\
 	{ MSG_BROADCAST(DEV_GRP_NULL, (group), (type1), (type2),	\
 		RES_STATE_WRST), TWL_DFLT_DELAY }
+#define TWL_RESOURCE_GROUP_SLEEP(group, type, type2)			\
+	{ MSG_BROADCAST(DEV_GRP_NULL, (group), (type), (type2),		\
+		RES_STATE_SLEEP), TWL_DFLT_DELAY }
+#define TWL_RESOURCE_GROUP_ACTIVE(group, type, type2)			\
+	{ MSG_BROADCAST(DEV_GRP_NULL, (group), (type), (type2),		\
+		RES_STATE_ACTIVE), TWL_DFLT_DELAY }
 #define TWL_REMAP_SLEEP(res, devgrp, typ, typ2)				\
 	{ .resource = (res), .devgroup = (devgrp),			\
 	  .type = (typ), .type2 = (typ2),				\
 	  .remap_off = TWL_REMAP_OFF,					\
 	  .remap_sleep = TWL_REMAP_SLEEP, }
+#define TWL_REMAP_OFF(res, devgrp, typ, typ2)				\
+	{ .resource = (res), .devgroup = (devgrp),			\
+	  .type = (typ), .type2 = (typ2),				\
+	  .remap_off = TWL_REMAP_OFF, .remap_sleep = TWL_REMAP_OFF, }
 
 static int twl4030_write_script_byte(u8 address, u8 byte)
 {
@@ -638,11 +651,104 @@ static struct twl4030_power_data omap3_reset = {
 	.resource_config	= omap3_rconfig,
 };
 
+/* Recommended generic default idle configuration for off-idle */
+
+/* Broadcast message to put res to sleep */
+static struct twl4030_ins omap3_idle_sleep_on_seq[] = {
+	TWL_RESOURCE_GROUP_SLEEP(RES_GRP_ALL, RES_TYPE_ALL, 0),
+};
+
+static struct twl4030_script omap3_idle_sleep_on_script = {
+	.script	= omap3_idle_sleep_on_seq,
+	.size	= ARRAY_SIZE(omap3_idle_sleep_on_seq),
+	.flags	= TWL4030_SLEEP_SCRIPT,
+};
+
+/* Broadcast message to put res to active */
+static struct twl4030_ins omap3_idle_wakeup_p12_seq[] = {
+	TWL_RESOURCE_GROUP_ACTIVE(RES_GRP_ALL, RES_TYPE_ALL, 0),
+};
+
+static struct twl4030_script omap3_idle_wakeup_p12_script = {
+	.script	= omap3_idle_wakeup_p12_seq,
+	.size	= ARRAY_SIZE(omap3_idle_wakeup_p12_seq),
+	.flags	= TWL4030_WAKEUP12_SCRIPT,
+};
+
+/* Broadcast message to put res to active */
+static struct twl4030_ins omap3_idle_wakeup_p3_seq[] = {
+	TWL_RESOURCE_SET_ACTIVE(RES_CLKEN, 0x37),
+	TWL_RESOURCE_GROUP_ACTIVE(RES_GRP_ALL, RES_TYPE_ALL, 0),
+};
+
+static struct twl4030_script omap3_idle_wakeup_p3_script = {
+	.script	= omap3_idle_wakeup_p3_seq,
+	.size	= ARRAY_SIZE(omap3_idle_wakeup_p3_seq),
+	.flags	= TWL4030_WAKEUP3_SCRIPT,
+};
+
+static struct twl4030_script *omap3_idle_scripts[] = {
+	&omap3_idle_wakeup_p12_script,
+	&omap3_idle_wakeup_p3_script,
+	&omap3_wrst_script,
+	&omap3_idle_sleep_on_script,
+};
+
+/*
+ * Recommended configuration based on "Recommended Sleep
+ * Sequences for the Zoom Platform":
+ * http://omappedia.com/wiki/File:Recommended_Sleep_Sequences_Zoom.pdf
+ * Note that the type1 and type2 seem to be just the init order number
+ * for type1 and type2 groups as specified in the document mentioned
+ * above.
+ */
+static struct twl4030_resconfig omap3_idle_rconfig[] = {
+	TWL_REMAP_SLEEP(RES_VAUX1, DEV_GRP_NULL, 0, 0),
+	TWL_REMAP_SLEEP(RES_VAUX2, DEV_GRP_NULL, 0, 0),
+	TWL_REMAP_SLEEP(RES_VAUX3, DEV_GRP_NULL, 0, 0),
+	TWL_REMAP_SLEEP(RES_VAUX4, DEV_GRP_NULL, 0, 0),
+	TWL_REMAP_SLEEP(RES_VMMC1, DEV_GRP_NULL, 0, 0),
+	TWL_REMAP_SLEEP(RES_VMMC2, DEV_GRP_NULL, 0, 0),
+	TWL_REMAP_OFF(RES_VPLL1, DEV_GRP_P1, 3, 1),
+	TWL_REMAP_SLEEP(RES_VPLL2, DEV_GRP_P1, 0, 0),
+	TWL_REMAP_SLEEP(RES_VSIM, DEV_GRP_NULL, 0, 0),
+	TWL_REMAP_SLEEP(RES_VDAC, DEV_GRP_NULL, 0, 0),
+	TWL_REMAP_SLEEP(RES_VINTANA1, TWL_DEV_GRP_P123, 1, 2),
+	TWL_REMAP_SLEEP(RES_VINTANA2, TWL_DEV_GRP_P123, 0, 2),
+	TWL_REMAP_SLEEP(RES_VINTDIG, TWL_DEV_GRP_P123, 1, 2),
+	TWL_REMAP_SLEEP(RES_VIO, TWL_DEV_GRP_P123, 2, 2),
+	TWL_REMAP_OFF(RES_VDD1, DEV_GRP_P1, 4, 1),
+	TWL_REMAP_OFF(RES_VDD2, DEV_GRP_P1, 3, 1),
+	TWL_REMAP_SLEEP(RES_VUSB_1V5, DEV_GRP_NULL, 0, 0),
+	TWL_REMAP_SLEEP(RES_VUSB_1V8, DEV_GRP_NULL, 0, 0),
+	TWL_REMAP_SLEEP(RES_VUSB_3V1, TWL_DEV_GRP_P123, 0, 0),
+	/* Resource #20 USB charge pump skipped */
+	TWL_REMAP_SLEEP(RES_REGEN, TWL_DEV_GRP_P123, 2, 1),
+	TWL_REMAP_SLEEP(RES_NRES_PWRON, TWL_DEV_GRP_P123, 0, 1),
+	TWL_REMAP_SLEEP(RES_CLKEN, TWL_DEV_GRP_P123, 3, 2),
+	TWL_REMAP_SLEEP(RES_SYSEN, TWL_DEV_GRP_P123, 6, 1),
+	TWL_REMAP_SLEEP(RES_HFCLKOUT, DEV_GRP_P3, 0, 2),
+	TWL_REMAP_SLEEP(RES_32KCLKOUT, TWL_DEV_GRP_P123, 0, 0),
+	TWL_REMAP_SLEEP(RES_RESET, TWL_DEV_GRP_P123, 6, 0),
+	TWL_REMAP_SLEEP(RES_MAIN_REF, TWL_DEV_GRP_P123, 0, 0),
+	{ /* Terminator */ },
+};
+
+static struct twl4030_power_data omap3_idle = {
+	.scripts		= omap3_idle_scripts,
+	.num			= ARRAY_SIZE(omap3_idle_scripts),
+	.resource_config	= omap3_idle_rconfig,
+};
+
 static struct of_device_id twl4030_power_of_match[] = {
 	{
 		.compatible = "ti,twl4030-power-reset",
 		.data = &omap3_reset,
 	},
+	{
+		.compatible = "ti,twl4030-power-idle",
+		.data = &omap3_idle,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, twl4030_power_of_match);
