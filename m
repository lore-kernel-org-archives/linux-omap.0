From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] arm: davinci: Make the usb20 clock available to PM
 runtime
Date: Fri, 20 Jan 2017 14:54:44 +0530
Message-ID: <ae1db9a1-5a33-0748-7e17-f8fdb524f62f@ti.com>
References: <fe7720b2-5623-1b14-6d4c-965eeeceecd4@ti.com>
 <20170119173155.5599-1-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170119173155.5599-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, grygorii.strashko-l0cyMroinI0@public.gmane.org
Cc: khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 19 January 2017 11:01 PM, Alexandre Bailon wrote:
> On 01/19/2017 05:49 PM, Grygorii Strashko wrote:
>> On 01/19/2017 09:08 AM, Alexandre Bailon wrote:
>>> On 01/19/2017 03:48 PM, Sekhar Nori wrote:
>>>> On Thursday 19 January 2017 07:39 PM, Alexandre Bailon wrote:
>>>>> Add usb20 to the list of clock supported by PM runtime.
>>>>>
>>>>> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>>>>> ---
>>>>>  arch/arm/mach-davinci/pm_domain.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-davinci/pm_domain.c b/arch/arm/mach-davinci/pm_domain.c
>>>>> index 78eac2c..66471f2 100644
>>>>> --- a/arch/arm/mach-davinci/pm_domain.c
>>>>> +++ b/arch/arm/mach-davinci/pm_domain.c
>>>>> @@ -23,7 +23,7 @@ static struct dev_pm_domain davinci_pm_domain = {
>>>>>  
>>>>>  static struct pm_clk_notifier_block platform_bus_notifier = {
>>>>>  	.pm_domain = &davinci_pm_domain,
>>>>> -	.con_ids = { "fck", "master", "slave", NULL },
>>>>> +	.con_ids = { "fck", "master", "slave", "usb20", NULL },
>>>>
>>>> Instead of doing this, can we drop the con_id from musb clock? Looking
>>>> at the USB clocking diagram in the TRM. There is a single clock input to
>>>> the USB 2.0 subsystem. There is no real need for a con_id at all.
>>> Currently, the con_id is required to get the usb20 clock from usb-da8xx.c
>>> I will try to figure out which changes are required remove con_id.
>>
>> It most probably should be renamed to "fck" then it should work with your
>> patch "[PATCH v3 5/5] usb: musb: da8xx: Add a primary support of PM runtime".

> Actually, because of the USB phy, more changes are required.
> Something like that works for me.

There are too many things going on in your patch and I am not clear why 
all of those changes are needed. The following diff worked for me on top
of master branch of my tree. Can you check if this works for you? If not,
I need some more explanation of why you are making all the changes that
you are.

Thanks,
Sekhar

---8<---
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 073c458d0c67..2cfd9d70a818 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -412,7 +412,7 @@ static struct clk_lookup da830_clks[] = {
 	CLK("davinci-mcasp.0",	NULL,		&mcasp0_clk),
 	CLK("davinci-mcasp.1",	NULL,		&mcasp1_clk),
 	CLK("davinci-mcasp.2",	NULL,		&mcasp2_clk),
-	CLK("musb-da8xx",	"usb20",	&usb20_clk),
+	CLK("musb-da8xx",	NULL,		&usb20_clk),
 	CLK(NULL,		"aemif",	&aemif_clk),
 	CLK(NULL,		"aintc",	&aintc_clk),
 	CLK(NULL,		"secu_mgr",	&secu_mgr_clk),
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 55f6e1172517..946cd06d8c05 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -567,7 +567,7 @@ static struct clk_lookup da850_clks[] = {
 	 */
 	CLK(NULL,		"aemif",	&aemif_nand_clk),
 	CLK("ohci-da8xx",	"usb11",	&usb11_clk),
-	CLK("musb-da8xx",	"usb20",	&usb20_clk),
+	CLK("musb-da8xx",	NULL,		&usb20_clk),
 	CLK("spi_davinci.0",	NULL,		&spi0_clk),
 	CLK("spi_davinci.1",	NULL,		&spi1_clk),
 	CLK("vpif",		NULL,		&vpif_clk),
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index 9a6af0bd5dc3..9b667689b665 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -275,7 +275,7 @@ int __init da8xx_register_usb20_phy_clk(bool use_usb_refclkin)
 	struct clk *parent;
 	int ret;
 
-	usb20_clk = clk_get(&da8xx_usb20_dev.dev, "usb20");
+	usb20_clk = clk_get(&da8xx_usb20_dev.dev, NULL);
 	ret = PTR_ERR_OR_ZERO(usb20_clk);
 	if (ret)
 		return ret;
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index e89708d839e5..8f6f0efd978e 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -502,7 +502,7 @@ static int da8xx_probe(struct platform_device *pdev)
 	if (!glue)
 		return -ENOMEM;
 
-	clk = devm_clk_get(&pdev->dev, "usb20");
+	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		return PTR_ERR(clk);

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
