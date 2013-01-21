From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] i2c: omap: fix draining irq handling
Date: Mon, 21 Jan 2013 20:01:59 +0200
Message-ID: <20130121180159.GB13174@blackmetal.musicnaut.iki.fi>
References: <1358707022-26477-1-git-send-email-aaro.koskinen@iki.fi>
 <20130121084431.GG8777@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:43430 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751Ab3AUSCE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jan 2013 13:02:04 -0500
Content-Disposition: inline
In-Reply-To: <20130121084431.GG8777@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Wolfram Sang <w.sang@pengutronix.de>
Cc: ben-linux@fluff.org, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org

Hi,

On Mon, Jan 21, 2013 at 10:44:31AM +0200, Felipe Balbi wrote:
> On Sun, Jan 20, 2013 at 08:37:02PM +0200, Aaro Koskinen wrote:
> > Commit 0bdfe0cb803dce699ff337c35d8e97ac355fa417 (i2c: omap: sanitize
> > exit path) changed the interrupt handler to exit early and complete
> > the transfer after the draining IRQ is handled. As a result, the ARDY
> > may not be cleared properly, and it may cause all future I2C transfers
> > to timeout with "timeout waiting for bus ready". This is reproducible
> > at least with N900 when twl4030_gpio makes a long write (> FIFO size)
> > during the probe (http://marc.info/?l=linux-omap&m=135818882610432&w=2).
> > 
> > The fix is to continue until we get ARDY interrupt that completes the
> > transfer. Tested with 3.8-rc4 + N900: 20 boots in a row without errors;
> > without the patch the problem triggers after few reboots.
> 
> fair enough, but ...
> 
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > ---
> >  drivers/i2c/busses/i2c-omap.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index 832f16e..4cc2f05 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -963,7 +963,7 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
> >  				i2c_omap_errata_i207(dev, stat);
> >  
> >  			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_RDR);
> > -			break;
> > +			continue;
> 
> ... when we get draining Interrupt, it means we're receiving the last
> few bytes, meaning that by the time we handle it there's nothing pending
> to be transferred.
> 
> I would rather wait for ARDY before exiting omap_i2c_xfer_msg() rather
> than here. Specially since that was the programming model suggested by
> our IP engineers. Such handling is part of my other patchset and can be
> easily ported.
> 
> OTOH, we might decide to go with this during this -rc and fix it all up
> for v3.9 on my other patchset.

Completing through ARDY interrupt has been known to work reliably for
years. So for 3.8-rc I would prefer to just restore the old behaviour.

A.
