From: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v5 3/3] ARM: dts: igep00x0: add wl18xx bindings
Date: Wed, 11 Mar 2015 13:07:43 +0100
Message-ID: <CABxcv=ntLn-Hv+J5fdjS6=R+8KYfm+1+4fXmMDQvw-kqFJD3-A@mail.gmail.com>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com>
	<1425915402-10012-3-git-send-email-eliad@wizery.com>
	<CABxcv=kL3Hw43VVxAsZ=DnY4Z+5431PO2YehcK2zTkFGBG0cNA@mail.gmail.com>
	<CABxcv=kUwU2KVw5jYryh62v5us2-CiJFMnYN2nyWLRMWnEkU3w@mail.gmail.com>
	<CAB3XZEdbVgOGH_uz4BX+8NXEu_vZzd=JF_1qvSPbyvvc0-O9iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAB3XZEdbVgOGH_uz4BX+8NXEu_vZzd=JF_1qvSPbyvvc0-O9iA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello Eliad,

On Wed, Mar 11, 2015 at 12:59 PM, Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org> wrote:
> On Wed, Mar 11, 2015 at 3:19 AM, Javier Martinez Canillas
> <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org> wrote:
>>
>> But there wasn't a DT binding to describe that so most boards use the
>> same hack which is to define a fake fixed-regulator with an enable
>> GPIO just to toggle that pin.
>>
>> But now the MMC subsystem has support for power sequence providers and
>> the pwrseq-simple driver
>> (Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt) has
>> support for reset GPIOs so you may want to change that as well.
>>
> interesting. i wasn't aware of it.
> but that's for a different time i guess :)
>

Indeed, I've on my TODO anyways so I can post a patch on top of your series :-)

> thanks,
> Eliad.

Best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
