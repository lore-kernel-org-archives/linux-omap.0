From: Tony Lindgren <tony@atomide.com>
Subject: Re: git pull request for minimal omap3 support (Re: [PATCH 0/0]
	Add minimal omap34xx support)
Date: Wed, 8 Oct 2008 11:12:57 +0300
Message-ID: <20081008081255.GG30831@atomide.com>
References: <1223035779-26306-1-git-send-email-tony@atomide.com> <20081008075000.GD30831@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58902 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873AbYJHIKE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Oct 2008 04:10:04 -0400
Content-Disposition: inline
In-Reply-To: <20081008075000.GD30831@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [081008 10:47]:
> * Tony Lindgren <tony@atomide.com> [081003 15:06]:
> > Hi all,
> > 
> > Here are few patches to add minimal omap34xx support, and
> > board files for Beagle and Overo boards.
> > 
> > The minimal omap34xx support patch was previously posted here
> > with the omap2 patches, this patch has some additions, such
> > as sram support.
> > 
> > For folks who are wondering what the Beagle and Overo boards
> > are, here are some links:
> > 
> > http://beagleboard.org/
> > http://www.gumstix.net/Overo/cat/Overo/115.html
> 
> Here's the pull request for this series. Note that this depends
> on the earlies omap2-upstream series.
> 
> The following changes since commit 684ae84fa8ebff956e7b9fc91bcaa1d0805da4d8:
>   Paul Walmsley (1):
>         ARM: OMAP2: Fix sparse, checkpatch warnings in OMAP2/3 IRQ code
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap3-upstream
> 
> Steve Sakoman (2):
>       ARM: OMAP2: Add support for the Gumstix Overo board (rev 3)
>       ARM: OMAP2: Defconfig for the Gumstix Overo board (rev 3)
> 
> Syed Mohammed, Khasim (1):
>       ARM: OMAP3: Add minimal Beagle board support
> 
> Tony Lindgren (2):
>       ARM: OMAP3: Add minimal omap3430 support
>       ARM: OMAP3: Add Beagle defconfig

Scrap this pull request, sorry for the extra noise.

I should not have any of these patches credited for me. I've just split
some patches and they are still showing as from me. Will repost with right
From: field.

Tony
