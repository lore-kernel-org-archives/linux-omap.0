From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] OMAP: features: export symbol omap3_features
Date: Fri, 24 Sep 2010 11:17:51 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009241114290.10678@utopia.booyaka.com>
References: <1285299665-21639-1-git-send-email-omar.ramirez@ti.com> <alpine.DEB.2.00.1009240920370.10678@utopia.booyaka.com> <4C9CD72E.40407@ti.com> <alpine.DEB.2.00.1009241053400.10678@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43996 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985Ab0IXRRw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 13:17:52 -0400
In-Reply-To: <alpine.DEB.2.00.1009241053400.10678@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Russell King <linux@arm.linux.org.uk>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, 24 Sep 2010, Paul Walmsley wrote:

> On Fri, 24 Sep 2010, Nishanth Menon wrote:
> 
> > The intent of omap_has_featureX() is to ensure that the drivers dont do
> > cpu_is_omap123(). Now if we had OMAP dma driver which has DMA chaining - what
> > options do we have DMA driver?
> > 
> > a) we introduce it based on cpu_is_omap123() -> bad bad nightmare for
> > maintenance
> > b) we introduce it based on module h/w block(TI internal terminology "IP
> > block") revision -> unfortunately no luck in some of the h/w blocks.
> > c) we use if (omap_has_dma_chaining())
> 
> d) you pass in errata/feature flags via a platform_data struct, like 
> McBSP, McSPI, MMC, MUSB, I2C, etc. already do on OMAP.  On OMAP1, which 
> doesn't have hwmod support, you set your platform_data in your OMAP1 
> integration code.  On OMAP2+ (which has hwmod support), you define your 
> errata/feature flags and any other integration data that you need to pass 
> via the struct omap_hwmod.dev_attr field, then pass that data via struct 
> platform_data in the OMAP2+ integration code.

Just to clarify something that may be unclear: there's no problem with 
calling cpu_is_omapXXXX(), or any other OMAP core-specific function, from 
the OMAP<->driver integration code, living in arch/arm/*omap*.  The 
results of those functions can then be passed through platform_data.  But 
there is a problem with calling OMAP core-specific functions directly from 
the driver code itself, since driver code should be completely 
platform-independent -- e.g., the same DMA controller could exist on OMAP, 
DaVinci, etc.


- Paul
