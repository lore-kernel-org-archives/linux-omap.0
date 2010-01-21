From: Ben Dooks <ben@simtec.co.uk>
Subject: Re:
Date: Thu, 21 Jan 2010 09:04:30 +0900
Message-ID: <4B579A0E.4030108__46446.1063886576$1264085152$gmane$org@simtec.co.uk>
References: <1264016711-sup-309@ben-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [121.136.51.252] ([121.136.51.252]:38484 "EHLO ben-laptop"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750985Ab0AUOpk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jan 2010 09:45:40 -0500
In-Reply-To: <1264016711-sup-309@ben-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari@gmail.com>
Cc: beagleboard <beagleboard@googlegroups.com>, linux-omap <linux-omap@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, Eric Miao <eric.miao@marvell.com>, Michael Hennerich <michael.hennerich@analog.com>, Grant Likely <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net

Ben Gamari wrote:
> Bcc: 
> Subject: GPIO chip select support in omap2_mcspi driver
> 
> Hey,
> 
> Recently I have been looking to use a BeagleBoard to drive several
> serial ADCs and DACs in a data acquisition and analysis setup. Unfortunately, the
> BeagleBoard is severely limited by the number of SPI controllers it
> exposes on the expansion connector (McSPI3 with 2 CS lines and McSPI4
> with one). This is insufficient for our application and thus I have been
> investigating adding support to the mcspi driver for using GPIO lines as
> chip select lines, as is done in the pxa2xx, bfin5xx, and s3c24xx drivers.
> 
> To this end, I have a few questions about how this support was
> implemented. First, it seems that the s3c24xx driver is built on the
> spi_bitbang driver, despite interfacing with a dedicated hardware SPI
> controller.  What is the reason for this? Was this done specifically for
> the purpose of incorporating support for GPIO CS pins?

The spi_bitbang driver also has a really useful spi queue and workqueue
built into it, which is what the s3c24xx spi driver actually bothers to
use.

> It seems like the rough idea is to add a cs_gpio field to the device
> struct (omap2_mcspi) and add the appropriate code to the
> omap2_mcspi_force_cs() to bring cs_gpio high or low if it is valid. The
> potential problem I can see with this is that omap2_mcspi_set_enable()
> is called to enable the channel before the force_cs() is called (in
> omap2_mcspi_work()). If I'm interpreting the documentation correctly,
> the enable bit starts the clocks, meaning that the chip will begin
> clocking out data before CS is brought high. I must be missing something
> here, no?
> 
> For reference, I included a short list of relevant commits below, largely for
> my own benefit. I would greatly appreciate any feedback you might have.
> 
> Thanks,
> - Ben
> 
> 
> pxa2xx_spi: a7bb3909b3293d503211d7f6af8ed62c1644b686
> bfin_spi: 42c78b2bf51bafb4cfa98dfecc28dd9b8bcd04b0

