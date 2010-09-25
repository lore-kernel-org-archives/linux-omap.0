From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap2 sparse fixes
Date: Fri, 24 Sep 2010 17:19:15 -0700
Message-ID: <20100925001914.GO4211@atomide.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9402785A390E@dbde02.ent.ti.com>
 <20100923225851.GR4211@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F859E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53450 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560Ab0IYATR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 20:19:17 -0400
Content-Disposition: inline
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F859E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* G, Manjunath Kondaiah <manjugk@ti.com> [100924 12:33]:
> 
> Tony,
> Here is new pull request which is rebased to 2.6.36-rc5.
> 
> -Manjunath
> 
> The following changes since commit b30a3f6257ed2105259b404d419b4964e363928c:
>   Linus Torvalds (1):
>         Linux 2.6.36-rc5
> 
> are available in the git repository at:
> 
>   git://dev.omapzoom.org/pub/scm/manju/kernel-omap3-dev.git sparse_fixes
> 
> G, Manjunath Kondaiah (10):
>       OMAP: mach-omap2: Fix incorrect assignment warnings
>       OMAP: mach-omap2: Fix static declaration warnings
>       OMAP: mach-omap2: Fix static function warnings
>       OMAP: mach-omap2: Fix miscellaneous sparse warnings
>       OMAP: plat-omap: Fix static function warnings
>       OMAP: NAND: Fix static declaration warning
>       TWL CORE: Fix sparse warning
>       TWL IRQ: Fix fucntion declaration warnings
>       OMAP2/3: Convert write/read functions to raw read/write
>       OMAP3: Keypad: Fix incorrect type initializer

Hmm tried pulling these, but ran into an issue where at least 2430
takes about a minute to boot with these patches with no output
on the console intially.

Can you please check that? Will not merge for now until we
figure out what changes with these patches.

Then, I also noticed the following exports getting added:

+EXPORT_SYMBOL(omap2_gp_clockevent_set_gptimer);
+EXPORT_SYMBOL(omapfb_reserve_sram);
+EXPORT_SYMBOL(omap_sram_init);

These should not be exported, they are only intended to be called
from the low-level platform init code. So exporting them is not
the right fix for these.

Regards,

Tony
