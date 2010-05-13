From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] OMAP3: PM: fix AM35x musb issue with AUTOIDLE bit in
 CONTROL_SYSCONFIG
Date: Thu, 13 May 2010 17:15:23 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E40534D@dbde02.ent.ti.com>
References: <1272965585-21836-1-git-send-email-ajay.gupta@ti.com>
 <87vdb28byp.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33779 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758708Ab0EMLpa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 07:45:30 -0400
In-Reply-To: <87vdb28byp.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
Kumar Gupta <ajay.gupta@ti.com> writes:
> 
> > MUSB interface on AM35x stops working when we set AUTOIDLE bit (D0) in
> > CONTROL_SYSCONFIG(0x48002010) register.
> 
> why?
> 
> stops working in what way?
> 
> I think you need to investigate more into why this is happening.
>

There is 'turnaround/timeout' error shown in first SETUP packet on
USB bus when a device is connected to OTG port.

In second retry of SETUP packet, 8 byte of GET_DESCRIPTOR went out
Successfully but there is no 'IN token' to receive the descriptor
Data although ReqPkt is set for endpoint zero.

All this observation shows that OTG controller starts misbehaving
When AUTOIDLE bit is set in CONTROL_SYSCONFIG register.

> This suggest to me that something in the MUSB device/driver init
> is not quite right for these boards.
Do you have anything specific to try in init path ?

Regards,
Ajay
> 
> Kevin
> 
> 
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> >
> > ---
> >  arch/arm/mach-omap2/pm34xx.c |    7 ++++++-
> >  1 files changed, 6 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> > index ea0000b..cc9d566 100644
> > --- a/arch/arm/mach-omap2/pm34xx.c
> > +++ b/arch/arm/mach-omap2/pm34xx.c
> > @@ -849,7 +849,12 @@ static void __init prcm_setup_regs(void)
> >  			CM_AUTOIDLE);
> >  	}
> >
> > -	omap_ctrl_writel(OMAP3430_AUTOIDLE, OMAP2_CONTROL_SYSCONFIG);
> > +	/*
> > +	 * MUSB interface on AM35x stops working when we enable AUTOIDLE,
> > +	 * so avoid this for AM3517 and AM3505 device.
> > +	 */
> > +	if (!cpu_is_omap3517() && !cpu_is_omap3505())
> > +		omap_ctrl_writel(OMAP3430_AUTOIDLE, OMAP2_CONTROL_SYSCONFIG);
> >
> >  	/*
> >  	 * Set all plls to autoidle. This is needed until autoidle is
> > --
> > 1.6.2.4
