From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [RESEND PATCH v6 4/4] usb: musb: da8xx: Add a primary support of
 PM runtime
Date: Wed, 29 Mar 2017 11:45:00 +0530
Message-ID: <6b916c3d-dcd0-0217-e486-4c89ffdbf655@ti.com>
References: <20170324143600.4704-1-abailon@baylibre.com>
 <20170324143600.4704-5-abailon@baylibre.com> <m24lyeck07.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <m24lyeck07.fsf-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: b-liu-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 28 March 2017 06:09 AM, Kevin Hilman wrote:
> Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> writes:
> 
>> Currently, MUSB DA8xx glue driver doesn't have PM runtime support.
>> Because the CPPI 4.1 is using the same clock as MUSB DA8xx and
>> CPPI 4.1 is a child of MUSB DA8xx glue, add support of PM runtime
>> to the DA8xx glue driver in order to let the CPPI 4.1 driver manage
>> the clock by using PM runtime.
>>
>> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> 
> Dumb question: even if the clock is shared with cppi4, doesn't the
> use-couting in the clock API handle it so that things should function
> fine even without this patch?
> 
> Some other comments/questions below...
> 
>> ---
>>  drivers/usb/musb/da8xx.c | 27 ++++++++-------------------
>>  1 file changed, 8 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
>> index ed28afd..89e12f6 100644
>> --- a/drivers/usb/musb/da8xx.c
>> +++ b/drivers/usb/musb/da8xx.c
>> @@ -30,7 +30,6 @@
>>   */
>>  
>>  #include <linux/module.h>
>> -#include <linux/clk.h>
>>  #include <linux/err.h>
>>  #include <linux/io.h>
>>  #include <linux/of_platform.h>
>> @@ -86,7 +85,6 @@ struct da8xx_glue {
>>  	struct device		*dev;
>>  	struct platform_device	*musb;
>>  	struct platform_device	*usb_phy;
>> -	struct clk		*clk;
>>  	struct phy		*phy;
>>  };
>>  
>> @@ -376,11 +374,7 @@ static int da8xx_musb_init(struct musb *musb)
>>  
>>  	musb->mregs += DA8XX_MENTOR_CORE_OFFSET;
>>  
>> -	ret = clk_prepare_enable(glue->clk);
>> -	if (ret) {
>> -		dev_err(glue->dev, "failed to enable clock\n");
>> -		return ret;
>> -	}
>> +	pm_runtime_get_sync(musb->controller->parent);
>>  
>>  	/* Returns zero if e.g. not clocked */
>>  	rev = musb_readl(reg_base, DA8XX_USB_REVISION_REG);
>> @@ -423,7 +417,7 @@ static int da8xx_musb_init(struct musb *musb)
>>  err_phy_power_on:
>>  	phy_exit(glue->phy);
>>  fail:
>> -	clk_disable_unprepare(glue->clk);
>> +	pm_runtime_put(musb->controller->parent);
>>  	return ret;
>>  }
>>  
>> @@ -435,7 +429,7 @@ static int da8xx_musb_exit(struct musb *musb)
>>  
>>  	phy_power_off(glue->phy);
>>  	phy_exit(glue->phy);
>> -	clk_disable_unprepare(glue->clk);
>> +	pm_runtime_put(musb->controller->parent);
>>  
>>  	usb_put_phy(musb->xceiv);
>>  
>> @@ -519,7 +513,6 @@ static int da8xx_probe(struct platform_device *pdev)
>>  	struct musb_hdrc_platform_data	*pdata = dev_get_platdata(&pdev->dev);
>>  	struct da8xx_glue		*glue;
>>  	struct platform_device_info	pinfo;
>> -	struct clk			*clk;
>>  	struct device_node		*np = pdev->dev.of_node;
>>  	int				ret;
>>  
>> @@ -527,12 +520,6 @@ static int da8xx_probe(struct platform_device *pdev)
>>  	if (!glue)
>>  		return -ENOMEM;
>>  
>> -	clk = devm_clk_get(&pdev->dev, "usb20");
>> -	if (IS_ERR(clk)) {
>> -		dev_err(&pdev->dev, "failed to get clock\n");
>> -		return PTR_ERR(clk);
>> -	}
> 
> Something isn't quite right here.
> 
> This clk_get uses a con_id "usb20", but when converting to runtime PM,
> we rely on the pm_clk layer (used on davinci for runtime PM) to do clock
> lookups by the default con_ids.  I guess this still probably works
> because we fallback to the NULL con_id.

Right, since DaVinci uses pm_clk layer for runtime PM, we support
runtime PM on only two types of clocks. Those with con_id in the list of
con_ids recognized by pm_clk layer or those with NULL con_id. For
devices which use a single clock, NULL con_id is preferred.

Thanks,
Sekhar
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
