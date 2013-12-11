From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCHv2 00/10] Add memory mapped support for ti qspi, m25p80 serial flash.
Date: Wed, 11 Dec 2013 11:44:22 +0100
Message-ID: <201312111144.23012.marex@denx.de>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com> <201312101349.13564.marex@denx.de> <52A7E7A5.5000909@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52A7E7A5.5000909-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wednesday, December 11, 2013 at 05:18:45 AM, Sourav Poddar wrote:
> Hi Marek,
> 
> On Tuesday 10 December 2013 06:19 PM, Marek Vasut wrote:
> > On Friday, December 06, 2013 at 03:24:41 PM, Sourav Poddar wrote:
> >> The patch series aims to add memory mapped support for TI qspi
> >> contoller and also add support for the same in serial flash
> >> driver(m25p80).
> > 
> > My question is, shall we not wait for the new SPI NOR framework to be
> > well fleshed out and only then implement this controller driver on top
> > of it ?
> 
> I think it will still take lot of time for spi framework to come to
> alignment
> and get merged in the mainline. Till then, m25p80 development should
> go on independently. Once, the spi framework is ready, I can myself port
> this into the new framework.

Sure, but I also think Huang is coming close to the new framework. Have you seen 
his latest patchset ( Message-ID: <1386318764-15882-1-git-send-email-
b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org> ) ? I think you two should really start working on the new 
framework instead of bending drivers all around.

> > I have a feeling this patchset adds quite a lot of ad-hoc hacks into the
> > m25p80 driver, which would become dead code once converted to the SPI
> > NOR framework.
> 
> I dont think that spi framework till now provides capabilities which can
> be used
> to handle memory mapped cases.

Not yet, so please bring it up in the discussion there :)

> I did a quad mode support for m25p80 which easily got cloned into the
> new spi framework.
> Same can be done for the memory mapped support too

The quad mode didn't need any new hooks in the m25p80, did it ? That's the 
difference here.

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
