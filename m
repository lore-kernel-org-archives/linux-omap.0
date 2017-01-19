From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] arm: davinci: Make the usb20 clock available to PM runtime
Date: Thu, 19 Jan 2017 18:31:55 +0100
Message-ID: <20170119173155.5599-1-abailon@baylibre.com>
References: <fe7720b2-5623-1b14-6d4c-965eeeceecd4@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fe7720b2-5623-1b14-6d4c-965eeeceecd4-l0cyMroinI0@public.gmane.org>
In-Reply-To: <fe7720b2-5623-1b14-6d4c-965eeeceecd4-l0cyMroinI0@public.gmane.org>
References: <fe7720b2-5623-1b14-6d4c-965eeeceecd4-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: grygorii.strashko-l0cyMroinI0@public.gmane.org
Cc: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 01/19/2017 05:49 PM, Grygorii Strashko wrote:
> On 01/19/2017 09:08 AM, Alexandre Bailon wrote:
>> On 01/19/2017 03:48 PM, Sekhar Nori wrote:
>>> On Thursday 19 January 2017 07:39 PM, Alexandre Bailon wrote:
>>>> Add usb20 to the list of clock supported by PM runtime.
>>>>
>>>> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>>>> ---
>>>>  arch/arm/mach-davinci/pm_domain.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/mach-davinci/pm_domain.c b/arch/arm/mach-davinci/pm_domain.c
>>>> index 78eac2c..66471f2 100644
>>>> --- a/arch/arm/mach-davinci/pm_domain.c
>>>> +++ b/arch/arm/mach-davinci/pm_domain.c
>>>> @@ -23,7 +23,7 @@ static struct dev_pm_domain davinci_pm_domain = {
>>>>  
>>>>  static struct pm_clk_notifier_block platform_bus_notifier = {
>>>>  	.pm_domain = &davinci_pm_domain,
>>>> -	.con_ids = { "fck", "master", "slave", NULL },
>>>> +	.con_ids = { "fck", "master", "slave", "usb20", NULL },
>>>
>>> Instead of doing this, can we drop the con_id from musb clock? Looking
>>> at the USB clocking diagram in the TRM. There is a single clock input to
>>> the USB 2.0 subsystem. There is no real need for a con_id at all.
>> Currently, the con_id is required to get the usb20 clock from usb-da8xx.c
>> I will try to figure out which changes are required remove con_id.
> 
> It most probably should be renamed to "fck" then it should work with your
> patch "[PATCH v3 5/5] usb: musb: da8xx: Add a primary support of PM runtime".
Actually, because of the USB phy, more changes are required.
Something like that works for me.
---
 arch/arm/mach-davinci/da850.c     |  8 --------
 arch/arm/mach-davinci/usb-da8xx.c | 36 ++++++++++++++++++++++--------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 1d873d1..c143591 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -394,13 +394,6 @@ static struct clk usb11_clk = {
 	.gpsc		= 1,
 };
 
-static struct clk usb20_clk = {
-	.name		= "usb20",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC1_USB20,
-	.gpsc		= 1,
-};
-
 static struct clk spi0_clk = {
 	.name		= "spi0",
 	.parent		= &pll0_sysclk2,
@@ -567,7 +560,6 @@ static struct clk_lookup da850_clks[] = {
 	 */
 	CLK(NULL,		"aemif",	&aemif_nand_clk),
 	CLK("ohci-da8xx",	"usb11",	&usb11_clk),
-	CLK("musb-da8xx",	"usb20",	&usb20_clk),
 	CLK("spi_davinci.0",	NULL,		&spi0_clk),
 	CLK("spi_davinci.1",	NULL,		&spi1_clk),
 	CLK("vpif",		NULL,		&vpif_clk),
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index 9a6af0b..421b4a1 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -16,13 +16,19 @@
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
 #include <mach/irqs.h>
+#include "psc.h"
 
 #include "clock.h"
 
 #define DA8XX_USB0_BASE		0x01e00000
 #define DA8XX_USB1_BASE		0x01e25000
 
-static struct clk *usb20_clk;
+static struct clk usb20_clk = {
+	.name		= "usb20",
+	.parent		= NULL,
+	.lpsc		= DA8XX_LPSC1_USB20,
+	.gpsc		= 1,
+};
 
 static struct platform_device da8xx_usb_phy = {
 	.name		= "da8xx-usb-phy",
@@ -166,7 +172,7 @@ static void usb20_phy_clk_enable(struct clk *clk)
 	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
 
 	/* The USB 2.O PLL requires that the USB 2.O PSC is enabled as well. */
-	davinci_clk_enable(usb20_clk);
+	davinci_clk_enable(&usb20_clk);
 
 	/*
 	 * Turn on the USB 2.0 PHY, but just the PLL, and not OTG. The USB 1.1
@@ -186,7 +192,7 @@ static void usb20_phy_clk_enable(struct clk *clk)
 
 	pr_err("Timeout waiting for USB 2.0 PHY clock good\n");
 done:
-	davinci_clk_disable(usb20_clk);
+	davinci_clk_disable(&usb20_clk);
 }
 
 static void usb20_phy_clk_disable(struct clk *clk)
@@ -261,8 +267,10 @@ static struct clk usb20_phy_clk = {
 	.set_parent	= usb20_phy_clk_set_parent,
 };
 
-static struct clk_lookup usb20_phy_clk_lookup =
-	CLK("da8xx-usb-phy", "usb20_phy", &usb20_phy_clk);
+static struct clk_lookup usb20_clks[] = {
+	CLK("da8xx-usb-phy", "usb20_phy", &usb20_phy_clk),
+	CLK("musb-da8xx", NULL, &usb20_clk),
+};
 
 /**
  * da8xx_register_usb20_phy_clk - register USB0PHYCLKMUX clock
@@ -275,25 +283,25 @@ int __init da8xx_register_usb20_phy_clk(bool use_usb_refclkin)
 	struct clk *parent;
 	int ret;
 
-	usb20_clk = clk_get(&da8xx_usb20_dev.dev, "usb20");
-	ret = PTR_ERR_OR_ZERO(usb20_clk);
+
+	parent = clk_get(NULL, "pll0_sysclk2");
+	ret = PTR_ERR_OR_ZERO(parent);
 	if (ret)
 		return ret;
 
+	usb20_clk.parent = parent;
+	clk_put(parent);
+
 	parent = clk_get(NULL, use_usb_refclkin ? "usb_refclkin" : "pll0_aux");
 	ret = PTR_ERR_OR_ZERO(parent);
-	if (ret) {
-		clk_put(usb20_clk);
+	if (ret)
 		return ret;
-	}
 
 	usb20_phy_clk.parent = parent;
-	ret = clk_register(&usb20_phy_clk);
-	if (!ret)
-		clkdev_add(&usb20_phy_clk_lookup);
