From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
Date: Thu, 6 Aug 2015 13:02:29 +0200
Message-ID: <CAOMqctSp7CorcVeZYm10cFnOKXG4F7MskkhZaXbV+9diUbfRdg@mail.gmail.com>
References: <20150731181745.GM20873@sirena.org.uk> <55BEF4AF.5090704@ti.com>
 <20150804155148.GR20873@sirena.org.uk> <55C0FD98.1090107@ti.com>
 <20150805115013.GJ20873@sirena.org.uk> <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com>
 <20150805124412.GN20873@sirena.org.uk> <CAOMqctS9Y5FxpUCCJew6+cnjH5iTvbzkH3g-8yrXs4OuS2pSGA@mail.gmail.com>
 <20150806090202.GO20873@sirena.org.uk> <CAOMqctQZRZ4zG_yYy=CeX3DX4NVNWN1COP4Q-2YvMun9xYOA7g@mail.gmail.com>
 <20150806102225.GI7576@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150806102225.GI7576-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "R, Vignesh" <vigneshr-l0cyMroinI0@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 6 August 2015 at 12:22, Russell King - ARM Linux
<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> On Thu, Aug 06, 2015 at 12:01:37PM +0200, Michal Suchanek wrote:
>> Disclaimer: I am not familiar with the hardware for which this patch
>> adds support.
>>
>> However, I am familiar m25p80.c and as I understand it the controller
>> is basically supposed to implement m25p80.c in hardware when this flag
>> is set.
>
> That, to me, sounds like what you have is:
>
> ---m25p80 specific interface--->SPI bus--->m25p80 device
>
> Where the m25p80 specific interface does not expose direct access to the
> SPI bus?

The m25p80 specific hardware interface is presumably optional so you
can use it or not. The description is a bit vague, though.

In fsl-qspi the driver does not make it optional. I am not sure that
controller can be used for non-m25p80 slaves.


>
> If that's the case, then maybe you should consider whether using the SPI
> bus infrastructure is really the best way forward.  Would it make more
> sense instead to adopt a different software structure, something more
> high-level like:
>
>      +-------------------------------------------+
>      |          m25p80 high-level driver      =spi-nor   |
>      +----------------------+--------------------+
>      |   SPI m25p80 driver  |                    |
>      +----------------------+                    |
>      |      SPI layer       |  Special driver    =fsl-qspi|
>      +----------------------+                    |
>      |    SPI bus driver    |                    |
>      +----------------------+--------------------+
>      |     SPI hardware     |  Special hardware  |
>      +----------------------+--------------------+
>

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
