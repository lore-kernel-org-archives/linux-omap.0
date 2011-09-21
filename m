From: Tony Lindgren <tony@atomide.com>
Subject: Re: Staging tree for AM335x platforms
Date: Wed, 21 Sep 2011 13:23:04 -0700
Message-ID: <20110921202304.GI2937@atomide.com>
References: <CA+T6QP=H0=WYcrA0HL+06Az6mFk7=K0O3MYNR=t+5Za-vDSyJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53537 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab1IUUXI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 16:23:08 -0400
Content-Disposition: inline
In-Reply-To: <CA+T6QP=H0=WYcrA0HL+06Az6mFk7=K0O3MYNR=t+5Za-vDSyJA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Kridner <jkridner@beagleboard.org>
Cc: linux-omap@vger.kernel.org, "Hiremath, Vaibhav" <hvaibhav@ti.com>

Hi,

* Jason Kridner <jkridner@beagleboard.org> [110921 10:56]:
> Tony,
> 
> I'm looking at creating a public repository to hold patches not yet in
> shape for inclusion in linux-omap (if not personally, then someone at
> TI that meets the below charter).  I know there can be concern that
> this becomes a distraction if we start pulling in community patches.
> It seems it needs to be coupled with reworking systems for acceptance
> upstream, but we'd like for there to be something where community
> members can generate patches against while we are in the process of
> cleaning up the underlying platform bits.

OK cool.
 
> Do you have any recommendations or guidelines that should be followed
> regarding anything about such a public repository?  Recommendations
> and guidelines can include, but not be limited to, where the
> repository should live, where patches and pull requests should be
> submitted, what types of patches should be accepted and what state
> they should be in, when should it be rebased, who is suitable to
> maintain this repository and what should be used for managing patch
> status (ie. patchwork and which patchwork).

Well in general the thing to watch out for is once you create a tree
it becomes a complete mess in about three months. Or else it just
becomes a graveyard of unmergeable patches :)

So keeping that in mind, ideally your tree would be just a daily merge
of various driver developers branches. And then try to set up things
where the responsibility of merging code upstream is on the drivers
developers. Trying to merge other people's patches upstream is not
scalable.

Other than that, you should be able to base it on some recent mainline
tag and pick in some queued up patches as needed.
 
> If this doesn't sound useful to you, then please feel free to shut me
> down on this.  The goal is to help and it is understood that
> contributions to the infrastructure (dev tree, pwr mgmt, etc.) are
> required to be productive.

That totally sounds usable to me :) Assuming you can figure out some
way to address the comments above.

For helping with contributions, I can think of a few places where
help is badly needed:

1. Remove dependencies in mainline kernel that block merging

   Maybe you can isolate some issues in mainline kernel that cause
   you problems merging your patches upstream? If so, whatever is
   needed should be done to patch away those dependencies. At least
   PM patches fit into this category..

2. Merge all am335x/beagle clone board-*.c files together

   This would help a lot when we start converting drivers to use
   device tree as it reduces the number of board-*.c files

3. Help with device tree conversion of device drivers

   Which drivers do most am335x and beagle clones use? Maybe
   you can help converting those drivers to use device tree?
   Sure some drivers depend on regulator framework conversion and
   the device tree omap_device glue layer, but there are already
   patches being posted for those

Regards,

Tony
