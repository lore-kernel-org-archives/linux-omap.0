From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: musb_vbus_store(): dont exit with spinlock
	held
Date: Mon, 17 Sep 2007 11:26:19 -0700
Message-ID: <20070917182619.GF21226@atomide.com>
References: <20070831232922.937939666@mvista.com>
	<20070901021526.14CFF23518D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070901021526.14CFF23518D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [070831 19:15]:
> > From linux-omap-open-source-bounces+david-b=pacbell.net@linux.omap.com  Fri Aug 31 16:33:11 2007
> > Date: Fri, 31 Aug 2007 16:29:22 -0700
> > From: Kevin Hilman <khilman@mvista.com>
> > To: linux-omap-open-source@linux.omap.com
> > Subject: [PATCH] ARM: OMAP: musb_vbus_store(): dont exit with spinlock held
> >
> > Signed-off-by: Kevin Hilman <khilman@mvista.com>
> 
> Ack.
> 
> > ---
> >  drivers/usb/musb/musb_core.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > Index: dev/drivers/usb/musb/musb_core.c
> > ===================================================================
> > --- dev.orig/drivers/usb/musb/musb_core.c
> > +++ dev/drivers/usb/musb/musb_core.c
> > @@ -1683,11 +1683,12 @@ musb_vbus_store(struct device *dev, stru
> >  	unsigned long	flags;
> >  	unsigned long	val;
> >  
> > -	spin_lock_irqsave(&musb->lock, flags);
> >  	if (sscanf(buf, "%lu", &val) < 1) {
> >  		printk(KERN_ERR "Invalid VBUS timeout ms value\n");
> >  		return -EINVAL;
> >  	}
> > +
> > +	spin_lock_irqsave(&musb->lock, flags);
> >  	musb->a_wait_bcon = val;
> >  	if (musb->xceiv.state == OTG_STATE_A_WAIT_BCON)
> >  		musb->is_active = 0;

This too, sorry for the delay I guess I forgot to push these earlier.

Tony
