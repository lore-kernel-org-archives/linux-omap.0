From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] OMAP2: Add funcs for writing SMS_ROT_* registers
Date: Fri, 7 Aug 2009 05:38:34 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908070538200.7977@utopia.booyaka.com>
References: <1249633796-12266-1-git-send-email-tomi.valkeinen@nokia.com> <4A7BE751.20001@nokia.com> <20090807112913.GD2358@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53112 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbZHGLie (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 07:38:34 -0400
In-Reply-To: <20090807112913.GD2358@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 7 Aug 2009, Tony Lindgren wrote:

> * Tomi Valkeinen <tomi.valkeinen@nokia.com> [090807 11:36]:
> > Hmm sorry, this was meant to be [PATCH 1/1].
> >
> >  Tomi
> >
> >
> > Valkeinen Tomi (Nokia-D/Helsinki) wrote:
> >> SMS_ROT_* registers are used by VRFB rotation engine.
> 
> Assuming Paul acks it too, I suggest you merge this via the fbdev queue
> to avoid dependencies of having to wait for all the arm patches to get
> merged.
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

> 
> 
> >>
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> >> ---
> >>  arch/arm/mach-omap2/sdrc.c             |   16 ++++++++++++++++
> >>  arch/arm/plat-omap/include/mach/sdrc.h |    8 +++++++-
> >>  2 files changed, 23 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
> >> index 2045441..56f6dab 100644
> >> --- a/arch/arm/mach-omap2/sdrc.c
> >> +++ b/arch/arm/mach-omap2/sdrc.c
> >> @@ -111,3 +111,19 @@ void __init omap2_sdrc_init(struct omap_sdrc_params *sp)
> >>  		(1 << SDRC_POWER_PAGEPOLICY_SHIFT);
> >>  	sdrc_write_reg(l, SDRC_POWER);
> >>  }
> >> +
> >> +void omap2_sms_write_rot_control(u32 val, unsigned ctx)
> >> +{
> >> +	sms_write_reg(val, SMS_ROT_CONTROL(ctx));
> >> +}
> >> +
> >> +void omap2_sms_write_rot_size(u32 val, unsigned ctx)
> >> +{
> >> +	sms_write_reg(val, SMS_ROT_SIZE(ctx));
> >> +}
> >> +
> >> +void omap2_sms_write_rot_physical_ba(u32 val, unsigned ctx)
> >> +{
> >> +	sms_write_reg(val, SMS_ROT_PHYSICAL_BA(ctx));
> >> +}
> >> +
> >> diff --git a/arch/arm/plat-omap/include/mach/sdrc.h b/arch/arm/plat-omap/include/mach/sdrc.h
> >> index adc7352..4199c19 100644
> >> --- a/arch/arm/plat-omap/include/mach/sdrc.h
> >> +++ b/arch/arm/plat-omap/include/mach/sdrc.h
> >> @@ -75,7 +75,10 @@
> >>   /* SMS register offsets - read/write with sms_{read,write}_reg() */
> >>  -#define SMS_SYSCONFIG		0x010
> >> +#define SMS_SYSCONFIG			0x010
> >> +#define SMS_ROT_CONTROL(context)	(0x180 + 0x10 * context)
> >> +#define SMS_ROT_SIZE(context)		(0x184 + 0x10 * context)
> >> +#define SMS_ROT_PHYSICAL_BA(context)	(0x188 + 0x10 * context)
> >>  /* REVISIT: fill in other SMS registers here */
> >>   @@ -104,6 +107,9 @@ struct omap_sdrc_params {
> >>   void __init omap2_sdrc_init(struct omap_sdrc_params *sp);
> >>  struct omap_sdrc_params *omap2_sdrc_get_params(unsigned long r);
> >> +void omap2_sms_write_rot_control(u32 val, unsigned ctx);
> >> +void omap2_sms_write_rot_size(u32 val, unsigned ctx);
> >> +void omap2_sms_write_rot_physical_ba(u32 val, unsigned ctx);
> >>   #ifdef CONFIG_ARCH_OMAP2
> >>  
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
