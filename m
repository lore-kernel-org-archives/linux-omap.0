From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [RFC part1/2 merge v3][PATCH 01/10] OMAP3: serial: Check for
 zero-based physical addr
Date: Tue, 9 Mar 2010 10:30:08 -0600
Message-ID: <A24693684029E5489D1D202277BE894453E4D72D@dlee02.ent.ti.com>
References: <1268151414-17071-1-git-send-email-saaguirre@ti.com>
 <1268151414-17071-2-git-send-email-saaguirre@ti.com>
 <20100309162115.GJ3851@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57558 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754290Ab0CIQaQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 11:30:16 -0500
In-Reply-To: <20100309162115.GJ3851@gandalf>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Hi Felipe,

From: Felipe Balbi [mailto:me@felipebalbi.com]
Sent: Tuesday, March 09, 2010 10:21 AM
> On Tue, Mar 09, 2010 at 10:16:45AM -0600, Sergio Aguirre wrote:
> > @@ -664,6 +664,12 @@ void __init omap_serial_early_init(void)
> >  		struct device *dev = &pdev->dev;
> >  		struct plat_serial8250_port *p = dev->platform_data;
> >
> > +		/* Don't map zero-based physical address */
> > +		if (p->mapbase == 0) {
> > +			printk(KERN_WARNING "omap serial: No physical address"
> > +			       " for uart#%d, so skipping early_init...\n", i);
> > +			continue;
> 
> you have a *dev available, could you use some of the dev_* macros ? Then
> it's easy to know from where the message come from.

Ok, I didn't do that, since there are other printks in the same function.

I can change it here, no problem.

I guess I can add a separate patch to standardize and change all
printks to dev_* macros... would that make sense?

> 
> > @@ -727,6 +733,14 @@ void __init omap_serial_init_port(int port)
> >  	pdev = &uart->pdev;
> >  	dev = &pdev->dev;
> >
> > +	/* Don't proceed if there's no clocks available */
> > +	if (unlikely(!uart->ick || !uart->fck)) {
> > +		printk(KERN_ERR "Can't init uart%d, no clocks available\n",
> > +		       port);
> > +		WARN_ON(1);
> 
> change printk() + WARN_ON() into:
> 
> WARN(1, "%s: can't init uart%d, no clocks available\n",
> 	koject_name(&dev->kobj), port);

That looks nicer. Thanks!

Regards,
Sergio

> 
> --
> balbi
