From: Hema Kalliguddi <hemahk@ti.com>
Subject: RE: [5/7 v2] usb: otg: TWL6030: Introduce the twl6030_phy_suspend function.
Date: Wed, 16 Feb 2011 10:46:30 +0530
Message-ID: <d9c3feeb60c9efb15f6f365f672d0a35@mail.gmail.com>
References: <1297762958-26199-1-git-send-email-hemahk@ti.com>
 <1297762958-26199-5-git-send-email-hemahk@ti.com> <4D5A6FF9.8000709@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:54273 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750748Ab1BPFQq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 00:16:46 -0500
In-Reply-To: <4D5A6FF9.8000709@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

 Hi,

>-----Original Message-----
>From: Sergei Shtylyov [mailto:sshtylyov@mvista.com]
>Sent: Tuesday, February 15, 2011 5:52 PM
>To: Hema HK
>Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; Felipe Balbi
>Subject: Re: [5/7 v2] usb: otg: TWL6030: Introduce the
>twl6030_phy_suspend function.
>
>Hello.
>
>On 15-02-2011 12:42, Hema HK wrote:
>
>> From: Kalliguddi, Hema<hemahk@ti.com>
>
>> Introduce the twl6030_phy_suspend function and assign to
>otg.set_suspend
>> function pointer.
>> This function is used by the musb-omap2430 platform driver
>> during suspend/resume.
>
>> Signed-off-by: Hema HK<hemahk@ti.com>
>> Cc: Felipe Balbi<balbi@ti.com>
>
>[...]
>
>> Index: linux-2.6/drivers/usb/otg/twl6030-usb.c
>> ===================================================================
>> --- linux-2.6.orig/drivers/usb/otg/twl6030-usb.c
>> +++ linux-2.6/drivers/usb/otg/twl6030-usb.c
>> @@ -177,6 +177,20 @@ static void twl6030_phy_shutdown(struct
>>   	pdata->phy_power(twl->dev, 0, 0);
>>   }
>>
>> +static int twl6030_phy_suspend(struct otg_transceiver *x,
>int suspend)
>> +{
>> +	struct twl6030_usb *twl;
>> +	struct device *dev;
>> +	struct twl4030_usb_data *pdata;
>> +
>> +	twl = xceiv_to_twl(x);
>> +	dev  = twl->dev;
>> +	pdata = dev->platform_data;
>
>    Why not do all the above in the intializers?

Can be done that way as well.

Regards,
Hema
>
>> +	pdata->phy_suspend(twl->dev, suspend);
>> +
>> +	return 0;
>> +}
>> +
>
>WBR, Sergei
>
