From: Tony Lindgren <tony@atomide.com>
Subject: Re: [linux-pm] [PATCH v4 2/4] mfd: omap: control: core system
 control driver
Date: Wed, 8 Aug 2012 23:18:13 -0700
Message-ID: <20120809061813.GK11011@atomide.com>
References: <500FD2EC.7060208@dev.rtsoft.ru>
 <20120808140507.GF11011@atomide.com>
 <20120808141051.GG11011@atomide.com>
 <20120808143929.GJ11011@atomide.com>
 <50227ED9.3010508@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:34973 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738Ab2HIGST (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Aug 2012 02:18:19 -0400
Content-Disposition: inline
In-Reply-To: <50227ED9.3010508@dev.rtsoft.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: balbi@ti.com, kishon@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Konstantin Baydarov <kbaidarov@dev.rtsoft.ru> [120808 07:59]:
> On 08/08/2012 06:39 PM, Tony Lindgren wrote:
> 
> Yes, omap_type() is called very early , that is why I'm using early_initcall
> for omap_control_base initialization.
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

OK so we already have set_globals_control, but we're not using it..
No need for this line is added above.

Let's do the attached clean-up patch and just leave omap_control_base
out of the driver for now as it's not currently needed there.

If omap_control_base is needed in the driver, then we need to pass
it in the platform_data to the driver for the non-DT boot case, or
parse it from DT like you're doing.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Wed, 8 Aug 2012 23:13:03 -0700
Subject: [PATCH] ARM: OMAP2+: Change omap_type() to use omap_ctrl_base_get()

We have the SoC specific ctrl_base already initialized in
set_globals.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -42,28 +42,20 @@ int omap_type(void)
 {
 	u32 val = 0;
 
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
+	val = __raw_readl(omap_ctrl_base_get());
+	if (!val) {
+		pr_err("Cannot detect omap type!\n");
+		return 0;
+	}
+
+	if (soc_is_omap54xx()) {
 		val &= OMAP5_DEVICETYPE_MASK;
 		val >>= 6;
-		goto out;
 	} else {
-		pr_err("Cannot detect omap type!\n");
-		goto out;
+		val &= OMAP2_DEVICETYPE_MASK;
+		val >>= 8;
 	}
 
-	val &= OMAP2_DEVICETYPE_MASK;
-	val >>= 8;
-
-out:
 	return val;
 }
 EXPORT_SYMBOL(omap_type);
