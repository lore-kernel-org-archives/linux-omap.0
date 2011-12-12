From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 10/15] omap: beagle: set oscillator startup time to
 10ms for rev c4
Date: Mon, 12 Dec 2011 11:42:18 +0200
Message-ID: <1323682938.31914.11.camel@sokoban>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
	 <1322236188-19456-11-git-send-email-t-kristo@ti.com>
	 <878vmlftlh.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49044 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386Ab1LLJmW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 04:42:22 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id pBC9gLfg000450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 03:42:21 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id pBC9gLYH006532
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 03:42:21 -0600 (CST)
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pBC9gL9F016454
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 03:42:21 -0600 (CST)
In-Reply-To: <878vmlftlh.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com

On Fri, 2011-12-09 at 11:11 -0800, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > Based on the oscillator datasheet for this device.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-omap3beagle.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> > index a7c3d60..5e3f575 100644
> > --- a/arch/arm/mach-omap2/board-omap3beagle.c
> > +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> > @@ -516,6 +516,9 @@ static void __init beagle_opp_init(void)
> >  			opp_disable(mpu_dev, 720000000);
> >  			opp_disable(iva_dev, 520000000);
> >  		}
> > +
> > +		/* Setup oscillator startup time to 10ms */
> > +		omap_pm_setup_oscillator(10000, 0);
> >  	}
> 
> ...but shutdown time is probably not zero. :)
> 
> This should probably be -1, or ULONG_MAX.
> 
> Yes, I see that tshut isn't even used on OMAP3, so it doesn't matter,
> but it does help readability IMO.

Exactly the reason it was set as zero... I'll think of something for the
next rev for this. Maybe use -1 as you suggested (and add a comment), it
is not going to break anything.

-Tero

