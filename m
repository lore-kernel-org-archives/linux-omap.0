From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2+: mux: Initialise the static pads.
Date: Fri, 4 Mar 2011 09:43:01 -0800
Message-ID: <20110304174301.GA20560@atomide.com>
References: <1299003360-32120-1-git-send-email-r.sricharan@ti.com>
 <20110304022832.GR20560@atomide.com>
 <44e29d555f2b399b7067d827603897cc@mail.gmail.com>
 <20110304162858.GW20560@atomide.com>
 <4ad439dff008aeca2a058207ef744650@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:31860 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab1CDRnQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 12:43:16 -0500
Content-Disposition: inline
In-Reply-To: <4ad439dff008aeca2a058207ef744650@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, paul@pswan.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Sricharan R <r.sricharan@ti.com> [110304 09:31]:
> Hi Tony,
> 
> >Hmm it's there as commit 93c5f165e10c21a3813a687204388a34072b2a62
> 
> >in devel-mux branch. Can you please update your patch against
> 
> >that commit so it's easier to see what your changes are?
> 
> >
> 
> >BTW, the patch you posted got trashed by your email client
> 
> >or server..
> 
> >
> 
> Here is the updated patch on top of your previous patch.

The patch formatting is still trashed, notice the double line
spacing..
 
> +++ b/arch/arm/mach-omap2/mux.c
> 
> @@ -359,7 +359,6 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8
> state)

..and the line wrapping of the patch lines.

> 
> +     if ((state == _HWMOD_STATE_ENABLED) && hmux->pads_dynamic
> 
> +                             && hmux->enabled) {

Yes I see that might allow removing the idle flag. Will give it
a try with my testcase once you get your mail issue sorted out
and can post a patch that applies.

Tony
 
