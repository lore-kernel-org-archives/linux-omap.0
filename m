From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 00/10] OMAP3: SR: Fixes in Smartreflex driver
Date: Mon, 27 Apr 2009 17:39:46 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03051F8BEC@dbde02.ent.ti.com>
References: <874owdy8cp.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46457 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753533AbZD0MJ7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Apr 2009 08:09:59 -0400
In-Reply-To: <874owdy8cp.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Roger Quadros <ext-roger.quadros@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Saturday, April 25, 2009 4:21 AM
> To: Roger Quadros
> Cc: Nayak, Rajendra; linux-omap
> Subject: Re: [PATCH 00/10] OMAP3: SR: Fixes in Smartreflex driver
> 
> Roger Quadros <ext-roger.quadros@nokia.com> writes:
> 
> > ext Kevin Hilman wrote:
> [...]
> >>
> >> Rajendra,
> >>
> >> This series seems to boot on SDP and Beagle but I recetly tried on
> >> RX51 and it hangs in omap3_sr_init().
> >>
> >> Using Lauterbach, I tracked it to hang in sr_configure_vp() at this
> >> PRM write to the PRM_VP1_VLIMITTO register:
> >>
> >> 		prm_write_mod_reg(PRM_VP1_VLIMITTO_VDDMAX |
> >> 					PRM_VP1_VLIMITTO_VDDMIN |
> >> 					PRM_VP1_VLIMITTO_TIMEOUT,
> >> 					OMAP3430_GR_MOD,
> >> 					OMAP3_PRM_VP1_VLIMITTO_OFFSET);
> >>
> >>
> >> Should these min/max/timeout values be board specific?
> >>
> 
> [...]
> 
> >
> > It runs on rx51 if we set CONFIG_OMAP_PM_SRF instead of 
> CONFIG_OMAP_PM_NOOP.
> >
> > Should Smartreflex option be dependent or independent of the
> > CONFIG_OMAP_PM_??? setting?
> >
> 
> I see the same thing on SDP as well as RX51.
> 
> It looks like the new SR code assumes a range of OPPs, but when
> OMAP_PM_NONE is enabled, the omap_pm_vddX_get_opp() calls always
> return zero.
> 
> In the mpu_opps array, the first entry is all zeros, resulting
> in a zero VSEL which is then used to (re)program the VP.
> 
> The SR code should probably be a bit smarter about checking for valid
> values.
> 

Kevin,

I'll send in a patch to fix that.

thanks,
Rajendra

> 
> 
> 
> 
> 