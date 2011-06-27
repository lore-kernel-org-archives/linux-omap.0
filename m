From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] omap3: beagle: Use GPTIMER1 for clockevents
Date: Mon, 27 Jun 2011 11:00:27 -0700
Message-ID: <20110627180027.GR23145@atomide.com>
References: <1309171009-8075-1-git-send-email-premi@ti.com>
 <20110627111556.GM23145@atomide.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024D7933C0@dbde02.ent.ti.com>
 <20110627123140.GP23145@atomide.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024D793464@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35912 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752938Ab1F0SAg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jun 2011 14:00:36 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D793464@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Gregoire Gentil <gregoire@gentil.com>, "Bhandiwad, Hrishikesh" <hrishikesh.b@ti.com>, Jason Lam <lzg@ema-tech.com>, Thomas Weber <weber@corscience.de>

* Premi, Sanjeev <premi@ti.com> [110627 06:24]:
> 
> [sp] While I take my time understanding things on devel-timer;
>      I had a quick question - at risk of being flamed.
> 
>      Adding a new machine ID would trickle to u-boot and same
>      uImage (default) may not work across board revisions.

Yes that's a hassle :( Until we have device tree, maybe see if
u-boot passes ATAG_REVISION that's available as system_rev in
kernel?
 
>      How does this scheme look like:
>      - GPTIMER1 is used as default - as it works for most boards.
>      - GPTIMER12 is used based on a static config option OR a
>        board specific bootarg
> 
>      I know both these options aren't general practice. Still
>      wanted to know your views in the current context.

Let's not do a Kconfig option, but a cmdline option should work
if done in a generic way. If you decide to go that way, then
please add that to timer.c against devel-timer branch.

Regards,

Tony
