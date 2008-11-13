From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 1/3] [OMAPZOOM] Lower i2c speed on bus 1 for LDP.
Date: Wed, 12 Nov 2008 20:58:06 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE89671620369BC0D2A@dlee02.ent.ti.com>
References: <200811121421.38438.dcurran@ti.com>
 <062701c9453a$85ee81b0$LocalHost@wipultra806>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50262 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbYKMC6P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 21:58:15 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAD2w92Z017126
	for <linux-omap@vger.kernel.org>; Wed, 12 Nov 2008 20:58:14 -0600
In-Reply-To: <062701c9453a$85ee81b0$LocalHost@wipultra806>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shekhar, Chandra" <x0044955@ti.com>, "Curran, Dominic" <dcurran@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I noticed that l-o updated divisors the other day.

It might be some sync'ing pulled in bad dividers?

Regards,
Richard W.


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of shekhar, chandra
> Sent: Wednesday, November 12, 2008 8:50 PM
> To: Curran, Dominic; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/3] [OMAPZOOM] Lower i2c speed on bus 1 for LDP.
> 
> 
> ----- Original Message -----
> From: "Dominic Curran" <dcurran@ti.com>
> To: <linux-omap@vger.kernel.org>
> Sent: Thursday, November 13, 2008 1:51 AM
> Subject: [PATCH 1/3] [OMAPZOOM] Lower i2c speed on bus 1 for LDP.
> 
> 
> > Resending patch with more descriptive comment.
> >
> > Lower i2c bus 1 speed to 400KHz for LDP.
> > At 2600KHz i2c reads from twl4030 keypad driver are returning
> > incorrect data. Reason unknown. Lowering bus speed as temporary
> > fix to get LDP keypad working.
> >
> > Signed-off-by: Dominic Curran <dcurran@ti.com>
> > ---
> > arch/arm/mach-omap2/board-ldp.c |    2 +-
> > 1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-
> omap2/board-ldp.c
> > index d889ce8..b2e8c9c 100755
> > --- a/arch/arm/mach-omap2/board-ldp.c
> > +++ b/arch/arm/mach-omap2/board-ldp.c
> > @@ -797,7 +797,7 @@ static struct i2c_board_info __initdata
> > ldp_i2c_boardinfo_2[] = {
> >
> > static int __init omap_i2c_init(void)
> > {
> > - omap_register_i2c_bus(1, 2600, ldp_i2c_boardinfo,
> > + omap_register_i2c_bus(1, 400, ldp_i2c_boardinfo,
> >  ARRAY_SIZE(ldp_i2c_boardinfo));
> 
> 
> Last time i checked we were getting few errors (returning incorrect
> values) even
> at 400k , and no error at 100k.
> Have you seen any at 400k?
> 
> 
> >  omap_register_i2c_bus(2, 100, ldp_i2c_boardinfo_2,
> >  ARRAY_SIZE(ldp_i2c_boardinfo_2));
> > --
> > 1.5.4.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

