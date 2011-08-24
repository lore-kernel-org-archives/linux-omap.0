From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] ARM: OMAP: Move omap2_init_common_devices out of
 init_early
Date: Wed, 24 Aug 2011 05:20:50 -0700
Message-ID: <20110824122049.GA2963@atomide.com>
References: <20110824115048.2985.24230.stgit@kaulin>
 <20110824115433.2985.98712.stgit@kaulin>
 <4E54EA5E.8010603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61928 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752510Ab1HXMUy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Aug 2011 08:20:54 -0400
Content-Disposition: inline
In-Reply-To: <4E54EA5E.8010603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Cousson, Benoit <b-cousson@ti.com> [110824 04:38]:
> Hi Tony,
> 
> On 8/24/2011 1:54 PM, Tony Lindgren wrote:
> >There's no need to call omap2_init_common_devices from init_early.
> >It reprograms the memory timings for some boards, so it's better to
> >do it later so we have a chance to get console messages if something
> >goes wrong.
> 
> BTW, I did some comment on that function in my OMAP4 device-tree
> series, because the name is misleading.
> That function is just initializing the SDRC controller present in
> OMAP2 & 3. OMAP4 platform should not even call it.
> In fact, I'm now wondering were the OMAP4 EMIF is configured?

Probably nowhere currently?
 
> void __init omap2_init_common_devices(struct omap_sdrc_params *sdrc_cs0,
>                                       struct omap_sdrc_params *sdrc_cs1)
> {
>         if (cpu_is_omap24xx() || omap3_has_sdrc()) {
>                 omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
>                 _omap2_init_reprogram_sdrc();
>         }
> }
> 
> I guess it used to do much more than that in the past.
> 
> Shouldn't we rename it to clarify its purpose?

Yeah we might as well rename it to omap_init_sdrc since we're
patching it. Will post an updated patch.

Tony
