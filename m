From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] AM35xx: disable checking for reserved feature bits
Date: Fri, 16 Dec 2011 11:31:15 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A805EE18@DBDE01.ent.ti.com>
References: <1320796298-7202-1-git-send-email-yanok@emcraft.com>
	<87d3d2kt83.fsf@ti.com> <20111207235825.GS31337@atomide.com>
 <87ty59gr25.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38042 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755Ab1LPLbi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 06:31:38 -0500
In-Reply-To: <87ty59gr25.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Ilya Yanok <yanok@emcraft.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "wd@denx.de" <wd@denx.de>, "dzu@denx.de" <dzu@denx.de>, "sasha_d@emcraft.com" <sasha_d@emcraft.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Saturday, December 10, 2011 6:51 AM
> To: Tony Lindgren
> Cc: Ilya Yanok; linux-omap@vger.kernel.org; wd@denx.de; dzu@denx.de;
> sasha_d@emcraft.com; Hiremath, Vaibhav
> Subject: Re: [PATCH] AM35xx: disable checking for reserved feature bits
> 
> Tony Lindgren <tony@atomide.com> writes:
> 
> [...]
> 
> >> This "feature" selection mechanism is clearly not scaling to newer SoCs.
> >> While this patch works around the problem, IMO, we need a more scalable
> >> solution.
> >
> > Agreed.
> >
> >> For features like IVA and ISP (and SGX) which are acutally IP blocks on
> >> the SoC, not "features"  per-se, what we really need to be doing is
> >> checking for the presence of the IP block, not checking a bit in a
> >> register that's not consistent across various SoCs.
> >>
> >> We already have all the knowledge about whether the IP blocks are
> >> present in the SoC-specific hwmod data.  So checking for the "feature"
> >> of a specific IP block should instead be done using an
> >> omap_hwmod_lookup().
> >>
> >> However, there's a bit of a snag because this "feature" detection is
> >> currently done before the hwmods are registered.
> >>
> >> As a quick-and-dirty proof of concept, the patch/hack below moves the
> >> feature checking after the hwmod init (omap3 only currently) and uses
> >> omap_hwmod_lookup() to check whether a given IP block exists.
> >>
> >> I only did a quick test on one OMAP3 platform (3430/n900) and it seems
> >> to work.    The init order changes need some more thought, as I didn't
> >> fully validate whether the feature detection can be safely moved later
> >> for all platforms.
> >>
> >> This is just to show the direction we should be taking this SoC
> >> detection for newer SoCs.
> >
> > This should be coordinated with the splitting of feature detection
> > as posted by Vaibhave in thread "[RFC PATCH] arm:omap: cleanup & split
> > omap2/3/4_check_revision function" thread.
> 
> Vaibhav,
> 
> Feel free to take my proposed patch and develop it further and include
> it in your rework of the SoC/feature detection.
> 
Sorry for delayed response,

This looks good approach to me, the problem is, currently in the HWMOD database
we don't have all the entries, like isp or gfx/sgx.

So please note that I have to first add the dummy entry for the same. Submitting RFC patch shortly.


Having said that, my original patch still required, so I will submit the
first patch splitting xxx_check_revision and xxx_check_features and then on
top of this I will merge hwmod related patch.

Thanks,
Vaibhav

> Kevin
