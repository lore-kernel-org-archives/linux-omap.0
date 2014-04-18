From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: OMAP hwmod and clock fixes for v3.15-rc
Date: Fri, 18 Apr 2014 16:47:48 -0700
Message-ID: <20140418234747.GR21823@atomide.com>
References: <alpine.DEB.2.02.1404112109320.5758@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:14923 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751691AbaDRXrz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2014 19:47:55 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1404112109320.5758@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [140411 14:14]:
> Hi Tony,
> 
> The following changes since commit 9e897e13bd46fa03485468609741974259a8c573:
> 
>   Merge branch 'for-linus' of git://git.open-osd.org/linux-open-osd (2014-04-10 14:33:02 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.15-rc/omap-fixes-a
> 
> for you to fetch changes up to 3d36ad7e7a9be0d130c862727a052ed279046437:
> 
>   ARM: OMAP2+: hwmod: fix missing braces in _init() (2014-04-11 12:29:09 -0600)
> 
> ----------------------------------------------------------------
> OMAP hwmod and clock fixes for v3.15-rc
> 
> A few OMAP hwmod and clock fixes for v3.15-rc.  Probably the most useful
> fix is the AM43xx DPLL patch.
> 
> Basic build, boot, and PM test results are here:
> 
> http://www.pwsan.com/omap/testlogs/prcm-fixes-a-v3.15-rc/20140411130021/

Thanks pulling into omap-for-v3.15/fixes.

Tony
 
> ----------------------------------------------------------------
> Roger Quadros (1):
>       ARM: OMAP3: hwmod data: Correct clock domains for USB modules
> 
> Suman Anna (1):
>       ARM: OMAP2+: hwmod: fix missing braces in _init()
> 
> Tomi Valkeinen (1):
>       ARM: AM43xx: fix dpll init in bypass mode
> 
>  arch/arm/mach-omap2/clkt_dpll.c            | 4 ++--
>  arch/arm/mach-omap2/omap_hwmod.c           | 3 ++-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 4 ++--
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> vmlinux object size
> (delta in bytes from prcm-fixes-a-v3.15-rc-base (9e897e13bd46fa03485468609741974259a8c573)):
>    text     data      bss    total  kernel
>       0        0        0        0  omap1_defconfig
>       0        0        0        0  omap1_defconfig_1510innovator_only
>       0        0        0        0  omap1_defconfig_5912osk_only
>       0       +8        0       +8  multi_v7_defconfig
>      -4       +8        0       +4  omap2plus_defconfig
>       0        0        0        0  omap2plus_defconfig_2430sdp_only
>       0        0        0        0  omap2plus_defconfig_am33xx_only
>    +112        0        0     +112  omap2plus_defconfig_am43xx_only
>      -4       +8        0       +4  omap2plus_defconfig_cpupm
>      -4        0        0       -4  omap2plus_defconfig_dra7xx_only
>     +12      +16        0      +28  omap2plus_defconfig_n800_multi_omap2xxx
>     +12       -8        0       +4  omap2plus_defconfig_n800_only_a
>      -4       +8        0       +4  omap2plus_defconfig_no_pm
>      -4        0        0       -4  omap2plus_defconfig_omap2_4_only
>      -4       +8        0       +4  omap2plus_defconfig_omap3_4_only
>      -4      -24        0      -28  omap2plus_defconfig_omap5_only
>     -16        0      +16        0  rmk_omap3430_ldp_allnoconfig
>     +16      +16        0      +32  rmk_omap3430_ldp_oldconfig
>      -8        0       +8        0  rmk_omap4430_sdp_allnoconfig
>     +16      +16        0      +32  rmk_omap4430_sdp_oldconfig
> 
> Boot-time memory difference
> (delta in bytes from prcm-fixes-a-v3.15-rc-base (9e897e13bd46fa03485468609741974259a8c573))
>   avail  rsrvd   high  freed  board          kconfig
>   (no differences)
> 
> 
