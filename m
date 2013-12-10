From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCHv2 00/10] Add memory mapped support for ti qspi, m25p80 serial flash.
Date: Tue, 10 Dec 2013 19:22:10 +0100
Message-ID: <201312101922.10618.marex@denx.de>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com> <201312101349.13564.marex@denx.de> <20131210161143.GK29268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131210161143.GK29268-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday, December 10, 2013 at 05:11:43 PM, Mark Brown wrote:
> On Tue, Dec 10, 2013 at 01:49:13PM +0100, Marek Vasut wrote:
> > My question is, shall we not wait for the new SPI NOR framework to be
> > well fleshed out and only then implement this controller driver on top
> > of it ?
> > 
> > I have a feeling this patchset adds quite a lot of ad-hoc hacks into the
> > m25p80 driver, which would become dead code once converted to the SPI
> > NOR framework.
> 
> There is some stuff that pushes up into the controller in that while the
> device is in memory mapped mode as far as I can tell it's not safe to do
> other accesses so if someone's put more than one device on the SPI bus
> we need to handle interactions there.

OK, so it's either-or . That seems OK, you might want to have two drivers for 
this ip block, one to handle it as a SPI block and one to handle it as a SPI-NOR 
block. ... that is of course, if these two modes can't work together.

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
