From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] OMAP3: PM: fix AM35x musb issue with AUTOIDLE bit in
 CONTROL_SYSCONFIG
Date: Fri, 14 May 2010 15:22:44 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E4055CD@dbde02.ent.ti.com>
References: <1272965585-21836-1-git-send-email-ajay.gupta@ti.com>
 <87vdb28byp.fsf@deeprootsystems.com>
 <19F8576C6E063C45BE387C64729E7394044E40534D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53668 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753050Ab0ENJwv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 05:52:51 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E40534D@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Gupta, Ajay Kumar
> Sent: Thursday, May 13, 2010 5:15 PM
> To: Kevin Hilman
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH] OMAP3: PM: fix AM35x musb issue with AUTOIDLE bit in
> CONTROL_SYSCONFIG
> 
> Hi,
> Kumar Gupta <ajay.gupta@ti.com> writes:
> >
> > > MUSB interface on AM35x stops working when we set AUTOIDLE bit (D0) in
> > > CONTROL_SYSCONFIG(0x48002010) register.
> >
> > why?
> >
> > stops working in what way?
> >
> > I think you need to investigate more into why this is happening.
> >
> 
> There is 'turnaround/timeout' error shown in first SETUP packet on
> USB bus when a device is connected to OTG port.
> 
> In second retry of SETUP packet, 8 byte of GET_DESCRIPTOR went out
> Successfully but there is no 'IN token' to receive the descriptor
> Data although ReqPkt is set for endpoint zero.
> 
> All this observation shows that OTG controller starts misbehaving
> When AUTOIDLE bit is set in CONTROL_SYSCONFIG register.
> 
> > This suggest to me that something in the MUSB device/driver init
> > is not quite right for these boards.
> Do you have anything specific to try in init path ?

I observed OTG port to be working with plane linus's tree + AM3517 musb
Support patch and without AUTOIDLE bit set so please hold on this patch
For now. I will do further testing and let you know.

-Ajay 
> 
> Regards,
> Ajay
> >
> > Kevin
> >
> >
> > > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > >
> > > ---
> > >  arch/arm/mach-omap2/pm34xx.c |    7 ++++++-
> > >  1 files changed, 6 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-
> omap2/pm34xx.c
> > > index ea0000b..cc9d566 100644
> > > --- a/arch/arm/mach-omap2/pm34xx.c
> > > +++ b/arch/arm/mach-omap2/pm34xx.c
> > > @@ -849,7 +849,12 @@ static void __init prcm_setup_regs(void)
> > >  			CM_AUTOIDLE);
> > >  	}
> > >
> > > -	omap_ctrl_writel(OMAP3430_AUTOIDLE, OMAP2_CONTROL_SYSCONFIG);
> > > +	/*
> > > +	 * MUSB interface on AM35x stops working when we enable AUTOIDLE,
> > > +	 * so avoid this for AM3517 and AM3505 device.
> > > +	 */
> > > +	if (!cpu_is_omap3517() && !cpu_is_omap3505())
> > > +		omap_ctrl_writel(OMAP3430_AUTOIDLE, OMAP2_CONTROL_SYSCONFIG);
> > >
> > >  	/*
> > >  	 * Set all plls to autoidle. This is needed until autoidle is
> > > --
> > > 1.6.2.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
