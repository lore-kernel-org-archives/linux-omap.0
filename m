From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/2] i2c: i2c-omap: Call request_irq with IRQF_DISABLED
Date: Wed, 11 Mar 2009 21:16:20 +0200
Message-ID: <20090311185439.GB19730@gandalf>
References: <cover.1236345858.git.Ext-Ari.Kauppi@nokia.com> <7d7e7dd1a4c64c732a21bdfcf2bd42556be708c3.1236345858.git.Ext-Ari.Kauppi@nokia.com> <20090310005222.GE19758@fluff.org.uk>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:53556 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754264AbZCKTQe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 15:16:34 -0400
Content-Disposition: inline
In-Reply-To: <20090310005222.GE19758@fluff.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben@fluff.org.uk>
Cc: Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, ben-linux@fluff.org, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org

On Tue, Mar 10, 2009 at 12:52:22AM +0000, Ben Dooks wrote:
> On Fri, Mar 06, 2009 at 03:34:54PM +0200, Ari Kauppi wrote:
> > I have observed some Spurious IRQ's for I2C1 when all kernel hacking options
> > (and thus LOCKDEP) are disabled.
> > 
> > Applying Richard Woodruff's 'I2C bug fixes for L-O and L-Z' seems to help
> > but IRQF_DISABLED is needed for proper behaviour.
> > 
> > Signed-off-by: Ari Kauppi <Ext-Ari.Kauppi@nokia.com>
> > Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
> > ---
> >  drivers/i2c/busses/i2c-omap.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index 0c3ed41..18af43f 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -847,7 +847,7 @@ omap_i2c_probe(struct platform_device *pdev)
> >  	omap_i2c_init(dev);
> >  
> >  	isr = (dev->rev < OMAP_I2C_REV_2) ? omap_i2c_rev1_isr : omap_i2c_isr;
> > -	r = request_irq(dev->irq, isr, 0, pdev->name, dev);
> > +	r = request_irq(dev->irq, isr, IRQF_DISABLED, pdev->name, dev);
> 
> Is disabling all IRQs on the system the right thing to do?

if not we could fall into stack overflow, right ?

-- 
balbi
