From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: new PM branch: OPP layer included
Date: Mon, 26 Apr 2010 18:27:42 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026F6E303D@dbde02.ent.ti.com>
References: <87hbn1u50w.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49575 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752989Ab0DZM5t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 08:57:49 -0400
In-Reply-To: <87hbn1u50w.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin,
This merge has broken omap zoom3 build. 

Error log:
In file included from arch/arm/plat-omap/include/plat/omap-pm.h:21,
                 from arch/arm/mach-omap2/hsmmc.c:19:
arch/arm/plat-omap/include/plat/opp.h: In function 'opp_find_freq_exact':
arch/arm/plat-omap/include/plat/opp.h:255: error: implicit declaration of function 'ERR_PTR'

-Manjunath 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Saturday, April 24, 2010 4:54 AM
> To: linux-omap@vger.kernel.org
> Subject: new PM branch: OPP layer included
> 
> Hello,
> 
> I just pushed a new PM branch.  I did a bunch of reordering and
> restructuring of branches to include the OPP layer (more on this
> below.)
> 
> 
> OPP layer: 
> 
> pm-wip-opp branch gone, merged into PM branch
> 
> What was in pm-wip-opp has now been broken up into a set of patches
> that can be combined and queued for upstream (pm-opp branch) as well
> as sets of patches for SR and SRF which are now on their respective
> branches (pm-sr, pm-srf)
> 
> Next step is to combine the patches in pm-opp branch into a sensible
> series that can be submitted for the next merge window.
> 
> 
> Smart Reflex:
> 
> Thara's v3 series available as pm-wip-sr.  This is now based directly
> on the new PM branch instead of on pm-wip-opp.
> 
> NOTE: the hwmod patches are now merged into l-o (omap-fixes branch)
>       so they are no longer in pm-wip-sr.
> 
> I didn't get to reviewing this series yet, but did test it out a bit
> on top of thenew PM branch.  I gave this some basic testing on n900
> and Zoom3 (required a u-boot update first) but basic OPP changes from
> userspace governor worked on both.
> 
>   
> SRF:
> 
> This is still included in the PM branch (pm-srf branch), but will be
> removed from the official PM branch.  It will be maintained as a
> separate branch for a short time (1 month max) and then dropped.
> Anyone else who wants to continue maintenance of SRF is free to do so.
> 
> 
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 