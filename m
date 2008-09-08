From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [PATCH] MUSB: Set INDEX register to 0 before accessing CONFIGDATA
Date: Mon, 8 Sep 2008 11:12:24 +0800
Message-ID: <386072610809072012wcf053a6j37c238b82667c23a@mail.gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02C418D1B1@dbde02.ent.ti.com>
	 <200809062204.01492.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:24894 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbYIHDMZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Sep 2008 23:12:25 -0400
Received: by yx-out-2324.google.com with SMTP id 8so706135yxm.1
        for <linux-omap@vger.kernel.org>; Sun, 07 Sep 2008 20:12:24 -0700 (PDT)
In-Reply-To: <200809062204.01492.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>

On Sun, Sep 7, 2008 at 1:04 PM, David Brownell <david-b@pacbell.net> wrote:
> On Thursday 04 September 2008, Gadiyar, Anand wrote:
>> From: Anand Gadiyar <gadiyar@ti.com>
>>
>> The Index register needs to be zero to access CONFIGDATA.
>> musb_ep_select()will not set the MUSB_INDEX register unless INDEXED
>> mode addressing is used. This change will set the register correctly
>> in INDEXED as well as FLAT mode.
>>
>> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
>> CC: Ajay Kumar Gupta <ajay.gupta@ti.com>
>
> ACK.  I *know* it was originally written that way.  I think
> the change was one of the Blackfin patches ... I hope this
> isn't one of those cases where the Blackfin version of this
> core acts differently.  (Like clearing that DMA IRQ status...)
>

For Blackfin, the register MUSB_CONFIGDATA is not exported out to software.
So in the musb driver, Blackfin code can not access the MUSB_CONFIGDATA.
The configuration is fixed in the software.

-Bryan

>
>> ---
>> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
>> index b398776..6c4da2f 100644
>> --- a/drivers/usb/musb/musb_core.c
>> +++ b/drivers/usb/musb/musb_core.c
>> @@ -1334,7 +1334,7 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
>>       int             i;
>>
>>       /* log core options (read using indexed model) */
>> -     musb_ep_select(mbase, 0);
>> +     musb_writeb(mbase, MUSB_INDEX, 0);
>>       reg = musb_readb(mbase, 0x10 + MUSB_CONFIGDATA);
>>
>>       strcpy(aInfo, (reg & MUSB_CONFIGDATA_UTMIDW) ? "UTMI-16" : "UTMI-8");--
>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
>
