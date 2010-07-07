From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/9] omap: improve OMAP3_HAS_FEATURE
Date: Wed, 7 Jul 2010 16:30:24 +0300
Message-ID: <20100707133024.GX1920@atomide.com>
References: <1277259375-18521-1-git-send-email-nm@ti.com>
 <1277259375-18521-5-git-send-email-nm@ti.com>
 <20100707122804.GR1920@atomide.com>
 <4C347DEA.6090206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61048 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755531Ab0GGNae (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 09:30:34 -0400
Content-Disposition: inline
In-Reply-To: <4C347DEA.6090206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "S, Venkatraman" <svenkatr@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "S, Vishwanath" <vishwa.s@ti.com>

* Nishanth Menon <nm@ti.com> [100707 16:09]:
> >
> >Why don't you just rename u32 omap3_features to omap_features?
> >
> >Then maybe move omap_features to plat-omap/common.c, and have
> >a generic function for getting features?
> >
> >There should not be any need to have separate features variable
> >for each omap.
> 192Mhz_clk is a OMAP3 only feature(differentiator b/w omap3430,35xx
> and 3630, 37xx).

Hmm, maybe it should be defined as l3_max_clk or similar instead?
 
> overall, we will face this in the future. there are OMAP generic
> features and OMAP family specific features. currently OMAP3 has
> 34xx, 35xx series and 3630 and 37xx series. in future we may see
> similar things for OMAP4+ as well.. we need a differentiator when it
> comes to omap3 specific features Vs omap generic feature.

Sounds it will get more complex.. We should probably set it up
with something like this then:

#define FEAT_MPU_L2_OUTER	BIT(1)
#define FEAT_MPU_L2		BIT(0)
...

#define FEAT_IVA2		BIT(1)
#define FEAT_IVA		BIT(0)
...

#define FEAT_L3_192		BIT(0)
...

struct omap_feature {
	u32	mpu;		/* MPU features */
	u32	iva;		/* IVA features */
	u32	l3_max_clk;
	...
};

Regards,

Tony
