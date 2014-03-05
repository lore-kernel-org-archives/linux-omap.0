From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 13/14] ARM: OMAP24xx: clock: remove legacy clock data
Date: Wed, 5 Mar 2014 09:08:57 -0800
Message-ID: <20140305170857.GD4983@atomide.com>
References: <1393924700-6510-1-git-send-email-t-kristo@ti.com>
 <1393924700-6510-14-git-send-email-t-kristo@ti.com>
 <20140304173200.GA17470@atomide.com>
 <5316217C.2070906@ti.com>
 <20140304212811.GA8705@atomide.com>
 <5316DCF6.6070808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46772 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbaCERJE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Mar 2014 12:09:04 -0500
Content-Disposition: inline
In-Reply-To: <5316DCF6.6070808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, mturquette@linaro.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [140305 00:17]:
> On 03/04/2014 11:28 PM, Tony Lindgren wrote:
> >* Tero Kristo <t-kristo@ti.com> [140304 10:58]:
> >>On 03/04/2014 07:32 PM, Tony Lindgren wrote:
> >>>* Tero Kristo <t-kristo@ti.com> [140304 01:22]:
> >>>>This is no longer needed as clock data is provided through DT.
> >>>
> >>>Looks like there's a new error even before applying this patch in
> >>>the series as I'm now getting the following oops on n8x0. So cannot
> >>>test this patch yet.
> >>
> >>Is this with OMAP2 only boot?
> >
> >Yeah that's with omap2 only.
> 
> That explains it, as previous series was never boot tested in omap2
> only config (due to build issues.)
> 
> I just force pushed the branch with the below additional patch, can
> you check if it works now?

Yes seems to work with that thanks. And with the omap2 legacy clock
data removed too, it boots fine on n8x0 and 2430sdp.

I suggest you drop the omap3 legacy data patch from this branch
as it's not omap2 related and cannot be done yet. Then try to get
acks from Paul. And if there are no issues, it seems Mike could take
the whole branch as it seems to merge just fine with what I have
queued. So for all the patches except for the omap3 legacy data
removal, feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>
