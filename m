From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] This patch fixes "scheduling while atomic" bug when
	driver is unloaded.
Date: Tue, 10 Jun 2008 14:02:12 -0700
Message-ID: <20080610210211.GK23796@atomide.com>
References: <1213100196-28474-1-git-send-email-roman.tereshonkov@nokia.com> <20080610190312.GA4881@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53137 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbYFJVCQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jun 2008 17:02:16 -0400
Content-Disposition: inline
In-Reply-To: <20080610190312.GA4881@kedavra.cpe.vivax.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Roman Tereshonkov <roman.tereshonkov@nokia.com>, linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [080610 12:05]:
> On Tue, Jun 10, 2008 at 03:16:36PM +0300, Tereshonkov Roman wrote:
> > 
> > Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
> 
> tsc2005_disable() sleeps.
> 
> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

Pushing today.

Tony


> > ---
> >  drivers/input/touchscreen/tsc2005.c |    5 ++---
> >  1 files changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
> > index fa01799..408caf0 100644
> > --- a/drivers/input/touchscreen/tsc2005.c
> > +++ b/drivers/input/touchscreen/tsc2005.c
> > @@ -661,11 +661,10 @@ err1:
> >  static int __devexit tsc2005_remove(struct spi_device *spi)
> >  {
> >  	struct tsc2005 *ts = dev_get_drvdata(&spi->dev);
> > -	unsigned long flags;
> >  
> > -	spin_lock_irqsave(&ts->lock, flags);
> > +	mutex_lock(&ts->mutex);
> >  	tsc2005_disable(ts);
> > -	spin_unlock_irqrestore(&ts->lock, flags);
> > +	mutex_unlock(&ts->mutex);
> >  
> >  	device_remove_file(&ts->spi->dev, &dev_attr_disable_ts);
> >  	device_remove_file(&ts->spi->dev, &dev_attr_pen_down);
> > -- 
> > 1.5.5.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> Best Regards,
> 
> Felipe Balbi
> me@felipebalbi.com
> http://blog.felipebalbi.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
