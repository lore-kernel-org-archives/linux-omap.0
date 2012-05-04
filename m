From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/3] IRQ: allow check_wakeup_irqs to notice level-triggered
 interrupts.
Date: Fri, 4 May 2012 18:01:22 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1205041759540.6271@ionos>
References: <20120425025637.7832.14013.stgit@notabene.brown> <20120425030524.7832.85239.stgit@notabene.brown> <alpine.LFD.2.02.1204251018530.2542@ionos> <20120425193916.0db1b4b1@notabene.brown> <alpine.LFD.2.02.1204251402360.2542@ionos>
 <20120504151221.6998d4e5@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120504151221.6998d4e5@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Neil,

On Fri, 4 May 2012, NeilBrown wrote:

> On Wed, 25 Apr 2012 14:54:54 +0200 (CEST) Thomas Gleixner
> <tglx@linutronix.de> wrote:
> 
> > Why not simply managing the pending bit for level irqs ?
> > 
> 
> Hi Thomas,
>  thanks again for the patch.  I finally made time to test it and it works as
> expected.  I've included it below with a change-log entry and tested-by:
> in case that helps.

thanks for testing. The changelog is great. You know how to make the
live of lazy buggers easier :)
  
>  	for_each_irq_desc(irq, desc) {
> -		if (irqd_is_wakeup_set(&desc->irq_data)) {
> +		if (desc->depth == 1 &&
> +		    irqd_is_wakeup_set(&desc->irq_data)) {
>  			if (desc->istate & IRQS_PENDING)
>  				return -EBUSY;
>  			continue;

I split that part into a separate patch, as it's really a different
issue.

Thanks,

	tglx
