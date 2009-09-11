From: "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 2/3] USB: musb: omap: Fix wrong xceivr passing to twl4030
Date: Sat, 12 Sep 2009 01:44:52 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F9C311CF@dbde02.ent.ti.com>
References: <1252105499-19003-1-git-send-email-vikram.pandita@ti.com>
 <19F8576C6E063C45BE387C64729E73940436B014B8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436B014B8-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Ajay

>-----Original Message-----
>From: Gupta, Ajay Kumar
>> Subject: [PATCH 2/3] USB: musb: omap: Fix wrong xceivr passing to twl4030
>>
>> Wrong pointer was getting passed to twl4030 transceiver.
>>
>> Call path is:
>> otg_set_suspend -> twl4030_set_suspend
>>
>> drivers/usb/otg/twl4030-usb.c: twl4030_set_suspend() uses:
>> 	struct twl4030_usb *twl = xceiv_to_twl(x);
>>
>> and xceiv_to_twl is container_of()
>>
>> So the same pointer needs to be passed to otg_set_suspend() as has
>> been used for otg_set_transceiver.
>>
>> A crash is seen without this patch, as twl pointer access is worng
>>
>
>musb->xceiv is also taken from otg_get_transceiver() in musb_platform_init(). So this patch is not
>required.

Thanks for pointing this out. 
I will repost a set of 2 patches with this patch removed.

Patches on their way.

>
>-Ajay
>
>> Signed-off-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/usb/musb/omap2430.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
>> index b957575..ea7a798 100644
>> --- a/drivers/usb/musb/omap2430.c
>> +++ b/drivers/usb/musb/omap2430.c
>> @@ -269,7 +269,7 @@ int musb_platform_suspend(struct musb *musb)
>>  	l |= ENABLEWAKEUP;	/* enable wakeup */
>>  	omap_writel(l, OTG_SYSCONFIG);
>>
>> -	otg_set_suspend(musb->xceiv, 1);
>> +	otg_set_suspend(otg_get_transceiver(), 1);
>>
>>  	if (musb->set_clock)
>>  		musb->set_clock(musb->clock, 0);
>> @@ -286,7 +286,7 @@ int musb_platform_resume(struct musb *musb)
>>  	if (!musb->clock)
>>  		return 0;
>>
>> -	otg_set_suspend(musb->xceiv, 0);
>> +	otg_set_suspend(otg_get_transceiver(), 0);
>>
>>  	if (musb->set_clock)
>>  		musb->set_clock(musb->clock, 1);
>> --
>> 1.6.3.3.334.g916e1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
