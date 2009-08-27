From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] usb: disable OTG AUTOIDLE only with omap3430
Date: Thu, 27 Aug 2009 06:57:40 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394043698116F@dbde02.ent.ti.com>
References: <1242658456-5723-1-git-send-email-ext-niilo.1.minkkinen@nokia.com>
 	<13B9B4C6EF24D648824FF11BE8967162038BED5CF1@dlee02.ent.ti.com>
 	<19F8576C6E063C45BE387C64729E73940436A4A15B@dbde02.ent.ti.com>
 <fb705f540908260653l990f173n8b953ebc893efb9e@mail.gmail.com>,<FCCFB4CDC6E5564B9182F639FC35608702F9A44806@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60021 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754416AbZH0BaO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Aug 2009 21:30:14 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F9A44806@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, Niilo Minkkinen <niilo.minkkinen@iki.fi>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

>>> Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
>>>
>>> Yes this is needed for 34xx. Side note is this cost around 1mW of power
>>> during active mode of MUSB. When device is not active cost is not
>>> significant.  System impact depends on duty cycle of MUSB in usecase.
>>
>> Richard/Niilo,
>>        This should also be applicable to 35xx (right?)  and so we got to
>> update the fix with below patch.
>>
>> Regards,
>> Ajay
>>
>
>Don't have access to spec/errata of 35xx just now ;).
>Could Richard confirm, if this also applies (as original comment said) .

> There is an official errata on MUSB auto-idle not to be set:
> Errata 1.164

Vikram,

This Errata is also applicable on 35xx and so we need to update the AUTOIDLE fix in musb
for 35xx.

-Ajay

> There might be NDA issues with sharing the errata document, and so cannot attach.
> I have not come across a public omap errata document yet.

>
>-niilo-
>> ========== patch =========================
>> There is an issue with MUSB AUTOIDLE as reported by Niilo Minkkinen in below commit.
>>
>> 9a4b5e36ce58febdd2039dd4d129ee7edf4f5536
>> usb: musb: disable OTG AUTOIDLE only with omap3430
>>
>> As OMAP35x is just a variant of OMAP34xx chip thus the fix is also applicable for OMAP35x so
>updating it for OMAP35x.
>>
>> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
>> ---
>>  drivers/usb/musb/omap2430.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c index 453796c..ab8336d
>100644
>> --- a/drivers/usb/musb/omap2430.c
>> +++ b/drivers/usb/musb/omap2430.c
>> @@ -233,7 +233,7 @@ int __init musb_platform_init(struct musb *musb)
>>         * MUSB AUTOIDLE don't work in 3430.
>>         * Workaround by Richard Woodruff/TI
>>         */
>> -       if (!cpu_is_omap3430())
>> +       if (!cpu_is_omap3430() && !cpu_is_omap35xx())
>>                l |= AUTOIDLE;          /* enable auto idle */
>>        omap_writel(l, OTG_SYSCONFIG);
>>
>> --
>> 1.6.2.4
>> ==============================================
>>
>>>
>>> Regards,
>>> Richard W.
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
>
>--
>---------------------------------
>Niilo Minkkinen
>Kalhontie 69C
>40950 MUURAME
>+358407324526
>niilo.minkkinen@iki.fi
>----------------------------------
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

