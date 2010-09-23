From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap2 sparse fixes
Date: Thu, 23 Sep 2010 15:58:52 -0700
Message-ID: <20100923225851.GR4211@atomide.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9402785A390E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53388 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475Ab0IWW65 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 18:58:57 -0400
Content-Disposition: inline
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402785A390E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* G, Manjunath Kondaiah <manjugk@ti.com> [100922 01:48]:
> Hi Tony,
>  
> Please pull omap2 sparse fixes from:
>  
>   git://dev.omapzoom.org/pub/scm/manju/kernel-omap3-dev.git sparse_fixes
>  
> Regards,
> Manjunath
>  
>  
> The following changes since commit 8b15575cae7a93a784c3005c42b069edd9ba64dd:
>   Sage Weil (1):
>         fs: {lock,unlock}_flocks() stubs to prepare for BKL removal
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

Manjunath, this looks safe to pull, however one request though:
Can you please rebase it on v2.6.35 or v2.6.36-rc5?

Now your branch is on some commit after the -rc5 tag.
It's better to base branches at the most recent stable tag
(v2.6.35) or a recent -rc tag (v2.6.36-rc5).

Otherwise we end up moving our linux-omap tree forward too unless
I use git pull --rebase option.. I've updated the elinux.org wiki
instructions for that too, sorry if the earlier instructions there
were a bit unclear.

Thanks,

Tony
