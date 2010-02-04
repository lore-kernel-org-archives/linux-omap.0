From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 4/5] ARM: L2 : Errata 588369: Clean & Invalidate do not
	invalidate clean lines
Date: Thu, 4 Feb 2010 21:29:48 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C0B42641@dbde02.ent.ti.com>
References: <1265293547-18960-1-git-send-email-santosh.shilimkar@ti.com>
 <1265293547-18960-2-git-send-email-santosh.shilimkar@ti.com>
 <1265293547-18960-3-git-send-email-santosh.shilimkar@ti.com>
 <1265293547-18960-4-git-send-email-santosh.shilimkar@ti.com>
 <20100204144250.GB27344@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33307 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932478Ab0BDQA1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 11:00:27 -0500
In-Reply-To: <20100204144250.GB27344@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "tony@atomide.com" <tony@atomide.com>, "Woodruff, Richard" <r-woodruff2@ti.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Thursday, February 04, 2010 8:13 PM
> To: Shilimkar, Santosh
> Cc: tony@atomide.com; Woodruff, Richard; catalin.marinas@arm.com; linux-arm-
> kernel@lists.infradead.org; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 4/5] ARM: L2 : Errata 588369: Clean & Invalidate do not invalidate clean lines
> 
> On Thu, Feb 04, 2010 at 07:55:46PM +0530, Santosh Shilimkar wrote:
> > diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> > index 1a14d18..6241f10 100644
> > --- a/arch/arm/mm/cache-l2x0.c
> > +++ b/arch/arm/mm/cache-l2x0.c
> > @@ -56,12 +56,41 @@ static inline void l2x0_inv_line(unsigned long addr)
> >  	writel(addr, base + L2X0_INV_LINE_PA);
> >  }
> >
> > +#ifdef CONFIG_PL310_ERRATA_588369
> > +extern void omap_smc1(u32 fn, u32 arg);
> > +static void debug_writel(unsigned long val)
> > +{
> 
> You could move the external declaration into this function, thereby
> making it entirely local to this function (and hiding it from the
> file scope.)
OK
