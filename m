From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 03/12] mfd: omap-usb-host: Use clock names as per function
 for reference clocks
Date: Fri, 14 Feb 2014 15:12:47 +0200
Message-ID: <52FE164F.80503@ti.com>
References: <1392200333-28397-1-git-send-email-rogerq@ti.com> <1392200333-28397-4-git-send-email-rogerq@ti.com> <20140214100915.GD7380@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140214100915.GD7380@lee--X1>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 02/14/2014 12:09 PM, Lee Jones wrote:
>> Use a meaningful name for the reference clocks so that it indicates the function.
>>
>> CC: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> CC: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/mfd/omap-usb-host.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
>> index 60a3bed..ce620a8 100644
>> --- a/drivers/mfd/omap-usb-host.c
>> +++ b/drivers/mfd/omap-usb-host.c
>> @@ -714,21 +714,21 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>>  		goto err_mem;
>>  	}
>>  
>> -	omap->xclk60mhsp1_ck = devm_clk_get(dev, "xclk60mhsp1_ck");
>> +	omap->xclk60mhsp1_ck = devm_clk_get(dev, "refclk_60m_ext_p1");
> 
> You can't do that. These changes will have to be in the same patch as
> the core change i.e. where they are initialised.

I'm not touching them anywhere in this series. When core changes are you
referring to?

> 
>>  	if (IS_ERR(omap->xclk60mhsp1_ck)) {
>>  		ret = PTR_ERR(omap->xclk60mhsp1_ck);
>>  		dev_err(dev, "xclk60mhsp1_ck failed error:%d\n", ret);
>>  		goto err_mem;
>>  	}
>>  
>> -	omap->xclk60mhsp2_ck = devm_clk_get(dev, "xclk60mhsp2_ck");
>> +	omap->xclk60mhsp2_ck = devm_clk_get(dev, "refclk_60m_ext_p2");
>>  	if (IS_ERR(omap->xclk60mhsp2_ck)) {
>>  		ret = PTR_ERR(omap->xclk60mhsp2_ck);
>>  		dev_err(dev, "xclk60mhsp2_ck failed error:%d\n", ret);
>>  		goto err_mem;
>>  	}
>>  
>> -	omap->init_60m_fclk = devm_clk_get(dev, "init_60m_fclk");
>> +	omap->init_60m_fclk = devm_clk_get(dev, "refclk_60m_int");
>>  	if (IS_ERR(omap->init_60m_fclk)) {
>>  		ret = PTR_ERR(omap->init_60m_fclk);
>>  		dev_err(dev, "init_60m_fclk failed error:%d\n", ret);
> 

--
cheers,
-roger

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
