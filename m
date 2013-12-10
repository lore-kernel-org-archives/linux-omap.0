From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCHv2 00/10] Add memory mapped support for ti qspi, m25p80 serial flash.
Date: Tue, 10 Dec 2013 19:34:01 +0100
Message-ID: <201312101934.01300.marex@denx.de>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com> <201312101922.10618.marex@denx.de> <20131210182904.GG11468@sirena.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:56887 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305Ab3LJSmb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Dec 2013 13:42:31 -0500
In-Reply-To: <20131210182904.GG11468@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Sourav Poddar <sourav.poddar@ti.com>, linux-spi@vger.kernel.org, computersforpeace@gmail.com, dwmw2@infradead.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, balbi@ti.com

On Tuesday, December 10, 2013 at 07:29:04 PM, Mark Brown wrote:
> On Tue, Dec 10, 2013 at 07:22:10PM +0100, Marek Vasut wrote:
> > On Tuesday, December 10, 2013 at 05:11:43 PM, Mark Brown wrote:
> > > There is some stuff that pushes up into the controller in that while
> > > the device is in memory mapped mode as far as I can tell it's not safe
> > > to do other accesses so if someone's put more than one device on the
> > > SPI bus we need to handle interactions there.
> > 
> > OK, so it's either-or . That seems OK, you might want to have two drivers
> > for this ip block, one to handle it as a SPI block and one to handle it
> > as a SPI-NOR block. ... that is of course, if these two modes can't work
> > together.
> 
> Or the client disables the memory map when it's not actively being used
> and the stops other transfers starting while the mapping is in place.
> I'd expect we'll have to cope with shared use at some point, hardware
> engineers will probably build such systems.

Aren't we fixing the problem at the wrong place ? Maybe it's about time to fix 
the engineers ;-)

Best regards,
Marek Vasut
