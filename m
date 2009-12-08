From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC][RFT][PATCH 3/4 v6] OMAP: McBSP: Introduce caching in
 register write operations
Date: Tue, 8 Dec 2009 08:59:31 -0800
Message-ID: <20091208165931.GR24013@atomide.com>
References: <200912010410.10129.jkrzyszt@tis.icnet.pl>
 <20091207210631.GG24013@atomide.com>
 <20091208093521.3905241c.jhnikula@gmail.com>
 <200912081707.39812.jkrzyszt@tis.icnet.pl>
 <20091208164028.GQ24013@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51844 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932920AbZLHQ7d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 11:59:33 -0500
Content-Disposition: inline
In-Reply-To: <20091208164028.GQ24013@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>

* Tony Lindgren <tony@atomide.com> [091208 08:39]:
> > @@ -391,6 +405,31 @@ int omap_mcbsp_request(unsigned int id)
> >  	}
> >  	mcbsp = id_to_mcbsp_ptr(id);
> >  
> > +	if (cpu_is_omap7xx()) {
> > +		mcbsp->reg_cache = kzalloc(sizeof(u16) *
> > +				OMAP7XX_MCBSP_REG_NUM, GFP_KERNEL);
> > +	} else if (cpu_is_omap15xx()) {
> > +		mcbsp->reg_cache = kzalloc(sizeof(u16) *
> > +				OMAP15XX_MCBSP_REG_NUM, GFP_KERNEL);
> > +	} else if (cpu_is_omap16xx()) {
> > +		mcbsp->reg_cache = kzalloc(sizeof(u16) *
> > +				OMAP16XX_MCBSP_REG_NUM, GFP_KERNEL);
> > +	} else if (cpu_is_omap2420()) {
> > +		mcbsp->reg_cache = kzalloc(sizeof(u16) *
> > +				OMAP24XX_MCBSP_REG_NUM, GFP_KERNEL);
> > +	} else if (cpu_is_omap2430()) {
> > +		mcbsp->reg_cache = kzalloc(sizeof(u32) *
> > +				OMAP24XX_MCBSP_REG_NUM, GFP_KERNEL);
> > +	} else if (cpu_is_omap34xx()) {
> > +		mcbsp->reg_cache = kzalloc(sizeof(u32) *
> > +				OMAP34XX_MCBSP_REG_NUM, GFP_KERNEL);
> > +	} else if (cpu_is_omap44xx()) {
> > +		mcbsp->reg_cache = kzalloc(sizeof(u32) *
> > +				OMAP44XX_MCBSP_REG_NUM, GFP_KERNEL);
> > +	}
> 
> How about just set the cache size above based on the processor,
> then do kzalloc here:
> 
> mcbsp->reg_cache = kzalloc(size, GFP_KERNEL);
> > +	if (!mcbsp->reg_cache)
> > +		return -ENOMEM;
> > +
> 
> That way the kzalloc and error checking are in the same place.

Actually since we already have mach-omap1/mcbsp.c and mach-omap2/mcbsp.c,
it would be best to pass the cache size from omap1_mcbsp_init and
omap2_mcbsp_init. That leaves some of the if cpu_is_omapxxxx() else
stuff.

Regards,

Tony
