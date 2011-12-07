From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] AM35xx: disable checking for reserved feature bits
Date: Wed, 7 Dec 2011 15:58:25 -0800
Message-ID: <20111207235825.GS31337@atomide.com>
References: <1320796298-7202-1-git-send-email-yanok@emcraft.com>
 <87d3d2kt83.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51213 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751Ab1LGX6b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Dec 2011 18:58:31 -0500
Content-Disposition: inline
In-Reply-To: <87d3d2kt83.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Ilya Yanok <yanok@emcraft.com>, linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com, hvaibhav@ti.com

Hi,

* Kevin Hilman <khilman@ti.com> [111108 16:23]:
> Ilya Yanok <yanok@emcraft.com> writes:
> 
> > Bits corresponding to the IVA and ISP features in OMAP_STATUS register
> > are reserved on AM35xx and checking for them results in wrong results.
> 
> Ouch.
> 
> > So we don't want to check for this features on AM35xx.
> >
> > Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> 
> This "feature" selection mechanism is clearly not scaling to newer SoCs.
> While this patch works around the problem, IMO, we need a more scalable
> solution.

Agreed.
 
> For features like IVA and ISP (and SGX) which are acutally IP blocks on
> the SoC, not "features"  per-se, what we really need to be doing is
> checking for the presence of the IP block, not checking a bit in a
> register that's not consistent across various SoCs.
> 
> We already have all the knowledge about whether the IP blocks are
> present in the SoC-specific hwmod data.  So checking for the "feature"
> of a specific IP block should instead be done using an
> omap_hwmod_lookup().
> 
> However, there's a bit of a snag because this "feature" detection is
> currently done before the hwmods are registered.
> 
> As a quick-and-dirty proof of concept, the patch/hack below moves the
> feature checking after the hwmod init (omap3 only currently) and uses
> omap_hwmod_lookup() to check whether a given IP block exists.
> 
> I only did a quick test on one OMAP3 platform (3430/n900) and it seems
> to work.    The init order changes need some more thought, as I didn't
> fully validate whether the feature detection can be safely moved later
> for all platforms.
> 
> This is just to show the direction we should be taking this SoC
> detection for newer SoCs.

This should be coordinated with the splitting of feature detection
as posted by Vaibhave in thread "[RFC PATCH] arm:omap: cleanup & split
omap2/3/4_check_revision function" thread.

We no longer need the SoC detection super early, so I suggest we make
the feature detection separate from SoC detection.

The SoC specific init can then call:

	omap3_check_revision();
	ti816x_check_features();

Regards,

Tony
