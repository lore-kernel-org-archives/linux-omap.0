From: Tony Lindgren <tony@atomide.com>
Subject: Re: Problem with git-fetch
Date: Tue, 29 Sep 2009 11:52:25 -0700
Message-ID: <20090929185225.GC16865@atomide.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DDAB4073@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62786 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbZI2SwY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Sep 2009 14:52:24 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DDAB4073@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

* Premi, Sanjeev <premi@ti.com> [090929 08:03]:
> Hi all,
> 
> I did a git-pull today, but I am seeing inconsistency on the patches
> being pulled on master.
> 
> When I browse the linux-omap tree in my browser, the history for
> "arch/arm/plat-omap/include/mach/cpu.h at the URL shows as:
> 
> 2009-08-19 	Felipe Balbi   arch: arm: omap: terminate ifndef
> 2009-08-18 	Tony Lindgren  OMAP: Fix incorrect 730 vs 850 detection
> 2009-08-10 	Tony Lindgren  OMAP: Fix testing of cpu defines for mach-omap1
> ...
> URL : http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=history;f=arch/arm/plat-omap/include/mach/cpu.h;h=11e73d9e8928458adc5656add696d835cf330d7a;hb=d3505405a4b2d1659566db1b69ba2b554771efc6
> 
> But when I did git-pull, the history is:
> 
> #
> # git-branch
> * master
> #
> # git log --pretty=format:"%h : %s" arch/arm/plat-omap/include/mach/cpu.h
> cd922049 : OMAP: Fix testing of cpu defines for mach-omap1
> 8e25ad9 : OMAP2/3: Add omap_type() for determining GP/EMU/HS
> ...
> 
> The top 2 commits are not visible!
> 
> Both the commits seem to be "present". I can view them via git-log.
> 
> Thinking it be be a problem with my local repo (though not sure what?);
> I did a fresh clone of the repo:
> 
> # git clone git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> 
> But, 2 hours later, it is still the same result!!
> 
> # git-branch
> * master
> #
> # git log --pretty=format:"%h : %s"
> d350540 : Fix compile for omap3evm because of ehci branch mismerge
> dbf3f0a : Merge branch 'omap7xx-fortony-rc1' of git://robotfuzz.com/linwizard-ke
> 6acfd68 : OMAP850: Fix zImage booting
> 6efe82e : OMAP850: PM: Add an ARCH_OMAP850 check
> 0a19200 : OMAP7XX: Clocks: Add ck_ref and armxor
> #
> #
> # git log --pretty=format:"%h : %s" arch/arm/plat-omap/include/mach/cpu.h
> cd922049 : OMAP: Fix testing of cpu defines for mach-omap1
> 8e25ad9 : OMAP2/3: Add omap_type() for determining GP/EMU/HS
> ...
> 
> Did anyone see this issue? OR can someone confirm that I am not alone?

If you're missing something, maybe look for it in the omap-2.6.31 branch.
Like I mentioned, I reset everything to mainline v2.6.32-rc1 with this:

$ git checkout -b omap-reset
$ git reset --hard v2.6.32-rc1
$ git merge -s ours master
$ git checkout master
$ git merge omap-reset

And after that I merged in omap-fixes, echi, cbus and the omap7xx
branches.

So basically we're now seeing the mainline history. All the history is
there, but may not be visible unless you check out some earlier branch.

I could not do git reset --hard v2.6.32-rc1 as the linux-omap tree would
not stay pullable that way. And there's no git merge -s theirs any longer
in git, so that's why the trickery above :)

Hopefully this explains what you're seeing!

Regards,

Tony
