From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Fix linking error in twl-common.c for OMAP2/3/4
 only builds
Date: Wed, 28 Sep 2011 11:28:48 -0700
Message-ID: <20110928182848.GB6324@atomide.com>
References: <20110808110056.GA15134@n2100.arm.linux.org.uk>
 <1312893410-3968-1-git-send-email-peter.ujfalusi@ti.com>
 <20110810091519.GB1939@atomide.com>
 <4E43F029.6060208@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41062 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754725Ab1I1S2y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Sep 2011 14:28:54 -0400
Content-Disposition: inline
In-Reply-To: <4E43F029.6060208@matrix-vision.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Jones <michael.jones@matrix-vision.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

Sorry for the delay in replying..

* Michael Jones <michael.jones@matrix-vision.de> [110811 07:34]:
> 
> I still stumbled upon these linker errors when building for my OMAP3
> board, using the current linux-omap master branch. I inadvertently had
> CONFIG_ARCH_OMAP4=y (leftover from my starting point,
> omap2plus_defconfig), but didn't have any of the boards with
> omap_phy_internal.o selected (OMAP_4430SDP, OMAP4_PANDA, PCM049, PCM049,
> OMAP3517EVM). Maybe this isn't a concern anyway, since anybody building
> with CONFIG_ARCH_OMAP4 will presumably also be building one of those
> boards? I don't know if it is our goal to build successfully with every
> wacky CONFIG_ combination, but I thought I would report it here just in
> case.

Probably the best way is to get omap specific randconfigs going based
on something what Arnd posted few days ago. Even with the old defconfig
files we'll still be missing many corner cases.

Regards,

Tony
