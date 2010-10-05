From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap2 sparse fixes
Date: Mon, 4 Oct 2010 19:14:56 -0700
Message-ID: <20101005021455.GE3117@atomide.com>
References: <20100923225851.GR4211@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F859E@dbde02.ent.ti.com>
 <20100925001914.GO4211@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F917C@dbde02.ent.ti.com>
 <20100928152139.GB3117@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F94C9@dbde02.ent.ti.com>
 <20100928183157.GH3117@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB7FE8F9@dbde02.ent.ti.com>
 <20100929215635.GC3117@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB7FE911@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54360 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756822Ab0JECPH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 22:15:07 -0400
Content-Disposition: inline
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB7FE911@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dtor@mail.ru>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

* G, Manjunath Kondaiah <manjugk@ti.com> [100929 16:38]:
> 
> Patches are same except pulling out twl and driver patches from
> the series.
> 
> Paul's comment is addressed and changes are pushed to git branch.
> Build tested with omap3_defconfig and boot tested with beagle board.

Thanks, pulling this into omap-for-linus.

Tony
 
> The following changes since commit 899611ee7d373e5eeda08e9a8632684e1ebbbf00:
>   Linus Torvalds (1):
>         Linux 2.6.36-rc6
> 
> are available in the git repository at:
> 
>   git://dev.omapzoom.org/pub/scm/manju/kernel-omap3-dev.git omap_sparse_fixesv2
> 
> G, Manjunath Kondaiah (7):
>       OMAP: mach-omap2: Fix incorrect assignment warnings
>       OMAP: mach-omap2: Fix static declaration warnings
>       OMAP2plus: Fix static function warnings
>       OMAP: mach-omap2: Fix miscellaneous sparse warnings
>       OMAP: plat-omap: Fix static function warnings
>       OMAP: Convert write/read functions to raw read/write
>       OMAP3: Keypad: Fix incorrect type initializer
> 
> -Manjunath
> 
