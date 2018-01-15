From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 1/3] mfd/omap-usb-tll: Delete two error messages for a
 failed memory allocation in usbtll_omap_probe()
Date: Mon, 15 Jan 2018 17:34:43 +0200
Message-ID: <086fe58c-dfba-5c1d-ab69-0cc0c237943e@ti.com>
References: <c048a681-70e4-ecdd-e0f8-48c8f1bb0ac4@users.sourceforge.net>
 <7719b4e7-1081-6fa4-6f14-f45cf062482d@users.sourceforge.net>
 <20180115134101.GA6711@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180115134101.GA6711@lenoch>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>, SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Ladislav,


On 15/01/18 15:41, Ladislav Michl wrote:
> Marcus,
> 
> On Mon, Jan 15, 2018 at 02:15:11PM +0100, SF Markus Elfring wrote:
>> Omit extra messages for a memory allocation failure in this function.
>>
>> This issue was detected by using the Coccinelle software.
>>
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>> ---
>>  drivers/mfd/omap-usb-tll.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
>> index 44a5d66314c6..7945efa0152e 100644
>> --- a/drivers/mfd/omap-usb-tll.c
>> +++ b/drivers/mfd/omap-usb-tll.c
>> @@ -222,10 +222,8 @@ static int usbtll_omap_probe(struct platform_device *pdev)
>>  	dev_dbg(dev, "starting TI HSUSB TLL Controller\n");
>>  
>>  	tll = devm_kzalloc(dev, sizeof(struct usbtll_omap), GFP_KERNEL);
>> -	if (!tll) {
>> -		dev_err(dev, "Memory allocation failed\n");
>> +	if (!tll)
>>  		return -ENOMEM;
>> -	}
>>  
>>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>  	tll->base = devm_ioremap_resource(dev, res);
>> @@ -258,7 +256,6 @@ static int usbtll_omap_probe(struct platform_device *pdev)
>>  						GFP_KERNEL);
>>  	if (!tll->ch_clk) {
>>  		ret = -ENOMEM;
>> -		dev_err(dev, "Couldn't allocate memory for channel clocks\n");
> 
> I'd either leave this one, just to know which allocation failed or better use
> something like this (it is pseudo patch only, just to show idea):
> 
> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
> index 44a5d66314c6..d217211d6b8f 100644
> --- a/drivers/mfd/omap-usb-tll.c
> +++ b/drivers/mfd/omap-usb-tll.c
> @@ -108,9 +108,9 @@
>  					 (x) != OMAP_EHCI_PORT_MODE_PHY)
>  
>  struct usbtll_omap {
> -	int					nch;	/* num. of channels */
> -	struct clk				**ch_clk;
>  	void __iomem				*base;
> +	int					nch;	/* num. of channels */
> +	struct clk				ch_clk[0];

How about putting a comment here that says ch_clk needs to be the last member of this structure?

>  };
>  
>  /*-------------------------------------------------------------------------*/
> @@ -221,18 +221,11 @@ static int usbtll_omap_probe(struct platform_device *pdev)
>  
>  	dev_dbg(dev, "starting TI HSUSB TLL Controller\n");
>  
> -	tll = devm_kzalloc(dev, sizeof(struct usbtll_omap), GFP_KERNEL);
> -	if (!tll) {
> -		dev_err(dev, "Memory allocation failed\n");
> -		return -ENOMEM;
> -	}
> -
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	tll->base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(tll->base))
> -		return PTR_ERR(tll->base);
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
>  
> -	platform_set_drvdata(pdev, tll);
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
>  
> @@ -240,27 +233,27 @@ static int usbtll_omap_probe(struct platform_device *pdev)
>  	switch (ver) {
>  	case OMAP_USBTLL_REV1:
>  	case OMAP_USBTLL_REV4:
> -		tll->nch = OMAP_TLL_CHANNEL_COUNT;
> +		num = OMAP_TLL_CHANNEL_COUNT;

need to declare num. Maybe better call it nch instead?

>  		break;
>  	case OMAP_USBTLL_REV2:
>  	case OMAP_USBTLL_REV3:
> -		tll->nch = OMAP_REV2_TLL_CHANNEL_COUNT;
> +		num = OMAP_REV2_TLL_CHANNEL_COUNT;
>  		break;
>  	default:
> -		tll->nch = OMAP_TLL_CHANNEL_COUNT;
> +		num = OMAP_TLL_CHANNEL_COUNT;
>  		dev_dbg(dev,
>  		 "USB TLL Rev : 0x%x not recognized, assuming %d channels\n",
> -			ver, tll->nch);
> +			ver, num);
>  		break;
>  	}
>  
> -	tll->ch_clk = devm_kzalloc(dev, sizeof(struct clk *) * tll->nch,
> -						GFP_KERNEL);
> -	if (!tll->ch_clk) {
> -		ret = -ENOMEM;
> -		dev_err(dev, "Couldn't allocate memory for channel clocks\n");
> -		goto err_clk_alloc;
> -	}
> +	tll = devm_kzalloc(dev, sizeof(struct usbtll_omap) + (num * sizeof(...)), GFP_KERNEL);

num * sizeof(tll->ch_clk[0]) ?

> +	if (!tll)
> +		return -ENOMEM;
> +
> +	tll->nch = num;
> +	tll->base = base;
> +	platform_set_drvdata(pdev, tll);
>  
>  	for (i = 0; i < tll->nch; i++) {
>  		char clkname[] = "usb_tll_hs_usb_chx_clk";
> 
>>  		goto err_clk_alloc;
>>  	}
> 
> What do you think? I'll prepare proper patch in case there's an agreement
> on above approach.

I think it is a good approach.

> 
> Best regards,
> 	ladis
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
