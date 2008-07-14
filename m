From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 04/09] OMAP PM srf implementation
Date: Mon, 14 Jul 2008 20:24:53 +0530
Message-ID: <025001c8e5c1$93e534e0$68bf18ac@ent.ti.com>
References: <030b01c8e0ef$46c859c0$68bf18ac@ent.ti.com> <20080714132909.GA4639@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37975 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753958AbYGNOzJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jul 2008 10:55:09 -0400
In-Reply-To: <20080714132909.GA4639@codecarver.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Peter 'p2' De Schrijver' <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi Peter,
 
> -----Original Message-----
> From: Peter 'p2' De Schrijver [mailto:peter.de-schrijver@nokia.com] 
> Sent: Monday, July 14, 2008 6:59 PM
> To: ext Rajendra Nayak
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 04/09] OMAP PM srf implementation
> 
> Hi Rajendra,
> 
> > +void omap_pm_set_min_bus_tput(struct device *dev, struct 
> bus_type *bus,
> > +				    unsigned long r)
> 
> According to Paul's prototypes this should be 
> void omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, 
> 			      unsigned long r)
> 				
> > +{
> > +	if (!dev) {
> > +		WARN_ON(1);
> > +		return;
> > +	};
> > +
> > +	if (r == 0)
> > +		pr_debug("OMAP PM: remove min bus tput constraint: "
> > +			 "dev %p for bus %s\n", dev, bus->name);
> > +	else
> > +		pr_debug("OMAP PM: add min bus tput constraint: "
> > +			 "dev %p for bus %s: rate %ld KiB\n", dev,
> > +			 bus->name, r);
> > +
> > +	/*
> > +	 * This code should model the bus and compute the required
> > +	 * bus frequency, convert that to a VDD2 OPP ID, then 
> set the VDD2
> > +	 * OPP appropriately.
> > +	 *
> > +	 * TI CDP code can call constraint_set here on the VDD2 OPP.
> > +	 */
> > +}
> > +
> 
> omap_pm_if_early_init and omap_pm_if_init are missing. I added dummy
> functions for those.
> 
> With all of these changes it seems to work.

Yes, I probably was using an older omap-pm-noop patch from Paul. 
I did not refresh it since, the later one sent was again not the final one.
I though I would refresh it once the final version is posted.

Paul,
Would you be posting another version of this with changes as suggested 
by Jouni? 

> 
> Cheers,
> 
> Peter.
> 
> -- 
> goa is a state of mind
> 

