From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] AM35xx: Add clock support for new modules on
 AM35xx
Date: Tue, 19 Jan 2010 12:52:02 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001191250200.3977@utopia.booyaka.com>
References: <1263892836-2390-1-git-send-email-ranjithl@ti.com> <alpine.DEB.2.00.1001191243460.3977@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50507 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926Ab0ASTwE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 14:52:04 -0500
In-Reply-To: <alpine.DEB.2.00.1001191243460.3977@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ranjith Lohithakshan <ranjithl@ti.com>
Cc: linux-omap@vger.kernel.org


One more thing.

On Tue, 19 Jan 2010, Paul Walmsley wrote:

> On Tue, 19 Jan 2010, Ranjith Lohithakshan wrote:
>
> > diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
> > index 6923deb..4ff0e24 100644
> > --- a/arch/arm/mach-omap2/cm-regbits-34xx.h
> > +++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
> > @@ -168,6 +168,12 @@
> >  #define OMAP3430_EN_SDRC				(1 << 1)
> >  #define OMAP3430_EN_SDRC_SHIFT				1
> >  
> > +/* AM35XX specific CM_ICLKEN1_CORE bits */
> > +#define AM35XX_EN_IPSS					(1 << 4)

For masks like the above, please put _MASK on the end of these macros.
I realize that this file is not consistent, but that's the practice that 
we should use going forward, and soon a patch will appear to fix the
old-style mask macros in these files.

> > +#define AM35XX_EN_IPSS_SHIFT				4
> > +#define AM35XX_EN_UART4 				(1 << 23)

same as above

> > +#define AM35XX_EN_UART4_SHIFT				23
> > +
> >  /* CM_ICLKEN2_CORE */
> >  #define OMAP3430_EN_PKA					(1 << 4)
> >  #define OMAP3430_EN_PKA_SHIFT				4
> > @@ -220,6 +226,10 @@
> >  #define OMAP3430_ST_SSI_STDBY_SHIFT			0
> >  #define OMAP3430_ST_SSI_STDBY_MASK			(1 << 0)
> >  
> > +/* AM35xx specific CM_IDLEST1_CORE bits */
> > +#define AM35XX_ST_IPSS_SHIFT				5
> > +#define AM35XX_ST_IPSS_MASK 				(1 << 5)
> > +
> >  /* CM_IDLEST2_CORE */
> >  #define OMAP3430_ST_PKA_SHIFT				4
> >  #define OMAP3430_ST_PKA_MASK				(1 << 4)


- Paul
