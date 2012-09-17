From: Tony Lindgren <tony@atomide.com>
Subject: Re: [omap:tmp-merge 31/47] drivers/mfd/twl-core.c:49:22: fatal
 error: plat/cpu.h: No such file or directory
Date: Mon, 17 Sep 2012 12:42:28 -0700
Message-ID: <20120917194228.GS4521@atomide.com>
References: <20120917003526.GB12394@localhost>
 <20120917165643.GL4521@atomide.com>
 <20120917180014.GA15518@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44478 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932522Ab2IQTme (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Sep 2012 15:42:34 -0400
Content-Disposition: inline
In-Reply-To: <20120917180014.GA15518@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>, kernel-janitors@vger.kernel.org, linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [120917 11:05]:
> Hi,
> 
> On Mon, Sep 17, 2012 at 09:56:43AM -0700, Tony Lindgren wrote:
> > * Fengguang Wu <fengguang.wu@intel.com> [120916 17:41]:
> > > Hi Tony,
> > > 
> > > FYI, kernel build failed on
> > > 
> > > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git tmp-merge
> > > head:   a742996f4643b4e9612fe081d146035964cfbd87
> > > commit: 7d7e1eba7e92c2f9c76db80adc24836e7a114bfb [31/47] ARM: OMAP2+: Prepare for irqs.h removal
> > > config: x86_64-randconfig-s331 (attached as .config)
> > > 
> > > All related error/warning messages:
> > > 
> > > drivers/mfd/twl-core.c:49:22: fatal error: plat/cpu.h: No such file or directory
> > > compilation terminated.
> > > 
> > > vim +49 drivers/mfd/twl-core.c
> > >     44	#include <linux/regulator/machine.h>
> > >     45	
> > >     46	#include <linux/i2c.h>
> > >     47	#include <linux/i2c/twl.h>
> > >     48	
> > >   > 49	#include <plat/cpu.h>
> > >     50	
> > >     51	#include "twl-core.h"
> > >     52	
> > >     53	/*
> > >     54	 * The TWL4030 "Triton 2" is one of a family of a multi-function "Power
> > 
> > OK thanks for letting me know. That include needs to be ifdeffed until
> > we remove all cpu_is_omap usage from drivers. I'll take a look and will
> > also check if other drivers may have the same issue.
> 
> the only use of cpu_is_* in that driver is related to the osc_ck clock
> name. Isn't this enough ?

Well there's a bit more to it, see below..

> --- a/arch/arm/mach-omap2/clock2430_data.c
> +++ b/arch/arm/mach-omap2/clock2430_data.c
> @@ -1855,7 +1855,7 @@ static struct omap_clk omap2430_clks[] = {
>  	/* external root sources */
>  	CLK(NULL,	"func_32k_ck",	&func_32k_ck,	CK_243X),
>  	CLK(NULL,	"secure_32k_ck", &secure_32k_ck, CK_243X),
> -	CLK(NULL,	"osc_ck",	&osc_ck,	CK_243X),
> +	CLK(NULL,	"osc_sys_ck",	&osc_ck,	CK_243X),
>  	CLK(NULL,	"sys_ck",	&sys_ck,	CK_243X),
>  	CLK(NULL,	"alt_ck",	&alt_ck,	CK_243X),
>  	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks,	CK_243X),

That's also in use in the pm24xx code.. And is not a generic name
for other SoCs potentially using it. I have something like this here,
but now MMC somehow breaks on 2430sdp that I need to figure out..

Tony


>From 292156f6265e3b5446747de41038a19ef476b650 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 17 Sep 2012 10:47:16 -0700
Subject: [PATCH] mfd: Fix compile for twl-core.c by removing cpu_is_omap
 usage

Commit 7d7e1eba (ARM: OMAP2+: Prepare for irqs.h removal) broke
compile for non-omap as include plat/cpu.h was added. This header
was indirectly included earlier when SPARSE_IRQ was not set, but
does not exist on most platforms.

Fix the problem by removing the cpu_is_omap usage that should
not exist in drivers at all. We can do this by adding proper
clock aliases for the twl-core.c drivers, and drop separate
handling for cases when clock framework is not available as
the behaviour will stay the same.

Note that we need to add a platform device to avoid using the
i2c provided names that may be different on various omaps.

diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 02fe1f2..7ea9139 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1856,6 +1856,7 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"func_32k_ck",	&func_32k_ck,	CK_243X),
 	CLK(NULL,	"secure_32k_ck", &secure_32k_ck, CK_243X),
 	CLK(NULL,	"osc_ck",	&osc_ck,	CK_243X),
+	CLK("twl",	"fck",		&osc_ck,	CK_243X),
 	CLK(NULL,	"sys_ck",	&sys_ck,	CK_243X),
 	CLK(NULL,	"alt_ck",	&alt_ck,	CK_243X),
 	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks,	CK_243X),
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 10a2398..700317a 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3226,6 +3226,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"virt_26000000_ck",	&virt_26000000_ck,	CK_3XXX),
 	CLK(NULL,	"virt_38_4m_ck", &virt_38_4m_ck, CK_3XXX),
 	CLK(NULL,	"osc_sys_ck",	&osc_sys_ck,	CK_3XXX),
+	CLK("twl",	"fck",		&osc_sys_ck,	CK_3XXX),
 	CLK(NULL,	"sys_ck",	&sys_ck,	CK_3XXX),
 	CLK(NULL,	"sys_altclk",	&sys_altclk,	CK_3XXX),
 	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks,	CK_3XXX),
diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index f462ff2..9d3a0bc 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -46,8 +46,6 @@
 #include <linux/i2c.h>
 #include <linux/i2c/twl.h>
 
-#include <plat/cpu.h>
-
 #include "twl-core.h"
 
 /*
@@ -1134,12 +1132,7 @@ static void clocks_init(struct device *dev,
 	u32 rate;
 	u8 ctrl = HFCLK_FREQ_26_MHZ;
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-	if (cpu_is_omap2430())
-		osc = clk_get(dev, "osc_ck");
-	else
-		osc = clk_get(dev, "osc_sys_ck");
-
+	osc = clk_get(dev, "fck");
 	if (IS_ERR(osc)) {
 		printk(KERN_WARNING "Skipping twl internal clock init and "
 				"using bootloader value (unknown osc rate)\n");
@@ -1149,18 +1142,6 @@ static void clocks_init(struct device *dev,
 	rate = clk_get_rate(osc);
 	clk_put(osc);
 
-#else
-	/* REVISIT for non-OMAP systems, pass the clock rate from
-	 * board init code, using platform_data.
-	 */
-	osc = ERR_PTR(-EIO);
-
-	printk(KERN_WARNING "Skipping twl internal clock init and "
-	       "using bootloader value (unknown osc rate)\n");
-
-	return;
-#endif
-
 	switch (rate) {
 	case 19200000:
 		ctrl = HFCLK_FREQ_19p2_MHZ;
@@ -1222,10 +1203,23 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct twl4030_platform_data	*pdata = client->dev.platform_data;
 	struct device_node		*node = client->dev.of_node;
+	struct platform_device		*pdev;
 	int				irq_base = 0;
 	int				status;
 	unsigned			i, num_slaves;
 
+	pdev = platform_device_alloc(DRIVER_NAME, -1);
+	if (!pdev) {
+		dev_err(&client->dev, "can't alloc pdev\n");
+		return -ENOMEM;
+	}
+
+	status = platform_device_add(pdev);
+	if (status) {
+		platform_device_put(pdev);
+		return status;
+	}
+
 	if (node && !pdata) {
 		/*
 		 * XXX: Temporary pdata until the information is correctly
@@ -1234,23 +1228,30 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		pdata = devm_kzalloc(&client->dev,
 				     sizeof(struct twl4030_platform_data),
 				     GFP_KERNEL);
-		if (!pdata)
-			return -ENOMEM;
+		if (!pdata) {
+			status = -ENOMEM;
+			goto free;
+		}
 	}
 
 	if (!pdata) {
 		dev_dbg(&client->dev, "no platform data?\n");
-		return -EINVAL;
+		status = -EINVAL;
+		goto free;
 	}
 
+	platform_set_drvdata(pdev, pdata);
+
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) == 0) {
 		dev_dbg(&client->dev, "can't talk I2C?\n");
-		return -EIO;
+		status = -EIO;
+		goto free;
 	}
 
 	if (inuse) {
 		dev_dbg(&client->dev, "driver is already in use\n");
-		return -EBUSY;
+		status = -EBUSY;
+		goto free;
 	}
 
 	if ((id->driver_data) & TWL6030_CLASS) {
@@ -1285,7 +1286,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	inuse = true;
 
 	/* setup clock framework */
-	clocks_init(&client->dev, pdata->clock);
+	clocks_init(&pdev->dev, pdata->clock);
 
 	/* read TWL IDCODE Register */
 	if (twl_id == TWL4030_CLASS_ID) {
@@ -1335,6 +1336,9 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 fail:
 	if (status < 0)
 		twl_remove(client);
+free:
+	if (status < 0)
+		platform_device_unregister(pdev);
 
 	return status;
 }
