From: Michal Suchanek <hramrach@gmail.com>
Subject: Re: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
Date: Thu, 6 Aug 2015 12:01:37 +0200
Message-ID: <CAOMqctQZRZ4zG_yYy=CeX3DX4NVNWN1COP4Q-2YvMun9xYOA7g@mail.gmail.com>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
 <1438072876-16338-2-git-send-email-vigneshr@ti.com> <20150731181745.GM20873@sirena.org.uk>
 <55BEF4AF.5090704@ti.com> <20150804155148.GR20873@sirena.org.uk>
 <55C0FD98.1090107@ti.com> <20150805115013.GJ20873@sirena.org.uk>
 <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com>
 <20150805124412.GN20873@sirena.org.uk> <CAOMqctS9Y5FxpUCCJew6+cnjH5iTvbzkH3g-8yrXs4OuS2pSGA@mail.gmail.com>
 <20150806090202.GO20873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150806090202.GO20873@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "R, Vignesh" <vigneshr@ti.com>, devicetree <devicetree@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, Huang Shijie <b32955@freescale.com>, MTD Maling List <linux-mtd@lists.infradead.org>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 6 August 2015 at 11:02, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Aug 05, 2015 at 02:56:09PM +0200, Michal Suchanek wrote:
>> On 5 August 2015 at 14:44, Mark Brown <broonie@kernel.org> wrote:
>> > On Wed, Aug 05, 2015 at 02:40:01PM +0200, Michal Suchanek wrote:
>
>> >> I don't think sending 03 or other random byte as the first byte of a
>> >> SPI transfer can be used as reliable detection that we are talking to
>> >> a SPI flash memory.
>
>> > Why care - if something is physically in the same format as a flash read
>> > command how would a device be able to tell that it wasn't actually a
>> > flash read command?  The signals sent on the bus are going to be
>> > identical anyway.
>
>> Not only must the command be the same but also the response must be tha same.
>
> What difference would that make?  The caller is sending a single SPI
> operation and this is a user visible thing...
>
>> The flash chip responds by sending arbitrary amount of data. Given
>> that transfer_one gets only the part that sends the read command and
>> the part to do the actual read may or may not follow this is getting a
>> bit hairy. Add in dummy bytes due to fast-read lag and page write
>> wrap-around and you get something that you definitely do not want
>> unless you are really sure that there is a flash memory on the other
>> end of the wire.
>
> So if you're doing this you may have a good reason to implement
> transfer_one_message() instead.  Or perhaps implement it in the core and
> provide operations to do the map and unmap.  And of course if this sort
> of requirement exists that's an obvious thing that must be documented
> in the interfaces but isn't.
>
> We need a lot more thought about the interface here, the lack of any
> explanation of what the interface is supposed to be and the fact that
> all questions about it are being answered in terms of describing the
> specific system are both a bit worrying.

Disclaimer: I am not familiar with the hardware for which this patch
adds support.

However, I am familiar m25p80.c and as I understand it the controller
is basically supposed to implement m25p80.c in hardware when this flag
is set.

If I was using m25p80.c to talk to anything but an actual flash chip
it would get me quite worried.

Thanks

Michal
