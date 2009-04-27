From: Jean Pihet <jpihet@mvista.com>
Subject: Re: [PATCH 00/10] OMAP3: SR: Fixes in Smartreflex driver
Date: Mon, 27 Apr 2009 09:08:09 +0200
Message-ID: <200904270908.09398.jpihet@mvista.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB03051F8510@dbde02.ent.ti.com> <87ab66yz92.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:6121 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849AbZD0HIa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Apr 2009 03:08:30 -0400
In-Reply-To: <87ab66yz92.fsf@deeprootsystems.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hi,

On Friday 24 April 2009 15:09:29 Kevin Hilman wrote:
> "Nayak, Rajendra" <rnayak@ti.com> writes:
> >> -----Original Message-----
> >> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> >> Sent: Thursday, April 23, 2009 1:35 AM
> >> To: Nayak, Rajendra
> >> Cc: linux-omap
> >> Subject: Re: [PATCH 00/10] OMAP3: SR: Fixes in Smartreflex driver
> >>
> >> "Nayak, Rajendra" <rnayak@ti.com> writes:
> >> > Re-sending this patch-set with some mailer issues resolved.
> >>
> >> They now apply cleanly
> >>
> >> > with a git-am/git-apply.
> >> >
> >> > Hi,
> >> >
> >> > This series fixes a set of defects/issues in Smartreflex
> >>
> >> driver. SR autocompensation is now
> >>
> >> > functional and is validated with these patches on a ES3.1
> >>
> >> based SDP with the N values in Efuse.
> >>
> >> > The patches also make the Smartreflex driver independent of
> >>
> >> SRF by using the OMAP PM apis
> >>
> >> > instead of calls to SRF.
> >> >
> >> > Patches apply on top of the latest pm branch from Kevin's pm tree.
> >>
> >> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-om
> >> ap-pm.git
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
> >
> > Kevin,
> >
> > These values I remember we got from the SiVal team here at TI, I don't
> > think they are board specific. I can check up more on that from them.
> > Btw, does the hang happen only with my patchset applied, because the
> > patchset does not change any of these values.
>
> Yes, backing out your latest series results in a booting kernel.
Using the latest SR patches on Beagleboard results in a booting kernel.
BUT the problem is a board freeze when switching between OPPs. After a few 
transitions the board hangs.

Regards,
Jean

>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


