From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv8 2/5] omap3: voltage: fix channel configuration
Date: Mon, 12 Dec 2011 11:34:24 +0200
Message-ID: <1323682464.31914.3.camel@sokoban>
References: <1323444589-19940-1-git-send-email-t-kristo@ti.com>
	 <1323444589-19940-3-git-send-email-t-kristo@ti.com> <8739ctjmyq.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42865 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085Ab1LLJe1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 04:34:27 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id pBC9YRpo006410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 03:34:27 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id pBC9YQW4014398
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 03:34:26 -0600 (CST)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pBC9YQhF005820
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 03:34:26 -0600 (CST)
In-Reply-To: <8739ctjmyq.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, 2011-12-09 at 16:21 -0800, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > OMAP3 uses the default settings for VDD1 channel, otherwise the settings will
> > overlap with VDD2 and attempting to modify VDD1 voltage will actually change
> > VDD2 voltage.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  arch/arm/mach-omap2/vc3xxx_data.c |    1 +
> >  2 files changed, 5 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
> > index cfe348e..0136ad5 100644
> > --- a/arch/arm/mach-omap2/vc3xxx_data.c
> > +++ b/arch/arm/mach-omap2/vc3xxx_data.c
> > @@ -46,6 +46,7 @@ static struct omap_vc_common omap3_vc_common = {
> >  };
> >  
> >  struct omap_vc_channel omap3_vc_mpu = {
> > +	.flags = OMAP_VC_CHANNEL_DEFAULT,
> >  	.common = &omap3_vc_common,
> >  	.smps_sa_reg	 = OMAP3_PRM_VC_SMPS_SA_OFFSET,
> >  	.smps_volra_reg	 = OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET,
> 
> Looking more at the flow diagram you mentioned in the OMAP3 TRM, I don't
> think this is right for OMAP3.
> 
> Setting the USE_DEFAULTS flags means that VDD1 will only ever be able to
> use [slave address | voltage reg | command reg] zero.  While this is
> quite likely in most scenarios, the HW doesn't limit this like it does
> on OMAP4.
> 
> On OMAP3, it's very possible to configure VDD1 to use 
> [slave address | voltage reg | command reg] one if you want (even though
> I'm not sure why you would.)
> 
> In any case, my point is that setting the USE_DEFAULTS flag forces an
> OMAP4 restriction onto OMAP3 which the hardware doesn't have.
> 

Well, the voltage control does not work at all if this is not done. I am
not sure what is the root cause for this, as I don't have currently
oscilloscope available so that I could take a look at the bus traffic.
The voltage rail behavior is incorrect unless this change is in, this is
easily seen by measuring the voltage levels and trying to change the
voltages by sw.

-Tero


