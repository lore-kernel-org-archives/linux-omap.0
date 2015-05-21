From: Michael Welling <mwelling@ieee.org>
Subject: Re: [PATCH] spi: omap2-mcspi: Fix native cs with new set_cs
Date: Thu, 21 May 2015 18:48:33 -0500
Message-ID: <20150521234832.GA1827@deathray>
References: <1431452337-19280-1-git-send-email-mwelling@ieee.org>
 <20150512191758.GX3066@sirena.org.uk>
 <20150521020709.GA14258@deathray>
 <20150521101857.GR21577@sirena.org.uk>
 <20150521210411.GA5406@deathray>
 <20150521211638.GN21577@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:35181 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbbEUXsk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 May 2015 19:48:40 -0400
Content-Disposition: inline
In-Reply-To: <20150521211638.GN21577@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 21, 2015 at 10:16:38PM +0100, Mark Brown wrote:
> On Thu, May 21, 2015 at 04:04:11PM -0500, Michael Welling wrote:
> 
> > Do you want to revert the patch and apply a new one or should I provide a
> > patch that reverts the changes and fixes it all in one?
> 
> Can you please send me separate revert and re-add patches, that's
> probably going to be easier to review.

So after reverting this patch I found there is a issue in that it is difficult
to determine when a transfer is complete to properly drive the chipselect from
within the transfer_one function.

Then I figured that we could handle the case when GPIOs are being used with
some conditional calls to omap2_mcspi_set_cs in the omap2_mcspi_work_one
function.

Near the beginning of the function I added:
	if (gpio_is_valid(spi->cs_gpio))
		omap2_mcspi_set_cs(spi, 0);

Near the end of the function I added:
	if (gpio_is_valid(spi->cs_gpio))
		omap2_mcspi_set_cs(spi, 1);

This makes GPIO chip select support work while leaving the native working
as previous.

Is this solution acceptible?

In the process of reviewing the changes I found a few other things that
should be changed as well.

Here you will see a delay that is already handled by the core spi driver:
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/drivers/spi/spi-omap2-mcspi.c#n1166

In the set_cs function the inversion of the enable that occurs in the
core spi_set_cs function based on SPI_CS_HIGH needs to revert as the
controller handles the inversion with OMAP2_MCSPI_CHCONF_EPOL bit in the
CHCONF register.

If you approve of the fix for the GPIO support, I will provide a patch
series with all of these above mentioned fixes.
