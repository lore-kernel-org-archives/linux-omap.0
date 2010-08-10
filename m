From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 1/3] OMAP4: prcm: Add temporarily helper functions for
 rmw and read inside the PRM
Date: Tue, 10 Aug 2010 21:46:29 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032401DB30@dbde02.ent.ti.com>
References: <1280959968-23933-1-git-send-email-b-cousson@ti.com>
	<1280959968-23933-2-git-send-email-b-cousson@ti.com>
 <87hbj3lmmo.fsf@deeprootsystems.com> <4C603C0B.4070602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37753 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757616Ab0HJQQe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 12:16:34 -0400
In-Reply-To: <4C603C0B.4070602@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

 

> -----Original Message-----
> From: Cousson, Benoit 
> Sent: Monday, August 09, 2010 11:04 PM
> To: Kevin Hilman
> Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Nayak, 
> Rajendra; Shilimkar, Santosh
> Subject: Re: [PATCH 1/3] OMAP4: prcm: Add temporarily helper 
> functions for rmw and read inside the PRM
> 
> On 8/9/2010 7:30 PM, Kevin Hilman wrote:
> > Benoit Cousson<b-cousson@ti.com>  writes:
> >
> >> Since OMAP4 is using an absolute address, the current PRM accessors
> >> are not useable.
> >> OMAP4 adaptation for these API are currently ongoing, so
> define temp
> >> version until the proper ones are defined.
> >
> > Curious what we're waiting for for the final versions of these?
> 
> That should be soon... Rajendra is working on that... among hundreds 
> other stuff.
> 
> Benoit

I just posted a couple of RFC patches for these now which
can be found here
https://patchwork.kernel.org/patch/118566/
https://patchwork.kernel.org/patch/118568/

> 
> > Kevin
> >
> >> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> >> Cc: Paul Walmsley<paul@pwsan.com>
> >> Cc: Kevin Hilman<khilman@deeprootsystems.com>
> >> ---
> >>   arch/arm/mach-omap2/prcm.c             |   24 
> ++++++++++++++++++++++++
> >>   arch/arm/plat-omap/include/plat/prcm.h |    2 ++
> >>   2 files changed, 26 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/prcm.c 
> b/arch/arm/mach-omap2/prcm.c
> >> index 96f4616..d4388d3 100644
> >> --- a/arch/arm/mach-omap2/prcm.c
> >> +++ b/arch/arm/mach-omap2/prcm.c
> >> @@ -216,6 +216,30 @@ u32 prm_read_mod_bits_shift(s16 
> domain, s16 idx, u32 mask)
> >>   	return v;
> >>   }
> >>
> >> +/* Read a PRM register, AND it, and shift the result down 
> to bit 0 */
> >> +u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask)
> >> +{
> >> +	u32 v;
> >> +
> >> +	v = __raw_readl(reg);
> >> +	v&= mask;
> >> +	v>>= __ffs(mask);
> >> +
> >> +	return v;
> >> +}
> >> +
> >> +/* Read-modify-write a register in a PRM module. Caller 
> must lock */
> >> +u32 omap4_prm_rmw_reg_bits(u32 mask, u32 bits, void __iomem *reg)
> >> +{
> >> +	u32 v;
> >> +
> >> +	v = __raw_readl(reg);
> >> +	v&= ~mask;
> >> +	v |= bits;
> >> +	__raw_writel(v, reg);
> >> +
> >> +	return v;
> >> +}
> >>   /* Read a register in a CM module */
> >>   u32 cm_read_mod_reg(s16 module, u16 idx)
> >>   {
> >> diff --git a/arch/arm/plat-omap/include/plat/prcm.h 
> b/arch/arm/plat-omap/include/plat/prcm.h
> >> index 9fbd914..ab77442 100644
> >> --- a/arch/arm/plat-omap/include/plat/prcm.h
> >> +++ b/arch/arm/plat-omap/include/plat/prcm.h
> >> @@ -38,6 +38,8 @@ u32 prm_read_mod_reg(s16 module, u16 idx);
> >>   void prm_write_mod_reg(u32 val, s16 module, u16 idx);
> >>   u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, 
> s16 idx);
> >>   u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask);
> >> +u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask);
> >> +u32 omap4_prm_rmw_reg_bits(u32 mask, u32 bits, void __iomem *reg);
> >>   u32 cm_read_mod_reg(s16 module, u16 idx);
> >>   void cm_write_mod_reg(u32 val, s16 module, u16 idx);
> >>   u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
> 
> 