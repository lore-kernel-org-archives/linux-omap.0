From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: GPIO: Fix OMAP4 GPIO reg access issues
Date: Wed, 07 Apr 2010 08:09:30 -0700
Message-ID: <87ljczguz9.fsf@deeprootsystems.com>
References: <1269268704-31347-1-git-send-email-charu@ti.com>
	<87mxxgi49c.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C43ADE81@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60835 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932581Ab0DGPJd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 11:09:33 -0400
Received: by pwj9 with SMTP id 9so1026340pwj.19
        for <linux-omap@vger.kernel.org>; Wed, 07 Apr 2010 08:09:33 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C43ADE81@dbde02.ent.ti.com> (Charulatha Varadarajan's message of "Wed\, 7 Apr 2010 08\:02\:03 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Varadarajan, Charulatha" <charu@ti.com> writes:

> ________________________________________
>> From: Kevin Hilman [khilman@deeprootsystems.com]
>> Sent: Wednesday, April 07, 2010 4:21 AM
>> To: Varadarajan, Charulatha
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCH] OMAP: GPIO: Fix OMAP4 GPIO reg access issues
>> 
>> Charulatha V <charu@ti.com> writes:
>> 
>> > Access to some of the OMAP4 GPIO registers are not properly handled.
>> > This patch fixes it.
>> >
>> 
>> Tested on... ?
>
> Tested on 3430SDP and 4430SDP.

Please update changelog accordingly.

>> > Signed-off-by: Charulatha V <charu@ti.com>
>> ---
>
> [...]
>
>> > @@ -1570,9 +1603,14 @@ static int gpio_is_input(struct gpio_bank *bank, int mask)
>> >               reg += OMAP7XX_GPIO_DIR_CONTROL;
>> >               break;
>> >       case METHOD_GPIO_24XX:
>> > -     case METHOD_GPIO_44XX:
>> >               reg += OMAP24XX_GPIO_OE;
>> >               break;
>> > +     case METHOD_GPIO_44XX:
>> > +             reg += OMAP4_GPIO_OE;
>> > +             break;
>> > +     default:
>> > +             WARN_ON(1);
>> > +             return -EINVAL;
>> 
>> If you add a WARN, please add a helpful string.
>
> Added this WARN in the same way as in other functions 
> of the same file.

That still doesn't make it helpful.

Repeating an error does not make it correct.

Kevin
