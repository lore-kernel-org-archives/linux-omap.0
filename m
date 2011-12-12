From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 00/15] voltdm cleanup + auto-ret / auto-off support
Date: Mon, 12 Dec 2011 11:38:37 +0200
Message-ID: <1323682717.31914.7.camel@sokoban>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
	 <87sjktbijo.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43053 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209Ab1LLJil (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 04:38:41 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id pBC9ceIG008882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 03:38:40 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id pBC9ceIs015540
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 03:38:40 -0600 (CST)
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pBC9cePS011316
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 03:38:40 -0600 (CST)
In-Reply-To: <87sjktbijo.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com

On Fri, 2011-12-09 at 12:23 -0800, Kevin Hilman wrote:
> Hi Tero,
> 
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > Changes compared to previous version:
> >
> > - merged most of the voltagedomain cleanup fixes to patch 2
> > - moved pmic latencies to omap_voltdm_pmic struct
> > - renamed omap_lp_params to omap2_oscillator as it only contains
> >   osc info now
> > - major changes to usecount support (patch 11+, needed for auto-ret)
> >   * added usecounts to voltagedomain / powerdomain
> >   * fixed usecount tracking so that the numbers are sane now
> >   * changed behavior of some usecounting sources that they do not
> >     update the counts (autoidle support)
> > - added auto-ret / auto-off support, based on fixed usecounting
> >   * smartreflex disabled / enabled
> >   * auto-ret / auto-off enabled based on target state
> > - some other minor tweaks I have probably forgotten to mention
> 
> This series is looking really good.  Thanks!
> 
> One thing I'd like to see is a bit more comments.  Particularily, the
> new functions in the VC core need kerneldoc comments and verbose
> descriptions.
> 
> The differences in timing setups between retention and off are not
> obvious when reading the code (and are easily forgotten).  They also
> equire a bit of TRM (re)reading to understand what's going on.  Some
> summary comments in the code, along with TRM references would be most
> helpful so when coming back to this code in a few months or more, we can
> easily remember what's going on (or at least where to look.)  Thanks.
> 

Okay, I'll try to figure out more comments on next rev. This has never
been too strong point in the code I write I guess. :)

> > Tested on omap3 beagle:
> > - voltages for vdd1 and vdd2 change when entering idle
> > - both suspend and dynamic idle tested
> > - tested that voltages reach target levels for both ret / off
> >
> > Tested on omap4 blaze with custom kernel
> > - this requires a few additional patches missing from this set as
> >   omap4 PM support is still not merged
> 
> MPUSS support is now queued (in Tony's tree), but CORE PM is still
> missing.

I can take a look at this part also, but CORE PM is needed for this set
for testing purposes I believe, otherwise the auto-ret part does nothing
and is rather impossible to test (not sure if mpu part scales without
CORE PM, it might actually.)

> 
> > - will post missing patches once possible from upstream point of view
> > - voltages for vdd1 and vdd3 change when entering idle
> >
> > Applies on top of Kevin's for_3.2/voltage-cleanup branch.
> 
> You can use mainline now as that branch is merged.

Ah okay, good to know.

> 
> Also, please Cc linux-arm-kernel on future versions of this series.

Can do.

-Tero


