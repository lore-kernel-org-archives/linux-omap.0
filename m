From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] omap4: Fix multi-omap boot with reset un-used clocks
Date: Wed, 19 May 2010 21:04:08 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5666724@dbde02.ent.ti.com>
References: <1274270345-28769-1-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.00.1005190848360.27473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40543 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322Ab0ESPeQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 11:34:16 -0400
In-Reply-To: <alpine.DEB.2.00.1005190848360.27473@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Wednesday, May 19, 2010 8:21 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] omap4: Fix multi-omap boot with reset un-used clocks
> 
> Santosh,
> 
> a comment.
> 
> On Wed, 19 May 2010, Santosh Shilimkar wrote:
> 
> > As part of the "CONFIG_OMAP_RESET_CLOCKS" routine, all the clock
> > are cut which are not acquired/enabled during the boot.
> >
> > Because of this on OMAP4, memory controller clocks (emif) getting
> > disabled which prevents further boot
> >
> > This patch uses "ENABLE_ON_INIT" flag on the emif clock nodes
> > and adds a check in the reset un-used clock routine to skip
> > such clock nodes. Will updated the auto-gen script for 44xx
> > accordingly
> >
> > The real fix is to have driver for EMIF and do clock get/enable
> > part of it. The EMIF driver is planned to be done HWMOD way so
> > till that point to keep omap3_defconfig booting on OMAP4430,
> > this patch is necessary. Also the cpu_is_44xx() check is added
> > to avoid any impact on the other OMAPs using "ENABLE_ON_INIT" flag
> >
> > The flag usage was suggested by Paul Walmsley
> >
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > ---
> > With this patch and Tony's below sram fix, omap3_defconfig
> > boots on OMAP4430 as it is. Tested with 2.6.34 maniline kernel
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg27363.html
> >
> >  arch/arm/mach-omap2/clock.c          |    4 ++++
> >  arch/arm/mach-omap2/clock44xx_data.c |    2 ++
> >  2 files changed, 6 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> > index a6d0b34..67b531b 100644
> > --- a/arch/arm/mach-omap2/clock.c
> > +++ b/arch/arm/mach-omap2/clock.c
> > @@ -380,6 +380,10 @@ void omap2_clk_disable_unused(struct clk *clk)
> >  {
> >  	u32 regval32, v;
> >
> > +	/* FIXME: Remove this when EMIF driver is ready */
> > +	if (cpu_is_omap44xx() && (clk->flags & ENABLE_ON_INIT))
> > +		return;
> > +
> 
> Why is this needed?  omap4xxx_clk_init() should call
> clk_enable_init_clocks() which should increase the usecount on all
> ENABLE_ON_INIT clocks.  That should prevent omap2_clk_disable_unused()
> from disabling the clock.
> 
Thanks Paul. Will fix this accordingly.

Regards,
Santosh 

