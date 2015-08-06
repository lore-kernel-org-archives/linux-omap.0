From: Michal Suchanek <hramrach@gmail.com>
Subject: Re: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
Date: Thu, 6 Aug 2015 13:42:32 +0200
Message-ID: <CAOMqctQKc6f5Mbe_CSd-ghguUfZvf6v_BRvYxQJVqPne73iESA@mail.gmail.com>
References: <20150731181745.GM20873@sirena.org.uk> <55BEF4AF.5090704@ti.com>
 <20150804155148.GR20873@sirena.org.uk> <55C0FD98.1090107@ti.com>
 <20150805115013.GJ20873@sirena.org.uk> <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com>
 <20150805124412.GN20873@sirena.org.uk> <CAOMqctS9Y5FxpUCCJew6+cnjH5iTvbzkH3g-8yrXs4OuS2pSGA@mail.gmail.com>
 <20150806090202.GO20873@sirena.org.uk> <CAOMqctQZRZ4zG_yYy=CeX3DX4NVNWN1COP4Q-2YvMun9xYOA7g@mail.gmail.com>
 <20150806112353.GT20873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150806112353.GT20873@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "R, Vignesh" <vigneshr@ti.com>, devicetree <devicetree@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, Huang Shijie <b32955@freescale.com>, MTD Maling List <linux-mtd@lists.infradead.org>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 6 August 2015 at 13:23, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Aug 06, 2015 at 12:01:37PM +0200, Michal Suchanek wrote:
>
>> However, I am familiar m25p80.c and as I understand it the controller
>> is basically supposed to implement m25p80.c in hardware when this flag
>> is set.
>
> But what in concrete terms is that supposed to mean?  It's currently
> just an essentially undocumented flag on a message rather than something
> operating at the level of a flash chip.  That's pretty much where
> Russell's comments come from.
>
>> If I was using m25p80.c to talk to anything but an actual flash chip
>> it would get me quite worried.
>
> Sure, but at the end of the day it's just emitting standard SPI messages
> which don't know anything about flash.  If those messages are a sensible
> interface here then why bother with the flag, we can just pattern match
> on the format of the message.  If that doesn't work then probably this
> isn't a great interface and a separate, application specific interface
> makes more sense.

The messages are sensible interface for communicating with a device
that interprets a particular part of the mesasge as address and
another particular part of the message as command and sends same
amount of junk before reply as the flash chip would. If your device
happens to send reply immediately part of it is trashed. If it happens
to interpret address differently the data ends up in random part of
your memory. So no, that is not something you can autodetect.

At the end of the day you have valid SPI messages but the m25p80 layer
adds interpretation to those messages which may not always give
correct result.

On the other hand, if you ever get to m25p80 or spi-nor you can assume
any message you send goes to a flash chip and insist that the
controller uses the flash-specific interface.

If there is possibility of connecting different kind of devices to
multiple chipselects on the same master then you probably want to
select this option per message or per slave.

Thanks

Michal
