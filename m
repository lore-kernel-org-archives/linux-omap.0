From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [GIT PULL] omap2 sparse fixes
Date: Tue, 28 Sep 2010 13:42:17 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F917C@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9402785A390E@dbde02.ent.ti.com>
 <20100923225851.GR4211@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F859E@dbde02.ent.ti.com>
 <20100925001914.GO4211@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59565 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702Ab0I1IMj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 04:12:39 -0400
In-Reply-To: <20100925001914.GO4211@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dtor@mail.ru>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>


Tony,

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Saturday, September 25, 2010 5:49 AM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [GIT PULL] omap2 sparse fixes
> 
> * G, Manjunath Kondaiah <manjugk@ti.com> [100924 12:33]:
> > 
> > Tony,
> > Here is new pull request which is rebased to 2.6.36-rc5.
> > 
> > -Manjunath
> > 
> > The following changes since commit 
> b30a3f6257ed2105259b404d419b4964e363928c:
> >   Linus Torvalds (1):
> >         Linux 2.6.36-rc5
> > 
> > are available in the git repository at:
> > 
> >   git://dev.omapzoom.org/pub/scm/manju/kernel-omap3-dev.git 
> > sparse_fixes
> > 
> > G, Manjunath Kondaiah (10):
> >       OMAP: mach-omap2: Fix incorrect assignment warnings
> >       OMAP: mach-omap2: Fix static declaration warnings
> >       OMAP: mach-omap2: Fix static function warnings
> >       OMAP: mach-omap2: Fix miscellaneous sparse warnings
> >       OMAP: plat-omap: Fix static function warnings
> >       OMAP: NAND: Fix static declaration warning
> >       TWL CORE: Fix sparse warning
> >       TWL IRQ: Fix fucntion declaration warnings
> >       OMAP2/3: Convert write/read functions to raw read/write
> >       OMAP3: Keypad: Fix incorrect type initializer
> 
> Hmm tried pulling these, but ran into an issue where at least 
> 2430 takes about a minute to boot with these patches with no 
> output on the console intially.
> 
> Can you please check that? Will not merge for now until we 
> figure out what changes with these patches.
> 
> Then, I also noticed the following exports getting added:
> 
> +EXPORT_SYMBOL(omap2_gp_clockevent_set_gptimer);
> +EXPORT_SYMBOL(omapfb_reserve_sram);
> +EXPORT_SYMBOL(omap_sram_init);
> 
> These should not be exported, they are only intended to be 
> called from the low-level platform init code. So exporting 
> them is not the right fix for these.

Similar comments received for twl irq apis's hence it was aligned
to declare these functions as extern functions in local header(if exists) 
or create new header in the source file directory for these declarations.

Three patches are fixed using above method which are:
OMAP: mach-omap2: Fix static function warnings
OMAP: plat-omap: Fix static function warnings
TWL IRQ: Fix fucntion declaration warnings

The patch series is tested on below boards(with omap3_defconfig)
and links for boot logs is provided below:

beagle boot log:
http://pastebin.com/jz6ZGHsH

zoom3 boot log:
http://pastebin.com/T0YjunCk

2430sdp boot log:
http://pastebin.com/7BbpieYS

As I mentioned in other e-mail, 2430sdp with omap3_defconfig boots
only after disabling usb. OMAP4SDPES2.0 boots with ES2.0 patches from
for-next branch.

Here is all parse errors fixed with this series:

Sparse warns before fixes:
http://pastebin.com/yct2p201

Sparse warns after fixes:
http://pastebin.com/qpnTbYwL

All the tested patches are pushed to new branch at:

The following changes since commit b30a3f6257ed2105259b404d419b4964e363928c:
  Linus Torvalds (1):
        Linux 2.6.36-rc5

are available in the git repository at:

  git://dev.omapzoom.org/pub/scm/manju/kernel-omap3-dev.git sparse_fixes_v3

G, Manjunath Kondaiah (10):
      OMAP: mach-omap2: Fix incorrect assignment warnings
      OMAP: mach-omap2: Fix static declaration warnings
      OMAP2plus: Fix static function warnings
      OMAP: mach-omap2: Fix miscellaneous sparse warnings
      OMAP: plat-omap: Fix static function warnings
      OMAP: NAND: Fix static declaration warning
      TWL CORE: Fix sparse warning
      TWL IRQ: Fix fucntion declaration warnings
      OMAP2/3: Convert write/read functions to raw read/write
      OMAP3: Keypad: Fix incorrect type initializer


-Manjunath

