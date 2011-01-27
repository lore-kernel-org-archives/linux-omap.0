From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] ARM: OMAP: Add chip id recognition for OMAP4 ES2.1 and ES2.2
Date: Thu, 27 Jan 2011 17:32:46 +0530
Message-ID: <8ac986a49f70e9db4a36931eff4b2533@mail.gmail.com>
References: <1295450363-11315-1-git-send-email-nskamat@ti.com> <fc07678e79785a0f0c2d76392a050138@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:43388 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754200Ab1A0MCt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jan 2011 07:02:49 -0500
Received: by mail-fx0-f44.google.com with SMTP id 9so2180816fxm.3
        for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 04:02:48 -0800 (PST)
In-Reply-To: <fc07678e79785a0f0c2d76392a050138@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishant Kamat <nskamat@ti.com>, linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Nishant Kamat
> Sent: Thursday, January 27, 2011 5:18 PM
> To: Nishant Kamat; linux-omap@vger.kernel.org
> Subject: RE: [PATCH] ARM: OMAP: Add chip id recognition for OMAP4
> ES2.1 and ES2.2
>
> Hi all,
>
> Any comments on this patch?
>
> Regards,
> Nishant
>
> > -----Original Message-----
> > From: Nishant Kamat [mailto:nskamat@ti.com]
> > Sent: Wednesday, January 19, 2011 8:49 PM
> > To: linux-omap@vger.kernel.org
> > Cc: Nishant Kamat
> > Subject: [PATCH] ARM: OMAP: Add chip id recognition for OMAP4
> ES2.1 and
> > ES2.2
> >
> > Allow OMAP4 ES2.1 and ES2.2 revisions to be recognized in the
> > omap4_check_revision() function.
> >
> > Mainly, ES2.1 has fixes that allow LPDDR to be used at 100% OPP
> > (400MHz).
> > ES2.2 additionally has a couple of power management fixes (to
> reduce
> > leakage), an I2C1 SDA line state fix, and a floating point write
> > corruption fix (cortex erratum).
> >
> > Even though the current mainline support doesn't need to
> distinguish
> > between ES2.X versions, it's still useful to know the correct
> silicon
> > rev when issues are reported. Moreover, these id checks can be
> used by
> > power management code that selects suitable OPPs considering the
> > memory speed limitation on ES2.0.
> >
> > For details about the silicon errata on OMAP4430, refer
> >
> http://focus.ti.com/pdfs/wtbu/SWPZ009A_OMAP4430_Errata_Public_vA.pdf
> >
> > Signed-off-by: Nishant Kamat <nskamat@ti.com>

Some how I missed this post. Patch looks good to me.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

> > ---
> >  arch/arm/mach-omap2/id.c              |   31
> ++++++++++++++++++++-----
> > ------
> >  arch/arm/plat-omap/include/plat/cpu.h |   16 +++++++++++-----
> >  2 files changed, 31 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> > index 5f9086c..8fd0535 100644
> > --- a/arch/arm/mach-omap2/id.c
> > +++ b/arch/arm/mach-omap2/id.c
> > @@ -6,7 +6,7 @@
> >   * Copyright (C) 2005 Nokia Corporation
> >   * Written by Tony Lindgren <tony@atomide.com>
> >   *
> > - * Copyright (C) 2009 Texas Instruments
> > + * Copyright (C) 2009-11 Texas Instruments
> >   * Added OMAP4 support - Santosh Shilimkar
> <santosh.shilimkar@ti.com>
> >   *
> >   * This program is free software; you can redistribute it and/or
> > modify
> > @@ -307,7 +307,7 @@ static void __init omap4_check_revision(void)
> >  	 */
> >  	idcode = read_tap_reg(OMAP_TAP_IDCODE);
> >  	hawkeye = (idcode >> 12) & 0xffff;
> > -	rev = (idcode >> 28) & 0xff;
> > +	rev = (idcode >> 28) & 0xf;
> >
> >  	/*
> >  	 * Few initial ES2.0 samples IDCODE is same as ES1.0
> > @@ -326,22 +326,31 @@ static void __init
> omap4_check_revision(void)
> >  			omap_chip.oc |= CHIP_IS_OMAP4430ES1;
> >  			break;
> >  		case 1:
> > +		default:
> >  			omap_revision = OMAP4430_REV_ES2_0;
> >  			omap_chip.oc |= CHIP_IS_OMAP4430ES2;
> > +		}
> > +		break;
> > +	case 0xb95c:
> > +		switch (rev) {
> > +		case 3:
> > +			omap_revision = OMAP4430_REV_ES2_1;
> > +			omap_chip.oc |= CHIP_IS_OMAP4430ES2_1;
> >  			break;
> > +		case 4:
> >  		default:
> > -			omap_revision = OMAP4430_REV_ES2_0;
> > -			omap_chip.oc |= CHIP_IS_OMAP4430ES2;
> > -	}
> > -	break;
> > +			omap_revision = OMAP4430_REV_ES2_2;
> > +			omap_chip.oc |= CHIP_IS_OMAP4430ES2_2;
> > +		}
> > +		break;
> >  	default:
> > -		/* Unknown default to latest silicon rev as default*/
> > -		omap_revision = OMAP4430_REV_ES2_0;
> > -		omap_chip.oc |= CHIP_IS_OMAP4430ES2;
> > +		/* Unknown default to latest silicon rev as default */
> > +		omap_revision = OMAP4430_REV_ES2_2;
> > +		omap_chip.oc |= CHIP_IS_OMAP4430ES2_2;
> >  	}
> >
> > -	pr_info("OMAP%04x ES%d.0\n",
> > -			omap_rev() >> 16, ((omap_rev() >> 12) & 0xf) + 1);
> > +	pr_info("OMAP%04x ES%d.%d\n", omap_rev() >> 16,
> > +		((omap_rev() >> 12) & 0xf), ((omap_rev() >> 8) & 0xf));
> >  }
> >
> >  #define OMAP3_SHOW_FEATURE(feat)		\
> > diff --git a/arch/arm/plat-omap/include/plat/cpu.h
> b/arch/arm/plat-
> > omap/include/plat/cpu.h
> > index 3fd8b40..989f9e6 100644
> > --- a/arch/arm/plat-omap/include/plat/cpu.h
> > +++ b/arch/arm/plat-omap/include/plat/cpu.h
> > @@ -5,7 +5,7 @@
> >   *
> >   * Copyright (C) 2004, 2008 Nokia Corporation
> >   *
> > - * Copyright (C) 2009 Texas Instruments.
> > + * Copyright (C) 2009-11 Texas Instruments.
> >   *
> >   * Written by Tony Lindgren <tony.lindgren@nokia.com>
> >   *
> > @@ -390,8 +390,10 @@ IS_OMAP_TYPE(3517, 0x3517)
> >  #define OMAP3517_REV(v)		(OMAP35XX_CLASS | (0x3517 << 16)
> |
> > (v << 8))
> >
> >  #define OMAP443X_CLASS		0x44300044
> > -#define OMAP4430_REV_ES1_0	OMAP443X_CLASS
> > -#define OMAP4430_REV_ES2_0	0x44301044
> > +#define OMAP4430_REV_ES1_0	(OMAP443X_CLASS | (0x10 << 8))
> > +#define OMAP4430_REV_ES2_0	(OMAP443X_CLASS | (0x20 << 8))
> > +#define OMAP4430_REV_ES2_1	(OMAP443X_CLASS | (0x21 << 8))
> > +#define OMAP4430_REV_ES2_2	(OMAP443X_CLASS | (0x22 << 8))
> >
> >  /*
> >   * omap_chip bits
> > @@ -419,11 +421,15 @@ IS_OMAP_TYPE(3517, 0x3517)
> >  #define CHIP_IS_OMAP3630ES1_1           (1 << 9)
> >  #define CHIP_IS_OMAP3630ES1_2           (1 << 10)
> >  #define CHIP_IS_OMAP4430ES2		(1 << 11)
> > +#define CHIP_IS_OMAP4430ES2_1		(1 << 12)
> > +#define CHIP_IS_OMAP4430ES2_2		(1 << 13)
> >
> >  #define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 |
> > CHIP_IS_OMAP2430)
> >
> > -#define CHIP_IS_OMAP4430		(CHIP_IS_OMAP4430ES1 | \
> > -						 CHIP_IS_OMAP4430ES2)
> > +#define CHIP_IS_OMAP4430		(CHIP_IS_OMAP4430ES1 |		\
> > +					 CHIP_IS_OMAP4430ES2 |		\
> > +					 CHIP_IS_OMAP4430ES2_1 |	\
> > +					 CHIP_IS_OMAP4430ES2_2)
> >
> >  /*
> >   * "GE" here represents "greater than or equal to" in terms of ES
> > --
> > 1.7.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
