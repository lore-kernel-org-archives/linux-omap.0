From: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH V2 4/8]usb : musb:Using omap_device_build for musb
 device registration
Date: Tue, 10 Aug 2010 10:33:57 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940270944038@dbde02.ent.ti.com>
References: <1281110270-4185-1-git-send-email-hemahk@ti.com>
 <4C5FF856.4020301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C5FF856.4020301-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

 Hi,

>-----Original Message-----
>From: Cousson, Benoit 
>Sent: Monday, August 09, 2010 6:15 PM
>To: Kalliguddi, Hema
>Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
>Felipe Balbi; Tony Lindgren; Kevin Hilman
>Subject: Re: [PATCH V2 4/8]usb : musb:Using omap_device_build 
>for musb device registration
>
>On 8/6/2010 5:57 PM, Kalliguddi, Hema wrote:
>> From: Hema HK<hemahk-l0cyMroinI0@public.gmane.org>
>
><snip>
>
>>   void __init usb_musb_init(struct omap_musb_board_data *board_data)
>>   {
>> -	if (cpu_is_omap243x()) {
>> -		musb_resources[0].start = OMAP243X_HS_BASE;
>> -	} else if (cpu_is_omap34xx()) {
>> -		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
>> -	} else if (cpu_is_omap44xx()) {
>> -		musb_resources[0].start = OMAP44XX_HSUSB_OTG_BASE;
>> -		musb_resources[1].start = OMAP44XX_IRQ_HS_USB_MC_N;
>> -		musb_resources[2].start = OMAP44XX_IRQ_HS_USB_DMA_N;
>> +	char oh_name[MAX_OMAP_MUSB_HWMOD_NAME_LEN];
>> +	struct omap_hwmod *oh;
>> +	struct omap_device *od;
>> +	struct platform_device *pdev;
>> +	struct device	*dev;
>> +	int l, bus_id = -1;
>> +	struct musb_hdrc_platform_data *pdata;
>> +
>> +	l = snprintf(oh_name, MAX_OMAP_MUSB_HWMOD_NAME_LEN,
>> +						"usb_otg_hs");
>> +	WARN(l>= MAX_OMAP_MUSB_HWMOD_NAME_LEN,
>> +			"String buffer overflow in MUSB device 
>setup\n");
>
>This is not needed in your case. Just use a const char*, and you will 
>avoid the useless snprintf and test.

Ok.
>
>> +
>> +	oh = omap_hwmod_lookup(oh_name);
>> +
>> +	if (!oh) {
>> +		pr_err("Could not look up %s\n", oh_name);
>> +	} else {
>
>You can avoid that indentation be returning in case of failure.

 Agreed.
>
>> +		/*
>> +		 * REVISIT: This line can be removed once all 
>the platforms
>> +		 * using musb_core.c have been converted to use 
>use clkdev.
>> +		 */
>> +		musb_plat.clock = "ick";
>> +		musb_plat.board_data = board_data;
>> +		musb_plat.power = board_data->power>>  1;
>> +		musb_plat.mode = board_data->mode;
>> +		pdata =&musb_plat;
>> +
>> +		od = omap_device_build(name, bus_id, oh, pdata,
>> +				       sizeof(struct 
>musb_hdrc_platform_data),
>> +							
>omap_musb_latency,
>> +				       
>ARRAY_SIZE(omap_musb_latency), false);
>> +		if (IS_ERR(od)) {
>> +			pr_err("Could not build omap_device for 
>%s %s\n",
>> +						name, oh_name);
> > +		} else {
>
>You can avoid that second level of indentation be returning in case of 
>failure as well.

Agreed.
>
>Benoit
>--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
