From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 00/15] voltdm cleanup + auto-ret / auto-off support
Date: Fri, 09 Dec 2011 12:23:55 -0800
Message-ID: <87sjktbijo.fsf@ti.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:45038 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752104Ab1LIUX7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 15:23:59 -0500
Received: by mail-qy0-f173.google.com with SMTP id d15so3113938qcs.18
        for <linux-omap@vger.kernel.org>; Fri, 09 Dec 2011 12:23:57 -0800 (PST)
In-Reply-To: <1322236188-19456-1-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Fri, 25 Nov 2011 17:49:33 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com

Hi Tero,

Tero Kristo <t-kristo@ti.com> writes:

> Changes compared to previous version:
>
> - merged most of the voltagedomain cleanup fixes to patch 2
> - moved pmic latencies to omap_voltdm_pmic struct
> - renamed omap_lp_params to omap2_oscillator as it only contains
>   osc info now
> - major changes to usecount support (patch 11+, needed for auto-ret)
>   * added usecounts to voltagedomain / powerdomain
>   * fixed usecount tracking so that the numbers are sane now
>   * changed behavior of some usecounting sources that they do not
>     update the counts (autoidle support)
> - added auto-ret / auto-off support, based on fixed usecounting
>   * smartreflex disabled / enabled
>   * auto-ret / auto-off enabled based on target state
> - some other minor tweaks I have probably forgotten to mention

This series is looking really good.  Thanks!

One thing I'd like to see is a bit more comments.  Particularily, the
new functions in the VC core need kerneldoc comments and verbose
descriptions.

The differences in timing setups between retention and off are not
obvious when reading the code (and are easily forgotten).  They also
equire a bit of TRM (re)reading to understand what's going on.  Some
summary comments in the code, along with TRM references would be most
helpful so when coming back to this code in a few months or more, we can
easily remember what's going on (or at least where to look.)  Thanks.

> Tested on omap3 beagle:
> - voltages for vdd1 and vdd2 change when entering idle
> - both suspend and dynamic idle tested
> - tested that voltages reach target levels for both ret / off
>
> Tested on omap4 blaze with custom kernel
> - this requires a few additional patches missing from this set as
>   omap4 PM support is still not merged

MPUSS support is now queued (in Tony's tree), but CORE PM is still
missing.

> - will post missing patches once possible from upstream point of view
> - voltages for vdd1 and vdd3 change when entering idle
>
> Applies on top of Kevin's for_3.2/voltage-cleanup branch.

You can use mainline now as that branch is merged.

Also, please Cc linux-arm-kernel on future versions of this series.

Thanks,

Kevin
