From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: RE: [PATCH 1/2] omap: Disable GAIA I2C1/I2C4 internal pull-ups
Date: Tue, 2 Feb 2010 15:40:49 -0600
Message-ID: <CD8CC2B65FEE304DA95744A5472698F202AA321E31@dlee06.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026B4CBDEA@dbde02.ent.ti.com>
 <20100202015336.GN22747@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94026AFAA3F2@dbde02.ent.ti.com>
 <20100202165629.GS22747@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43093 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756514Ab0BBVkx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 16:40:53 -0500
In-Reply-To: <20100202165629.GS22747@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Pais, Allen" <allen.pais@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Tony/Allen/Paul,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Tuesday, February 02, 2010 10:56 AM
> To: Pais, Allen
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/2] omap: Disable GAIA I2C1/I2C4 internal pull-ups
> 
> * Pais, Allen <allen.pais@ti.com> [100201 18:56]:
> >
> > ________________________________________
> > From: Tony Lindgren [tony@atomide.com]
> > Sent: Monday, February 01, 2010 7:53 PM
> > To: Pais, Allen
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH 1/2] omap: Disable GAIA I2C1/I2C4 internal pull-ups
> >
> > Hi,
> >
> > * Pais, Allen <allen.pais@ti.com> [100121 02:31]:
> > > From 4044fcc9c517e86fbea9f7d3b15d5cf75a767476 Mon Sep 17 00:00:00 2001
> > > From: Allen Pais <allen.pais@ti.com>
> > > Date: Thu, 21 Jan 2010 21:00:04 +0530
> > > Subject: [PATCH 1/2] omap: Disable GAIA I2C1/I2C4 internal pull-ups
> > >
> > > This patch disables GAIA I2C1 adn I2C4(SR) internal pull-up, to
> > > use only the external HW resistor >=470 Ohm for the assured
> > > functionality in HS mode.
> > >
> > > While testing the I2C in High Speed mode, it was discovered that
> > > without a proper pull-up resistor, there is data corruption during
> > > multi-byte transfer. RTC(time_set) test case was used for testing.
> > >
> > > From the analysis done, it was concluded that ideally we need a
> > > pull-up of 1.6k Ohm(recomended) or atleast 470 Ohm or greater for
> > > assured performance in HS mode.
> >
> > Does this apply to 3630 only, or also 34xx? Is this safe to do
> > always?
> >
> > [Allen] Yes, it does apply to 36xx only.

There is some confusion, this patch holds true for all OMAP34XX, 36XX as well as 44XX. The idea was to rely on only external Pull-up for I2C operation and disable any internal pull-up on any of the connected power IC's: Triton(TWL4030)/GAIA(TWL5030)/Phoenix(TWL6030)

I did verify, the register 'REG_GPPUPDCTR1' holds true for Triton(TWL4030)/GAIA(TWL5030), hence for OMAP34XX/36XX.
But there is a register change for this PU/PD control on Phoenix(TWL6030) which is used with OMAP44XX. So I might have to modify this patch a little as this code will apply for TWL4030/5030 and have to introduce new code to achieve the intended fix for TWL6030.

The second patch of the series: 'omap: 3630: Disable internal pull-ups'
applies only for OMAP36XX as it is a new feature introduced in OMAP3630.

I have to check if that feature is available on OMAP44XX as well, if so I will modify that patch to extend to OMAP44XX in future. 

Although
> 
> Sounds like then this configuration should be passed from the
> board-*.c file in platform_data as the external pulls depend
> on the board.
> 
> > BTW, once ready it hould be sent to Samuel Ortiz with linux-omap
> > list Cc'd:
> >
> > [Allen] i'll have it sent to Samuel also.
> 
> Thanks, we can't merge it yet though, see above.
> 
> Regards,
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards
Moiz Sonasath
