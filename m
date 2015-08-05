From: Michal Suchanek <hramrach@gmail.com>
Subject: Re: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
Date: Wed, 5 Aug 2015 14:56:09 +0200
Message-ID: <CAOMqctS9Y5FxpUCCJew6+cnjH5iTvbzkH3g-8yrXs4OuS2pSGA@mail.gmail.com>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
 <1438072876-16338-2-git-send-email-vigneshr@ti.com> <20150731181745.GM20873@sirena.org.uk>
 <55BEF4AF.5090704@ti.com> <20150804155148.GR20873@sirena.org.uk>
 <55C0FD98.1090107@ti.com> <20150805115013.GJ20873@sirena.org.uk>
 <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com> <20150805124412.GN20873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150805124412.GN20873@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "R, Vignesh" <vigneshr@ti.com>, devicetree <devicetree@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, Huang Shijie <b32955@freescale.com>, MTD Maling List <linux-mtd@lists.infradead.org>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 5 August 2015 at 14:44, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Aug 05, 2015 at 02:40:01PM +0200, Michal Suchanek wrote:
>> On 5 August 2015 at 13:50, Mark Brown <broonie@kernel.org> wrote:
>
>> > As far as I can tell you want to set a per spi_message flag saying that
>> > the message is a flash read command?  If that's what this is trying to
>> > do then why do you need to set the flag at all?  If the message is in a
>> > clearly defined format and it's more efficient to use this mmap mode
>> > then surely the driver can just recognise that the format is approprate
>> > and switch into mmap mode without being explicitly told - I'm not clear
>> > what the flag adds here.
>
>> ehm, the read command is just one byte.
>
>> I don't think sending 03 or other random byte as the first byte of a
>> SPI transfer can be used as reliable detection that we are talking to
>> a SPI flash memory.
>
> Why care - if something is physically in the same format as a flash read
> command how would a device be able to tell that it wasn't actually a
> flash read command?  The signals sent on the bus are going to be
> identical anyway.

Not only must the command be the same but also the response must be tha same.

The flash chip responds by sending arbitrary amount of data. Given
that transfer_one gets only the part that sends the read command and
the part to do the actual read may or may not follow this is getting a
bit hairy. Add in dummy bytes due to fast-read lag and page write
wrap-around and you get something that you definitely do not want
unless you are really sure that there is a flash memory on the other
end of the wire.

Thanks

Michal
