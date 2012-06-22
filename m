From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: clock/hwmod/warning fixes for 3.5-rc
Date: Fri, 22 Jun 2012 01:30:23 -0700
Message-ID: <20120622083023.GY12766@atomide.com>
References: <alpine.DEB.2.00.1206211913120.10198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32073 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761677Ab2FVIa0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jun 2012 04:30:26 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1206211913120.10198@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

Olof,

Can you please take the branch below directly from Paul for this
-rc cycle?

It would be good to get these in. If you don't want to take
all of them this late because they're not all strictly oopses or
regressions, let us know and Paul can regroup them.

I've given them a boot test on n800, 2430sdp, n900, zoom3, and blaze,
so that covers the N800 issue Paul is reporting below. The suspend
and resume issues seem to be caused by EHCI driver, so that's a
separate issue.

Regards,

Tony


* Paul Walmsley <paul@pwsan.com> [120621 18:19]:
> Hi Tony
> 
> The following changes since commit 485802a6c524e62b5924849dd727ddbb1497cc71:
> 
>   Linux 3.5-rc3 (2012-06-16 17:25:17 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-fixes-a-for-3.5rc
> 
> for you to fetch changes up to dc57aef503859dbf724f6126c58b2e1672e215f3:
> 
>   ARM: OMAP4: hwmod data: Force HDMI in no-idle while enabled (2012-06-21 18:08:47 -0600)
> 
> ----------------------------------------------------------------
> Some uncontroversial OMAP clock, hwmod, and compiler warning fixes for 3.5-rc
> 
> ----------------------------------------------------------------
> 
> Testing logs are at
> 
> http://www.pwsan.com/omap/bootlogs/20120621/omap_fixes_a_3.5rc__dc57aef503859dbf724f6126c58b2e1672e215f3/
> 
> N800 doesn't boot due to MMC problems; 3517 boards won't NFS-mount root
> and WARN() during boot; 37xx EVM and Beagle don't wake up from the serial
> port from off-mode system suspend, and the CORE powerdomain doesn't
> enter retention or off-mode during either dynamic idle or system suspend;
> and OMAP4430 Panda doesn't return from system suspend.  All of these
> problems were pre-existing with v3.5-rc3; none of them were added by this
> patch set.
> 
> object size (delta in bytes from v3.5-rc3 (485802a6c524e62b5924849dd727ddbb1497cc71)):
>   text 	  data 	   bss 	 total 	kernel
>      0 	     0 	     0 	     0 	5912osk_testconfig/vmlinux
>      0 	     0 	     0 	     0 	am33xx_testconfig/vmlinux
>    +32 	     0 	     0 	   +32 	n800_b_testconfig/vmlinux
>      0 	     0 	     0 	     0 	n800_multi_omap2xxx/vmlinux
>    +32 	     0 	     0 	   +32 	n800_testconfig/vmlinux
>      0 	     0 	     0 	     0 	omap1510_defconfig/vmlinux
>      0 	     0 	     0 	     0 	omap1_defconfig/vmlinux
>    +32 	     0 	     0 	   +32 	omap2_4_testconfig/vmlinux
>  +4160 	     0 	     0 	 +4160 	omap2plus_defconfig/vmlinux
>      0 	     0 	     0 	     0 	omap2plus_no_pm/vmlinux
>      0 	     0 	     0 	     0 	omap3_4_testconfig/vmlinux
>      0 	     0 	     0 	     0 	omap3_testconfig/vmlinux
>      0 	     0 	     0 	     0 	omap4_testconfig/vmlinux
> 
> Djamil Elaidi (1):
>       ARM: OMAP4+: hwmod: fix issue causing IPs not going back to Smart-Standby
> 
> Paul Walmsley (4):
>       ARM: OMAP4: hwmod data: fix 32k sync timer idle modes
>       ARM: OMAP4: clock data: add clockdomains for clocks used as main clocks
>       ARM: OMAP2+: CM: increase the module disable timeout
>       ARM: OMAP2+: mux: fix sparse warning
> 
> Ricardo Neri (1):
>       ARM: OMAP4: hwmod data: Force HDMI in no-idle while enabled
> 
> Todd Poynor (1):
>       ARM: OMAP: PM: Lock clocks list while generating summary
> 
>  arch/arm/mach-omap2/clock44xx_data.c       |    5 +++++
>  arch/arm/mach-omap2/cm.h                   |   11 +++++++++++
>  arch/arm/mach-omap2/cminst44xx.c           |    4 ++--
>  arch/arm/mach-omap2/mux.c                  |    1 +
>  arch/arm/mach-omap2/omap_hwmod.c           |    2 +-
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    8 ++++++--
>  arch/arm/plat-omap/clock.c                 |    2 ++
>  7 files changed, 28 insertions(+), 5 deletions(-)
