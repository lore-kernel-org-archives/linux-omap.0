From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 2/4] mfd: omap: control: core system
 control driver
Date: Fri, 10 Aug 2012 01:50:22 -0700
Message-ID: <20120810085022.GS11011@atomide.com>
References: <500FD2EC.7060208@dev.rtsoft.ru>
	<20120808140507.GF11011@atomide.com>
	<20120808141051.GG11011@atomide.com>
	<20120808143929.GJ11011@atomide.com>
	<50227ED9.3010508@dev.rtsoft.ru> <5023985F.3090606@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5023985F.3090606@dev.rtsoft.ru>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: amit.kucheria@linaro.org, kishon@ti.com, balbi@ti.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Konstantin Baydarov <kbaidarov@dev.rtsoft.ru> [120809 04:00]:
>   Hi, Tony.
> 
> On 08/08/2012 06:59 PM, Konstantin Baydarov wrote:
> >   Yes, omap_type() is called very early , that is why I'm using early_initcall for omap_control_base initialization.
> >
> > Do you mean following?:
> > void __init omap2_set_globals_control(struct omap_globals *omap2_globals)
> > {
> >     if (omap2_globals->ctrl)
> >         omap2_ctrl_base = omap2_globals->ctrl;
> >
> >     if (omap2_globals->ctrl_pad)
> >         omap4_ctrl_pad_base = omap2_globals->ctrl_pad;
> >
> >     omap_control_base = omap2_ctrl_base;  // this line is added
> > }
>   Sorry for the confusion - the code above isn't correct. First, as omap-control-core.c driver maps only control module status register the omap_control_base should be renamed to omap_control_status_reg:

Heh right :) And that makes the patch I posted wrong too.
 
> @@ -156,6 +158,20 @@ void __init omap2_set_globals_control(struct omap_globals *omap2_globals)
>  
>  	if (omap2_globals->ctrl_pad)
>  		omap4_ctrl_pad_base = omap2_globals->ctrl_pad;
> +
> +	omap_control_status_reg = omap2_ctrl_base;
> +	if (cpu_is_omap24xx())
> +		omap_control_status_reg += OMAP24XX_CONTROL_STATUS;
> +	else if (soc_is_am33xx())
> +		omap_control_status_reg += AM33XX_CONTROL_STATUS;
> +	else if (cpu_is_omap34xx())
> +		omap_control_status_reg += OMAP343X_CONTROL_STATUS;
> +	else if (cpu_is_omap44xx())
> +		omap_control_status_reg += OMAP4_CTRL_MODULE_CORE_STATUS;
> +	else if (soc_is_omap54xx())
> +		omap_control_status_reg += OMAP5XXX_CONTROL_STATUS;
> +	else
> +		omap_control_status_reg = 0;
>  }

We can get rid of the if else SoC check here too. And we can limit the
control_status tinkering to id.c. Here's an updated clean-up patch.

Regards,

Tony
 

From: Tony Lindgren <tony@atomide.com>
Date: Wed, 8 Aug 2012 23:13:03 -0700
Subject: [PATCH] ARM: OMAP2+: Initialize things for omap_type() to simplify
 SoC detection

Let's rename omap2_set_globals_tap() to omap2_set_globals_id() and update
the comments to remove old comments about map_io() as we don't need SoC
detection for map_io() any longer.

Let's also initialize control_status_reg with omap2_set_globals_id()
so we can avoid SoC tests every time omap_type() gets called.

Note that this patch sets the ti81xx to always return GP mode as
the mode bits seem to be marked as reserved in ti81xx TRM.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 069f972..64afeee 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -31,7 +31,7 @@
 
 static void __init __omap2_set_globals(struct omap_globals *omap2_globals)
 {
-	omap2_set_globals_tap(omap2_globals);
+	omap2_set_globals_id(omap2_globals);
 	omap2_set_globals_sdrc(omap2_globals);
 	omap2_set_globals_control(omap2_globals);
 	omap2_set_globals_prcm(omap2_globals);
@@ -45,6 +45,8 @@ static struct omap_globals omap242x_globals = {
 	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP2420_SDRC_BASE),
 	.sms	= OMAP2_L3_IO_ADDRESS(OMAP2420_SMS_BASE),
 	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE),
+	.ctrl_status	= OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE) +
+				OMAP24XX_CONTROL_STATUS,
 	.prm	= OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE),
 	.cm	= OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE),
 };
@@ -68,6 +70,8 @@ static struct omap_globals omap243x_globals = {
 	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP243X_SDRC_BASE),
 	.sms	= OMAP2_L3_IO_ADDRESS(OMAP243X_SMS_BASE),
 	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE),
+	.ctrl_status	= OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE) +
+				OMAP24XX_CONTROL_STATUS,
 	.prm	= OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE),
 	.cm	= OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE),
 };
@@ -91,6 +95,8 @@ static struct omap_globals omap3_globals = {
 	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP343X_SDRC_BASE),
 	.sms	= OMAP2_L3_IO_ADDRESS(OMAP343X_SMS_BASE),
 	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE),
+	.ctrl_status	= OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE) +
+				OMAP343X_CONTROL_STATUS,
 	.prm	= OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE),
 	.cm	= OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE),
 };
@@ -117,6 +123,8 @@ static struct omap_globals ti81xx_globals = {
 	.class  = OMAP343X_CLASS,
 	.tap    = OMAP2_L4_IO_ADDRESS(TI81XX_TAP_BASE),
 	.ctrl   = OMAP2_L4_IO_ADDRESS(TI81XX_CTRL_BASE),
+	.ctrl_status   = OMAP2_L4_IO_ADDRESS(TI81XX_CTRL_BASE) +
+				TI81XX_CONTROL_STATUS,
 	.prm    = OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE),
 	.cm     = OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE),
 };
@@ -140,6 +148,8 @@ static struct omap_globals am33xx_globals = {
 	.class  = AM335X_CLASS,
 	.tap    = AM33XX_L4_WK_IO_ADDRESS(AM33XX_TAP_BASE),
 	.ctrl   = AM33XX_L4_WK_IO_ADDRESS(AM33XX_CTRL_BASE),
+	.ctrl_status = AM33XX_L4_WK_IO_ADDRESS(AM33XX_CTRL_BASE) +
+			AM33XX_CONTROL_STATUS,
 	.prm    = AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRCM_BASE),
 	.cm     = AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRCM_BASE),
 };
@@ -160,6 +170,8 @@ static struct omap_globals omap4_globals = {
 	.class	= OMAP443X_CLASS,
 	.tap	= OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
 	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
+	.ctrl_status	= OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE) +
+				OMAP4_CTRL_MODULE_CORE_STATUS,
 	.ctrl_pad	= OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BASE),
 	.prm	= OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE),
 	.cm	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
@@ -183,6 +195,8 @@ static struct omap_globals omap5_globals = {
 	.class	= OMAP54XX_CLASS,
 	.tap	= OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
 	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
+	.ctrl_status	= OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE) +
+				OMAP5XXX_CONTROL_STATUS,
 	.ctrl_pad	= OMAP2_L4_IO_ADDRESS(OMAP54XX_CTRL_BASE),
 	.prm	= OMAP2_L4_IO_ADDRESS(OMAP54XX_PRM_BASE),
 	.cm	= OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_AON_BASE),
@@ -192,7 +206,7 @@ static struct omap_globals omap5_globals = {
 
 void __init omap2_set_globals_5xxx(void)
 {
-	omap2_set_globals_tap(&omap5_globals);
+	omap2_set_globals_id(&omap5_globals);
 	omap2_set_globals_control(&omap5_globals);
 	omap2_set_globals_prcm(&omap5_globals);
 }
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 1f65b18..a3cee8c 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -168,6 +168,7 @@ struct omap_globals {
 	void __iomem	*sdrc;           /* SDRAM Controller */
 	void __iomem	*sms;            /* SDRAM Memory Scheduler */
 	void __iomem	*ctrl;           /* System Control Module */
+	void __iomem	*ctrl_status;	/* Control status register */
 	void __iomem	*ctrl_pad;	/* PAD Control Module */
 	void __iomem	*prm;            /* Power and Reset Management */
 	void __iomem	*cm;             /* Clock Management */
@@ -184,7 +185,7 @@ void omap2_set_globals_ti81xx(void);
 void omap2_set_globals_am33xx(void);
 
 /* These get called from omap2_set_globals_xxxx(), do not call these */
-void omap2_set_globals_tap(struct omap_globals *);
+void omap2_set_globals_id(struct omap_globals *);
 #if defined(CONFIG_SOC_HAS_OMAP2_SDRC)
 void omap2_set_globals_sdrc(struct omap_globals *);
 #else
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index b8cdc85..cf92e06 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -59,6 +59,7 @@
 
 /* TI81XX spefic control submodules */
 #define TI81XX_CONTROL_DEVCONF		0x600
+#define TI81XX_CONTROL_STATUS		0x040
 
 /* Control register offsets - read/write with omap_ctrl_{read,write}{bwl}() */
 
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 40373db..19cc66d 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -29,6 +29,7 @@
 #include "control.h"
 
 static unsigned int omap_revision;
+static unsigned int control_status;
 static const char *cpu_rev;
 u32 omap_features;
 
@@ -40,31 +41,13 @@ EXPORT_SYMBOL(omap_rev);
 
 int omap_type(void)
 {
-	u32 val = 0;
-
-	if (cpu_is_omap24xx()) {
-		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
-	} else if (soc_is_am33xx()) {
-		val = omap_ctrl_readl(AM33XX_CONTROL_STATUS);
-	} else if (cpu_is_omap34xx()) {
-		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
-	} else if (cpu_is_omap44xx()) {
-		val = omap_ctrl_readl(OMAP4_CTRL_MODULE_CORE_STATUS);
-	} else if (soc_is_omap54xx()) {
-		val = omap_ctrl_readl(OMAP5XXX_CONTROL_STATUS);
-		val &= OMAP5_DEVICETYPE_MASK;
-		val >>= 6;
-		goto out;
-	} else {
-		pr_err("Cannot detect omap type!\n");
-		goto out;
+	if (!control_status) {
+		pr_err("Uninitialized control_status!\n");
+		WARN_ON(1);
+		return 0;
 	}
 
-	val &= OMAP2_DEVICETYPE_MASK;
-	val >>= 8;
-
-out:
-	return val;
+	return control_status;
 }
 EXPORT_SYMBOL(omap_type);
 
@@ -554,13 +537,9 @@ void __init omap5xxx_check_revision(void)
 }
 
 /*
- * Set up things for map_io and processor detection later on. Gets called
- * pretty much first thing from board init. For multi-omap, this gets
- * cpu_is_omapxxxx() working accurately enough for map_io. Then we'll try to
- * detect the exact revision later on in omap2_detect_revision() once map_io
- * is done.
+ * Initialize things for SoC detecttion. Gets called from init_early.
  */
-void __init omap2_set_globals_tap(struct omap_globals *omap2_globals)
+void __init omap2_set_globals_id(struct omap_globals *omap2_globals)
 {
 	omap_revision = omap2_globals->class;
 	tap_base = omap2_globals->tap;
@@ -569,4 +548,16 @@ void __init omap2_set_globals_tap(struct omap_globals *omap2_globals)
 		tap_prod_id = 0x0210;
 	else
 		tap_prod_id = 0x0208;
+
+	control_status = __raw_readl(omap2_globals->ctrl_status);
+	if (cpu_is_ti81xx()) {
+		/* At least ti81xx TRM sprugx8.pdf lists type bits as reserved */
+		control_status = OMAP2_DEVICE_TYPE_GP;
+	} else if (soc_is_omap54xx()) {
+		control_status &= OMAP5_DEVICETYPE_MASK;
+		control_status >>= 6;
+	} else {
+		control_status &= OMAP2_DEVICETYPE_MASK;
+		control_status >>= 8;
+	}
 }
