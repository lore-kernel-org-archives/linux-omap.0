From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 00/10] OMAP3: SR: Fixes in Smartreflex driver
Date: Fri, 24 Apr 2009 12:20:22 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03051F8510@dbde02.ent.ti.com>
References: <87d4b4zc8e.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47990 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907AbZDXGub convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Apr 2009 02:50:31 -0400
In-Reply-To: <87d4b4zc8e.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Thursday, April 23, 2009 1:35 AM
> To: Nayak, Rajendra
> Cc: linux-omap
> Subject: Re: [PATCH 00/10] OMAP3: SR: Fixes in Smartreflex driver
> 
> "Nayak, Rajendra" <rnayak@ti.com> writes:
> 
> > Re-sending this patch-set with some mailer issues resolved. 
> They now apply cleanly
> > with a git-am/git-apply.
> >
> > Hi,
> >
> > This series fixes a set of defects/issues in Smartreflex 
> driver. SR autocompensation is now
> > functional and is validated with these patches on a ES3.1 
> based SDP with the N values in Efuse.
> >
> > The patches also make the Smartreflex driver independent of 
> SRF by using the OMAP PM apis
> > instead of calls to SRF.
> >
> > Patches apply on top of the latest pm branch from Kevin's pm tree.
> > 
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-om
> ap-pm.git 
> 
> Rajendra,
> 
> This series seems to boot on SDP and Beagle but I recetly tried on
> RX51 and it hangs in omap3_sr_init().
> 
> Using Lauterbach, I tracked it to hang in sr_configure_vp() at this
> PRM write to the PRM_VP1_VLIMITTO register:
> 
> 		prm_write_mod_reg(PRM_VP1_VLIMITTO_VDDMAX |
> 					PRM_VP1_VLIMITTO_VDDMIN |
> 					PRM_VP1_VLIMITTO_TIMEOUT,
> 					OMAP3430_GR_MOD,
> 					OMAP3_PRM_VP1_VLIMITTO_OFFSET);
> 
> 
> Should these min/max/timeout values be board specific?

Kevin,

These values I remember we got from the SiVal team here at TI, I don't think they are board specific.
I can check up more on that from them.
Btw, does the hang happen only with my patchset applied, because the patchset does not change
any of these values.

I don't have access to the RX51 h/w this week, so I can debug more on this next week once I have access
to it.

regards,
Rajendra

> 
> Kevin
> 
> 