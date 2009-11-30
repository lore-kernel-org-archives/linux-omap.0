From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/8] omap2: mux: intoduce omap_mux_{read,write}
Date: Mon, 30 Nov 2009 10:54:15 -0800
Message-ID: <20091130185415.GT4348@atomide.com>
References: <20091126001646.1546.34352.stgit@localhost>
 <20091126001849.1546.76887.stgit@localhost>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BBE6475E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61171 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815AbZK3SyR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 13:54:17 -0500
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BBE6475E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mike Rapoport <mike@compulab.co.il>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [091129 02:02]:
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Tony Lindgren
> > Sent: Thursday, November 26, 2009 5:49 AM
> > To: linux-arm-kernel@lists.infradead.org
> > Cc: linux-omap@vger.kernel.org; Mike Rapoport
> > Subject: [PATCH 1/8] omap2: mux: intoduce omap_mux_{read,write}
> > 
> > From: Mike Rapoport <mike@compulab.co.il>
> > 
> > intoduce omap_mux_{read,write}

<snip>
 
> >  int __init omap2_mux_init(void)
> >  {
> > +	u32 mux_pbase;
> > +
> > +	if (cpu_is_omap2420())
> > +		mux_pbase = OMAP2420_CTRL_BASE + OMAP_MUX_BASE_OFFSET;
> > +	else if (cpu_is_omap2430())
> > +		mux_pbase = OMAP243X_CTRL_BASE + OMAP_MUX_BASE_OFFSET;
> > +	else if (cpu_is_omap34xx())
> > +		mux_pbase = OMAP343X_CTRL_BASE + OMAP_MUX_BASE_OFFSET;
> > +
> > +	mux_base = ioremap(mux_pbase, OMAP_MUX_BASE_SZ);
> 
> The control modules on OMAP's divided into 2 domains with different base address
> 1. pads in CORE power domain
> 2. Pads in wakeup domain.
> 
> If we map these two separately, then we can differentiate the wakeup capable pads.
> Not sure whether I am making any sense here but just thought it would be useful.

OK, maybe we can consider doing that later on.

If we separate the core and wakeup domains for muxing, we should
do it in a way where it's transparent to the users. Otherwise
the the muxing again gets confusing easily if we have separate sets
of functions for the core and wakeup domains.

Regards,

Tony

