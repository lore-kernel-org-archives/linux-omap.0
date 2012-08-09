From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: Re: [linux-pm] [PATCH v4 2/4] mfd: omap: control: core system control
 driver
Date: Thu, 09 Aug 2012 15:00:47 +0400
Message-ID: <5023985F.3090606@dev.rtsoft.ru>
References: <500FD2EC.7060208@dev.rtsoft.ru> <20120808140507.GF11011@atomide.com> <20120808141051.GG11011@atomide.com> <20120808143929.GJ11011@atomide.com> <50227ED9.3010508@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:38610 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757847Ab2HILAt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Aug 2012 07:00:49 -0400
In-Reply-To: <50227ED9.3010508@dev.rtsoft.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: balbi@ti.com, kishon@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  Hi, Tony.

On 08/08/2012 06:59 PM, Konstantin Baydarov wrote:
>   Yes, omap_type() is called very early , that is why I'm using early_initcall for omap_control_base initialization.
>
> Do you mean following?:
> void __init omap2_set_globals_control(struct omap_globals *omap2_globals)
> {
>     if (omap2_globals->ctrl)
>         omap2_ctrl_base = omap2_globals->ctrl;
>
>     if (omap2_globals->ctrl_pad)
>         omap4_ctrl_pad_base = omap2_globals->ctrl_pad;
>
>     omap_control_base = omap2_ctrl_base;  // this line is added
> }
  Sorry for the confusion - the code above isn't correct. First, as omap-control-core.c driver maps only control module status register the omap_control_base should be renamed to omap_control_status_reg:

--- a/drivers/mfd/omap-control-core.c
+++ b/drivers/mfd/omap-control-core.c
@@ -35,13 +35,15 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
-void __iomem *omap_control_base;
+void __iomem *omap_control_status_reg;
 unsigned long omap_control_phys_base;
 size_t omap_control_mapsize;
 
 u32 omap_control_status_read(void)


Then, if you want to move omap_control_status_reg(omap_control_base) initialization to the
omap2_set_globals_control(), it can be done following way:

--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -149,6 +149,8 @@ static struct omap3_control_regs control_context;
 #define OMAP_CTRL_REGADDR(reg)		(omap2_ctrl_base + (reg))
 #define OMAP4_CTRL_PAD_REGADDR(reg)	(omap4_ctrl_pad_base + (reg))
 
+extern void __iomem *omap_control_status_reg;
+
 void __init omap2_set_globals_control(struct omap_globals *omap2_globals)
 {
 	if (omap2_globals->ctrl)
@@ -156,6 +158,20 @@ void __init omap2_set_globals_control(struct omap_globals *omap2_globals)
 
 	if (omap2_globals->ctrl_pad)
 		omap4_ctrl_pad_base = omap2_globals->ctrl_pad;
+
+	omap_control_status_reg = omap2_ctrl_base;
+	if (cpu_is_omap24xx())
+		omap_control_status_reg += OMAP24XX_CONTROL_STATUS;
+	else if (soc_is_am33xx())
+		omap_control_status_reg += AM33XX_CONTROL_STATUS;
+	else if (cpu_is_omap34xx())
+		omap_control_status_reg += OMAP343X_CONTROL_STATUS;
+	else if (cpu_is_omap44xx())
+		omap_control_status_reg += OMAP4_CTRL_MODULE_CORE_STATUS;
+	else if (soc_is_omap54xx())
+		omap_control_status_reg += OMAP5XXX_CONTROL_STATUS;
+	else
+		omap_control_status_reg = 0;
 }
 
 void __iomem *omap_ctrl_base_get(void)


Then omap_type() can be changed:

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 8018cad..916b3f6 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -39,31 +39,27 @@ unsigned int omap_rev(void)
 }
 EXPORT_SYMBOL(omap_rev);
 
+extern void __iomem *omap_control_status_reg;
+
 int omap_type(void)
 {
 	u32 val = 0;
 
-	if (cpu_is_omap24xx()) {
-		val = omap_control_status_read();
-	} else if (soc_is_am33xx()) {
-		val = omap_control_status_read();
-	} else if (cpu_is_omap34xx()) {
-		val = omap_control_status_read();
-	} else if (cpu_is_omap44xx()) {
+	if(!omap_control_status_reg) {
+		pr_err("Cannot detect omap type!\n");
+		goto out;
+	}
+
+	if(!soc_is_omap54xx()) {
 		val = omap_control_status_read();
-	} else if (soc_is_omap54xx()) {
+		val &= OMAP2_DEVICETYPE_MASK;
+		val >>= 8;
+	} else {
 		val = omap_control_status_read();
 		val &= OMAP5_DEVICETYPE_MASK;
 		val >>= 6;
-		goto out;
-	} else {
-		pr_err("Cannot detect omap type!\n");
-		goto out;
 	}
 
-	val &= OMAP2_DEVICETYPE_MASK;
-	val >>= 8;
-
 out:
 	return val;
 }


  BR,
    Konstantin Baydarov.

>   Or you suggest to move
> void __init of_omap_control_init(const struct of_device_id *matches)
> {
>     struct device_node *np;
>     struct property *pp = 0;
>
>     for_each_matching_node(np, matches) {
>         pp = of_find_property(np, "reg", NULL);
>         if(pp) {
>             omap_control_phys_base = (unsigned long)be32_to_cpup(pp->value);
>             omap_control_mapsize = (size_t)be32_to_cpup( (void*)((char*)pp->value + 4) );
>             /*
>              * Map control module register CONTROL_STATUS register:
>              * omap24xx - OMAP24XX_CONTROL_STATUS
>              * am33xx   - AM33XX_CONTROL_STATUS
>              * omap34xx - OMAP343X_CONTROL_STATUS
>              * omap44xx - OMAP4_CTRL_MODULE_CORE_STATUS
>              * omap54xx - OMAP5XXX_CONTROL_STATUS
>              */
>             omap_control_base = ioremap(omap_control_phys_base, omap_control_mapsize);
>         }
>     }
> }
>
> into omap2_set_globals_control() ?
>
> Also if we move omap_control_base initialization to omap2_set_globals_control(), than the initialization routine of drivers/mfd/omap-control-core.c become empty, because omap_control_base is the only thing that is initialized in omap-control-core driver.
>
>   BR,
>     Konstantin Baydarov.
>
>> Regards,
>>
>> Tony
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

