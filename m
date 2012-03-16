From: Tony Lindgren <tony@atomide.com>
Subject: Re: smsc911x on Gumstix Overo/Tobi doesn't work
Date: Fri, 16 Mar 2012 12:33:38 -0700
Message-ID: <20120316193337.GE7276@atomide.com>
References: <4F6324D5.9010106@uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:39111 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757052Ab2CPTdk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Mar 2012 15:33:40 -0400
Content-Disposition: inline
In-Reply-To: <4F6324D5.9010106@uni-dortmund.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Klute <thomas2.klute@uni-dortmund.de>
Cc: linux-omap@vger.kernel.org

Hi,

* Thomas Klute <thomas2.klute@uni-dortmund.de> [120316 05:08]:
> Hi,
> 
> I have trouble getting the Ethernet port on a Gumstix Overo with Tobi
> expansion board to work with current kernel versions. With the latest
> commit from linux-omap git (b8fe1781ec8bed5e086691a827a6ee11facec2aa),
> the output from loading the smsc911x driver is as follows:
> 
> du14:~# modprobe smsc911x
> [  254.843811] smsc911x: Driver version 2008-10-21
> [  254.854553] smsc911x: Driver version 2008-10-21
> [  254.859588] _regulator_get: smsc911x.1 supply vdd33a not found, using
> dummy regulator
> [  254.868377] _regulator_get: smsc911x.1 supply vddvario not found,
> using dummy regulator
> 
> "ip link show" does not show any available Ethernet port.

The first instance one should work the same way as earlier using
fixed regulator in gpmc-smsc911x.c. Is it not working for you
somehow? At least it works for me on zoom3.
 
> I know there has been some trouble with changes around smsc911x
> regulator support and Gumstix Overo in particular. Am I just missing the
> right regulator in my kernel config or is this a bug? I can test patches
> in the latter case.

The second smsc911x now needs a regulator. For multiple smsc911x instances,
we should change things around so no regulator is created if one
is passed.

Care to test the following patch by passing a fixed regulator
from board-overo.c?

You can copy the fixed regulator from gpmc-smsc911x.c, or ideally pass
the real smsc911x controlling regulator for overo.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Fri, 16 Mar 2012 12:26:25 -0700
Subject: [PATCH] ARM: OMAP2+: Allow passing smsc911x regulator from boards

Otherwise we won't be able to properly support multiple
instances of smsc911x.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -97,17 +97,26 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
 {
 	struct platform_device *pdev;
 	unsigned long cs_mem_base;
+	struct platform_device *regulator = NULL;
 	int ret;
 
 	gpmc_cfg = board_data;
 
-	if (!gpmc_cfg->id) {
-		ret = platform_device_register(&gpmc_smsc911x_regulator);
-		if (ret < 0) {
-			pr_err("Unable to register smsc911x regulators: %d\n",
-			       ret);
-			return;
-		}
+	if (gpmc_cfg->regulator)
+		regulator = gpmc_cfg->regulator;
+	else if (!gpmc_cfg->id)
+		regulator = &gpmc_smsc911x_regulator;
+
+	if (!regulator) {
+		pr_err("Missing smsc911x regulator in board_data\n");
+		return;
+	}
+
+	ret = platform_device_register(regulator);
+	if (ret < 0) {
+		pr_err("Unable to register smsc911x regulators: %d\n",
+		       ret);
+		return;
 	}
 
 	if (gpmc_cs_request(gpmc_cfg->cs, SZ_16M, &cs_mem_base) < 0) {
--- a/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
+++ b/arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
@@ -19,6 +19,7 @@ struct omap_smsc911x_platform_data {
 	int	gpio_irq;
 	int	gpio_reset;
 	u32	flags;
+	struct platform_device *regulator;
 };
 
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
