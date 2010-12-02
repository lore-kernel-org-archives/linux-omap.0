From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP MUX framework changes
Date: Thu, 2 Dec 2010 14:02:37 -0800
Message-ID: <20101202220237.GY17222@atomide.com>
References: <1290017211-2217-1-git-send-email-dmurphy@ti.com>
 <20101119174721.GT9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:35030 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757867Ab0LBWCq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 17:02:46 -0500
Content-Disposition: inline
In-Reply-To: <20101119174721.GT9264@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, paul@pwsan.com, khilman@deeprootsystems.com

* Tony Lindgren <tony@atomide.com> [101119 09:38]:
> * Dan Murphy <dmurphy@ti.com> [101117 09:58]:
> > --- a/arch/arm/mach-omap2/mux.c
> > +++ b/arch/arm/mach-omap2/mux.c
> >  
> > +static struct omap_mux *omap_mux_get_by_mux(struct omap_mux_partition *partition,
> > +					char *name)
> > +{
> > +	struct omap_mux_entry *e;
> > +	int i = 0;
> > +
> > +	list_for_each_entry(e, &partition->muxmodes, node) {
> > +		struct omap_mux *m = &e->mux;
> > +		for (i = 0; i < OMAP_MUX_NR_MODES; i++) {
> > +			if (m->muxnames[i] == NULL)
> > +				break;
> > +			else if (!strcmp(name, m->muxnames[i]))
> > +				return m;
> > +		}
> > +	}
> > +
> > +	return NULL;
> > +}
> 
> Hmm turns out we almost have this already in _omap_mux_init_signal.
> Also we need to know the mux mode value to make use of this, so
> how about the patch below instead?

Will post a better version soon.

Tony
