From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 3/3] ARM: OMAP2+: AM43x: L2 cache support
Date: Wed, 9 Apr 2014 17:23:27 +0100
Message-ID: <20140409162327.GH27282@n2100.arm.linux.org.uk>
References: <cover.1396605300.git.nsekhar@ti.com> <efa5fda5ae625a43fac14bf173cbd96ad7b44e7a.1396605300.git.nsekhar@ti.com> <20140404101808.GG27282@n2100.arm.linux.org.uk> <53440D73.6060504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:55710 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933352AbaDIQYA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2014 12:24:00 -0400
Content-Disposition: inline
In-Reply-To: <53440D73.6060504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>

On Tue, Apr 08, 2014 at 08:23:39PM +0530, Sekhar Nori wrote:
> On Friday 04 April 2014 03:48 PM, Russell King - ARM Linux wrote:
> > On Fri, Apr 04, 2014 at 03:40:29PM +0530, Sekhar Nori wrote:
> >> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> >> index f8b8dac..6b2a056 100644
> >> --- a/arch/arm/mach-omap2/omap4-common.c
> >> +++ b/arch/arm/mach-omap2/omap4-common.c
> >> @@ -224,6 +224,14 @@ int __init omap4_l2_cache_init(void)
> >>  
> >>  	return omap_l2_cache_init(aux_ctrl, 0xc19fffff);
> >>  }
> >> +
> >> +int __init am43xx_l2_cache_init(void)
> >> +{
> >> +	u32 aux_ctrl = L310_AUX_CTRL_DATA_PREFETCH |
> >> +		       L310_AUX_CTRL_INSTR_PREFETCH;
> > 
> > It would be good to documenting the difference between this and OMAP4,
> > and why you have chosen different values.
> 
> There are two main differences:
> 
> 1) OMAP4 sets Shared attribute override enable bit. TBH, I think this is
> not needed even in OMAP4 with latest kernel, but I am not sure if I can
> do this safely without breaking any usecase currently working with OMAP4.
> 
> 2) OMAP4 sets NS lockdown and NS interrupt access control bits. I
> searched through the commit history of L2 cache support on OMAP4 but
> there is no mention of why this was needed on OMAP4. I am checking
> internally on the history behind this.

That is required because as part of the enable sequence, we write to the
lockdown registers to clear out anything that may be there before we
enable the L2 cache.  If we didn't set the NS lockdown bit, then we
would need the secure monitor to do it for us.

The NS interrupt access bit is also a good idea to be set, since this
allows us to eventually support EDAC with PL310.  As we don't support
EDAC at the moment, or touch the interrupt registers, we can probably
ignore this difference and just preserve whatever value is there for
the time being.

Both of these bits should be managed within the L2C code rather than by
platforms.

> 3) OMAP4 sets cache replacement policy to RR which is not a big deal
> since thats the default anyway. We can probably drop this setting even
> from OMAP4.

Yes, since that would just be a case of preserving that bit.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
