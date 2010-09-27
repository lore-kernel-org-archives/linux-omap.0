From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 1/5] OMAP: mux: Add support for control module split in
 several partitions
Date: Mon, 27 Sep 2010 10:36:04 -0700
Message-ID: <20100927173604.GY4211@atomide.com>
References: <1285319748-28976-1-git-send-email-b-cousson@ti.com>
 <1285319748-28976-2-git-send-email-b-cousson@ti.com>
 <20100925002228.GP4211@atomide.com>
 <20100927154611.GT4211@atomide.com>
 <4CA0D33C.303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54467 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756989Ab0I0Rf7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Sep 2010 13:35:59 -0400
Content-Disposition: inline
In-Reply-To: <4CA0D33C.303@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

* Cousson, Benoit <b-cousson@ti.com> [100927 10:15]:
> 
> OK for that one, that will save the extra id to store the partition
> in each static data, but then you will still have to store it during
> the init?

For mux.c internal data, we can have an array of struct omap_mux_partition
that contains the mux array for that partition:

struct omap_mux_partition {
	void __iomem	*base;	/* Partition virt base */
	struct omap_mux	*mux;	/* Partition specific mux array */
};
 
> >...
> >For omap2 and 3, we just call omap_mux_init once with the mux_pbase
> >as we currently already do. Then for omap4, we call omap_mux_init for
> >each partition.
> >
> >We also need to change omap_mux_read/write to allow specifying the
> >partition base address:
> 
> Then you need somehow a partition information from somewhere.
> I don't see how we can avoid the id at that point? We can store the
> base address instead, but then every mux entries will have it.

That should only need to be stored once for each partition in the
struct omap_mux_partition?
 
> The caller of the omap_mux_read still have to figure out what base
> address it has to use.
> That move the issue to the upper layer, but we still need that.

For the mux.c internal code, we can search through the array
of struct omap_mux_partition and the mux entries in each partition
for signal name or GPIO number.

> >All the other mux interface functions can stay the same, we just need
> >to modify the mux.c code to look for signal names or GPIO number in
> >each registered partition.
> 
> OK, now I think I understand your point... Please ignore the
> previous comments :-)
> 
> You will guess the partition by trying each array at a time, and the
> first one will win.
> 
> That seems pretty good in fact.
> 
> I just have to do it now...

OK cool, let me know if I can help with something.

Tony
