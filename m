From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] twl4030-madc: Fix arbitrarily initialized function
	pointer
Date: Mon, 4 Aug 2008 17:31:50 +0300
Message-ID: <20080804143149.GL8885@atomide.com>
References: <1215005796-10117-1-git-send-email-viktor.rosendahl@nokia.com> <1215005796-10117-2-git-send-email-viktor.rosendahl@nokia.com> <f30014d3264cbcef10a9f0342fce7ac2@felipebalbi.com> <1215098777.11098.46.camel@viktor.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51129 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756084AbYHDOcD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 10:32:03 -0400
Content-Disposition: inline
In-Reply-To: <1215098777.11098.46.camel@viktor.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Viktor Rosendahl <Viktor.Rosendahl@nokia.com>
Cc: ext Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org

* Viktor Rosendahl <Viktor.Rosendahl@nokia.com> [080703 18:37]:
> 
> > 
> > > +		req.func_cb	= NULL;
> > 
> > maybe below is a better patch:
> > 
> > diff --git a/drivers/i2c/chips/twl4030-madc.c
> > b/drivers/i2c/chips/twl4030-madc.c
> > index 72b126b..6d8915e 100644
> > --- a/drivers/i2c/chips/twl4030-madc.c
> > +++ b/drivers/i2c/chips/twl4030-madc.c
> > @@ -360,7 +360,7 @@ static int twl4030_madc_ioctl(struct inode *inode,
> > struct file *filp,
> >  
> >         switch (cmd) {
> >         case TWL4030_MADC_IOCX_ADC_RAW_READ: {
> > -               struct twl4030_madc_request req;
> > +               static struct twl4030_madc_request req;
> >                 if (par.channel >= TWL4030_MADC_MAX_CHANNELS)
> >                         return -EINVAL;
> 
> I don't like this idea because:
> 
> - It's fragile. This struct, which is not a const, gets initialized only
> once but we are still passing a pointer to it, expecting that a fairly
> complex function will not modify it. This assertion is probably true
> today but makes it easier for somebody to create a bug in the future.
> 
> - You introduce another shared datum and it is only protected by the BKL
> in fs/ioctl.c:vfs_ioctl().
> 
> - I didn't see any argument why this variable should be static. Making
> local variables static just to get cheap zero initialization is a weird
> thing to do IMO.

Pushing the original patch.

Tony
