From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv8 00/36] ARM: OMAP: DT clock conversion
Date: Wed, 9 Oct 2013 08:48:04 -0700
Message-ID: <20131009154804.GB8313@atomide.com>
References: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59066 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705Ab3JIPsJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 11:48:09 -0400
Content-Disposition: inline
In-Reply-To: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [131009 08:40]:
> 
> Separate branches for the maintainers also available here:
> 
> https://github.com/t-kristo/linux-pm.git
> 
> Branch with DTS only data: 3.12-rc3-dt-clks-for-benoit
> - based on top of 3.12-rc3 with Benoit's latest for_3.13 merged in
> 
> Branch with clock driver patches: 3.12-rc3-dt-clks-for-mike
> - based on top of 3.12-rc3
> - does not compile due to lack of 1 dependency patch (for getting DT clock
>   parent count) which Mike has queued to his own branch though I believe

Maybe Mike can provide you an immutable commit on which
to base your 3.12-rc3-dt-clks-for-mike?
 
> Branch with all the stuff for mach-omap2: 3.12-rc3-dt-clks-for-tony
> - based on top of 3.12-rc3
> - merged both above branches to this
> - merged also a few temporary hacks to get some of my boards to work,
>   these have been discussed elsewhere but can act as a reference

I suggest you keep those temporary hacks in yet another
temporary branch until I have some immutable commit with the hwmod
changes etc pulled into in it. Then ideally you won't have to change
your for-tony branch and it can be just merged on top of the branch
with the dependencies.

Regards,

Tony
