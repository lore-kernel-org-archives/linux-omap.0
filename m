From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v3 10/13] OMAP: DMA: Convert DMA library into DMA
 platform Driver
Date: Wed, 10 Nov 2010 19:32:28 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7CC4@dbde02.ent.ti.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-11-git-send-email-manjugk@ti.com>
 <871v6uhy9p.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40469 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab0KJOCj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 09:02:39 -0500
In-Reply-To: <871v6uhy9p.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>


> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Wednesday, November 10, 2010 4:59 AM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org; Cousson, Benoit; 
> Shilimkar, Santosh
> Subject: Re: [PATCH v3 10/13] OMAP: DMA: Convert DMA library 
> into DMA platform Driver
> 
> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> 
[...]
> >  
> >  obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
> > diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
> > index e756069..38a7294 100644
> > --- a/arch/arm/mach-omap1/dma.c
> > +++ b/arch/arm/mach-omap1/dma.c
> > @@ -35,6 +35,81 @@
> >  #include <plat/tc.h>
> >  
> >  #define OMAP1_DMA_BASE			(0xfffed800)
> > +#define OMAP1_LOGICAL_DMA_CH_COUNT	17
> > +
> > +static u32 errata;
> > +static u32 enable_1510_mode;
> > +
> > +enum {
> > +	GCR1 = 0,	GSCR,		GRST,		HW_ID,
> > +	PCH2_ID,	PCH0_ID,	PCH1_ID,	PCHG_ID,
> > +	PCHD_ID,	CAPS_0_U,	CAPS_0_L,	CAPS_1_U,
> > +	CAPS_1_L,	CAPS_2,		CAPS_3,		CAPS_4,
> > +	PCH2_SR,	PCH0_SR,	PCH1_SR,	PCHD_SR,
> > +
> > +	CH_COMMON_START,
> > +
> > +	/* Common Registers */
> > +	CSDP1,		CCR1,		CICR1,		CSR1,
> > +	CEN1,		CFN1,		CSFI1,		CSEI1,
> > +	CPC,		CSAC1,		CDAC1,		CDEI1,
> > +	CDFI1,		CLNK_CTRL1,
> > +
> > +	/* Channel specific register offsets */
> > +	CSSA_L,		CSSA_U,		CDSA_L,		CDSA_U,
> > +	COLOR_L,	COLOR_U,	CCR1_2,		LCH_CTRL,
> > +
> > +	CH_COMMON_END,
> > +};
> 
> These reg_map enums are added here, then promptly moved in 
> the following
> patch.  Please just put them in the right place earlier in the series.
> Also, at this point, similar versions also still exist in
> plat-omap/dma.c
> 
> This may be a good technique for inflating the number of lines changed
> in the git history, but it is not review friendly.

Thanks. With Tony's suggestion, these duplicate enums will not exist with
next version since there will be common enum in plat-omap from patch-1 of
the series. only reg_map tables will be moved to respective mach-omap dma
files from plat-omap.

-Manjunath
