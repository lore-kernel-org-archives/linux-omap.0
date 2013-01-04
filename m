From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 00/12] ARM: OMAP2+: powerdomain/PM: convert to
 functional power states
Date: Fri, 4 Jan 2013 16:12:12 +0200
Message-ID: <1357308732.2221.108.camel@sokoban>
References: <20121209174545.6933.59371.stgit@dusk.lan>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56129 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754738Ab3ADOM1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Jan 2013 09:12:27 -0500
In-Reply-To: <20121209174545.6933.59371.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

As mentioned with the previous set, I have tested this one also on
omap3beagle + omap4panda boards. omap4 has one regression caused by this
set, as commented on the patch itself. Also posted a couple of other
minor comments. Other than that, you can consider this set as acked by
me.

-Tero

On Sun, 2012-12-09 at 10:52 -0700, Paul Walmsley wrote:
> Hi
> 
> This series converts the OMAP2+ powerdomain and PM code to use
> "functional power states" - high-level power states such as "OSWR",
> which reflect changes in multiple underlying registers, rather than
> expecting high-level PM code to program the registers directly.  This
> is intended to reduce the complexity of the high-level PM code and to
> make it easier to implement register caching of the various
> powerdomain registers, some of which are quite slow to access.
> 
> 
> - Paul
> 
> ---
> 
> vmlinux object size
> (delta in bytes from TEST_pm_cleanup_fixes_b_3.9 (2f8d7b1f0048df431ca226d81c5c27c4dd21953b)):
>    text     data      bss    total  kernel
>    +456      -56        0     +400  am33xx_only
>    +448      -96        0     +352  n800_multi_omap2xxx
>    +448      -96        0     +352  n800_only_a
>       0        0        0        0  omap1_defconfig
>       0        0        0        0  omap1_defconfig_1510innovator_only
>       0        0        0        0  omap1_defconfig_5912osk_only
>   +1180     -744        0     +436  omap2plus_defconfig
>    +584      -72        0     +512  omap2plus_defconfig_2430sdp_only
>   +1244     -808        0     +436  omap2plus_defconfig_cpupm
>    +976    -1224        0     -248  omap2plus_defconfig_no_pm
>    +844     -408        0     +436  omap2plus_defconfig_omap2_4_only
>   +1088     -624        0     +464  omap2plus_defconfig_omap3_4_only
>   +1292    -1232     -352     -292  rmk_omap3430_ldp_allnoconfig
>    +916     -720        0     +196  rmk_omap3430_ldp_oldconfig
>   +1292    -1232     -352     -292  rmk_omap4430_sdp_allnoconfig
>    +840     -392        0     +448  rmk_omap4430_sdp_oldconfig
> 
> Boot-time memory difference
> (delta in bytes from TEST_pm_cleanup_fixes_b_3.9 (2f8d7b1f0048df431ca226d81c5c27c4dd21953b))
>   avail  rsrvd   high  freed  board          kconfig
>     -8k     8k      .      .  2430sdp        omap2plus_defconfig
>     -8k     8k      .      .  3517evm        omap2plus_defconfig
>     -8k     8k      .      .  3530es3beagle  omap2plus_defconfig
>     -8k     8k      .      .  3730beaglexm   omap2plus_defconfig
>     -8k     8k      .      .  37xxevm        omap2plus_defconfig
>     -8k     8k      .      .  4430es2panda   omap2plus_defconfig
>     -8k     8k      .      .  4460pandaes    omap2plus_defconfig
>     -8k     8k      .      .  cmt3517        omap2plus_defconfig
> 
> Jean Pihet (6):
>       ARM: OMAP2+: PM: introduce power domains functional states
>       ARM: OMAP2+: PM debug: trace the functional power domains states
>       ARM: OMAP2xxx: PM: convert to use the functional power states API
>       ARM: OMAP3xxx: PM: convert to use the functional power states API
>       ARM: OMAP44xx: PM: convert to use the functional power states API
>       ARM: OMAP2+: PM: use power domain functional state in stats counters
> 
> Paul Walmsley (6):
>       ARM: OMAP2+: powerdomain: add functions that report on powerdomain capabilities
>       ARM: OMAP2+: powerdomain: drop many low-level powerdomain funcs
>       ARM: OMAP2+: powerdomain: add ability to test for supported power states
>       ARM: OMAP2+: powerdomain/PM: only program supported power states
>       ARM: OMAP2+: powerdomain: program memory bank next-power-state upon init
>       ARM: OMAP2+: powerdomain: assume memory bank power states follow powerdomain
> 
> 
>  arch/arm/mach-omap2/common.h              |    7 
>  arch/arm/mach-omap2/cpuidle34xx.c         |   95 +-
>  arch/arm/mach-omap2/cpuidle44xx.c         |   32 -
>  arch/arm/mach-omap2/omap-hotplug.c        |    2 
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c |   69 +-
>  arch/arm/mach-omap2/pm-debug.c            |   46 -
>  arch/arm/mach-omap2/pm.h                  |    2 
>  arch/arm/mach-omap2/pm24xx.c              |   33 -
>  arch/arm/mach-omap2/pm34xx.c              |  188 +++-
>  arch/arm/mach-omap2/pm44xx.c              |   47 +
>  arch/arm/mach-omap2/powerdomain.c         | 1235 +++++++++++++++++------------
>  arch/arm/mach-omap2/powerdomain.h         |   69 +-
>  12 files changed, 1040 insertions(+), 785 deletions(-)
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


