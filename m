From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [GIT PULL] omap2 sparse fixes
Date: Mon, 27 Sep 2010 19:11:37 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F8D00@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9402785A390E@dbde02.ent.ti.com>
 <20100923225851.GR4211@atomide.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F859E@dbde02.ent.ti.com>
 <20100925001914.GO4211@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41243 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759373Ab0I0Nlr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Sep 2010 09:41:47 -0400
In-Reply-To: <20100925001914.GO4211@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


Hi Tony, 

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

Here is test report for all the boards:

1. omap3_defconfig with 2.6.36-rc5 code as is does not seems to be
boot. Enabled early printk and found it was due to musb driver. 
Boot log is here:
2430sdp_omap3_defconfig_bootlog_nochanges2code.txt
http://pastebin.com/wd92PMmE


2. Disabled musb in omap3_defconfig and boot seems be fine.
2430sdp_omap3_defconfig_bootlog_usbdisable
http://pastebin.com/eExED5q4


3. With sparse fix series, booting is as expected with omap3_defconfig
2430sdp_omap3_defconfig_bootlog_usbdisable_sparse_fixes.txt
http://pastebin.com/GMX4y2fS


4. Here zoom3 boot log:
Zoom3_omap3_defconfig_bootlog_usbdisable_sparse_fixes.
http://pastebin.com/C2A6YXAL


5. omap4 sdp boot log(with es2.0 patches pulled from for-next branch)
omap4sdp_es2.0_omap3_defconfig_bootlog_sparse_fixes.
http://pastebin.com/ebiP1X2h


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

I have declared these API's as extern functions in respective
header files. If it is ok, I can push the changes to git branch
for pull request.

-Manjunath
