From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: PRCM: drop macros not currently in use
Date: Wed, 31 Jul 2013 01:15:53 -0700
Message-ID: <20130731081552.GU7656@atomide.com>
References: <alpine.DEB.2.02.1307220454470.4804@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58463 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759048Ab3GaIP6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Jul 2013 04:15:58 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1307220454470.4804@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com

* Paul Walmsley <paul@pwsan.com> [130721 22:02]:
> Hi Tony,
> 
> Sorry for the delay on this - wanted to make sure it passed the local
> testbed before sending it upstream.
> 
> The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:
> 
>   Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.11-rc/omap-fixes-a
> 
> for you to fetch changes up to 11dab344053f726fe17ede95aa52c1eea1258a66:
> 
>   ARM: OMAP5: PRM/CM: Cleanup unused header (2013-07-21 22:10:25 -0600)
> 
> ----------------------------------------------------------------
> This series removes the currently-unused PRCM macros from
> arch/arm/mach-omap2.

Thanks & sorry for the delay on my part too, I was offline last week.
I'll pull these into omap-for-v3.12/cleanup.

Regards,

Tony
