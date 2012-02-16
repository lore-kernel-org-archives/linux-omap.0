From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 0/3] OMAPDSS: HDMI: Add support for audio MCLK
Date: Wed, 15 Feb 2012 20:58:14 -0600
Message-ID: <1329361094.2016.156.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
References: <1328757023-20543-1-git-send-email-ricardo.neri@ti.com>
	 <1329222479.1845.86.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34418 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755854Ab2BPC6l (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 21:58:41 -0500
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q1G2weD0009467
	for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 20:58:40 -0600
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q1G2ween007138
	for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 20:58:40 -0600 (CST)
In-Reply-To: <1329222479.1845.86.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, a0393947@ti.com, molnar@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org

Hi Tomi,

On Tue, 2012-02-14 at 14:27 +0200, Tomi Valkeinen wrote:
> Hi,
> 
> On Wed, 2012-02-08 at 21:10 -0600, Ricardo Neri wrote:
> > Hello,
> > 
> > Certain OMAP4 revisions (i.e., 4430 ES2.3, 4460, and 4470) use
> > a pseudo clock (generated from the TMDS clock), MCLK, to drive the
> > generation of Audio Clock Regeneration packets. Other devices
> > (i.e., 4430 ES2.[0,2]) use the TMDS clock directly. 
> > 
> > This set of patches introduces functionality to enable the MCLK on the
> > relevant devices. Such clock is added as new DSS feature. The dss_features
> > structures are rearranged to reflect the MCLK support across several
> > silicon revisions.
> > 
> > These patches have been validated on OMAP 4430 ES2.2 and ES2.3 as well as
> > on 4460 ES1.0. The HDMI sinks used for validation are monitor Dell ST2210b,
> > AV receiver Onkyo TX-SR508 and AV receiver Yamaha RX-V367. Audio playback
> > is functional in all of them.
> 
> One question just to be sure: are you sure this clocking difference is
> based on OMAP revision, and has nothing to do with the board?

Yes, the source clock for the ACR packets depends on how the HDMI IP is
integrated into the OMAP and therefore it depends solely on the OMAP
revision and not the board.
> 
> I think this looks fine. However, it doesn't apply as the dss feat stuff
> has been changed. Could you rebase the patches on top of
> 
> git://gitorious.org/linux-omap-dss2/linux.git dev

Sure, I will rebase and resubmit.

Thanks,

Ricardo
> 
>  Tomi
> 


