From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/9] omap: improve OMAP3_HAS_FEATURE
Date: Thu, 8 Jul 2010 12:24:33 +0300
Message-ID: <20100708092433.GA1920@atomide.com>
References: <1277259375-18521-1-git-send-email-nm@ti.com>
 <1277259375-18521-5-git-send-email-nm@ti.com>
 <20100707122804.GR1920@atomide.com>
 <4C347DEA.6090206@ti.com>
 <20100707133024.GX1920@atomide.com>
 <4C348628.80307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56912 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785Ab0GHJYn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 05:24:43 -0400
Content-Disposition: inline
In-Reply-To: <4C348628.80307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "S, Venkatraman" <svenkatr@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "S, Vishwanath" <vishwa.s@ti.com>

* Nishanth Menon <nm@ti.com> [100707 16:44]:
 
> >>overall, we will face this in the future. there are OMAP generic
> >>features and OMAP family specific features. currently OMAP3 has
> >>34xx, 35xx series and 3630 and 37xx series. in future we may see
> >>similar things for OMAP4+ as well.. we need a differentiator when it
> >>comes to omap3 specific features Vs omap generic feature.
> >
> >Sounds it will get more complex.. We should probably set it up
> >with something like this then:
> >
> >#define FEAT_MPU_L2_OUTER	BIT(1)
> >#define FEAT_MPU_L2		BIT(0)
> >...
> >
> >#define FEAT_IVA2		BIT(1)
> >#define FEAT_IVA		BIT(0)
> >...
> >
> >#define FEAT_L3_192		BIT(0)
> >...
> >
> >struct omap_feature {
> >	u32	mpu;		/* MPU features */
> >	u32	iva;		/* IVA features */
> >	u32	l3_max_clk;
> >	...
> >};
> I think I understand your intent here is to introduce per IP based
> feature - that is really not necessary yet (we dont really have a
> usecase needing this level of complexity yet). it will be a natural
> evolution when we need to have such a feature handling.

But we already have a problem where we need to check for various
revisions and features and use cpu_is_omapxxxx. It would be nice to
just call omap_has_feature without having to worry about which omap
it is.
 
> currently a need for errata handling per ip is required, and we have
> a mechanism (quirks) to handle it on a IP basis. here the intent was
> to identify OMAP specific features in some common way.

OK. I'll post an experimental series shortly, let's see if that
works for you.

Regards,

Tony
