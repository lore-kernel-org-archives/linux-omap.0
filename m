From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: a few more clock/hwmod fixes for v3.15-rc
Date: Fri, 16 May 2014 14:44:02 -0700
Message-ID: <20140516214401.GN12881@atomide.com>
References: <alpine.DEB.2.02.1405141850410.21921@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32912 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755874AbaEPVoI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 17:44:08 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1405141850410.21921@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [140514 11:52]:
> Hi Tony,
> 
> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
> 
>   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git for-v3.15-rc/omap-fixes-b
> 
> for you to fetch changes up to 0f9e19ad88eee820f517b85531b555a0fa73e7e4:
> 
>   ARM: omap5: hwmod_data: Correct IDLEMODE for McPDM (2014-05-14 11:25:58 -0600)
> 
> ----------------------------------------------------------------
> Two small OMAP fixes for v3.15-rc.  One fixes "slow motion" or
> "choppy" audio playback on OMAP5.  The other applies an OMAP3630 fix
> for clock rate setting for camera to other OMAP3 chips.
> 
> Basic build, boot, and PM test results are available here:
> 
> http://www.pwsan.com/omap/testlogs/prcm-fixes-b-v3.15-rc/20140514112639/

Thanks pulling into omap-for-v3.15/fixes-v3.

Regards,

Tony
 
> ----------------------------------------------------------------
> Laurent Pinchart (1):
>       ARM: OMAP3: clock: Back-propagate rate change from cam_mclk to dpll4_m5 on all OMAP3 platforms
> 
> Peter Ujfalusi (1):
>       ARM: omap5: hwmod_data: Correct IDLEMODE for McPDM
> 
>  arch/arm/mach-omap2/cclock3xxx_data.c      | 3 ++-
>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
