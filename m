From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: clock patches for 3.7
Date: Fri, 21 Sep 2012 14:10:54 -0700
Message-ID: <20120921211053.GL28835@atomide.com>
References: <alpine.DEB.2.00.1209210246110.20983@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:50911 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754108Ab2IUVK5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 17:10:57 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1209210246110.20983@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120920 19:48]:
> Hi Tony
> 
> The following changes since commit 5698bd757d55b1bb87edd1a9744ab09c142abfc2:
> 
>   Linux 3.6-rc6 (2012-09-16 14:58:51 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-c-for-3.7

Thanks pulling this into devel-clock. This too may miss the v3.7
merge window.

Regards,

Tony
 
> for you to fetch changes up to a238ce78aa0cfe0e3bcae706e77273516f33f31b:
> 
>   ARM: AM33XX: cm: Add bit-field width values (2012-09-20 19:44:21 -0600)
> 
> ----------------------------------------------------------------
> OMAP clock changes for 3.7.  This includes some preparatory patches
> for common clock framework changeover.
> 
> These patches have been tested for meaningful warnings from
> checkpatch, sparse, smatch, and cppcheck.  Basic build, boot, and
> PM test logs are available here:
> 
>     http://www.pwsan.com/omap/testlogs/clock_devel_3.7/20120920194425/
> 
> ----------------------------------------------------------------
> 
> object size (delta in bytes from test_v3.6-rc6 (5698bd757d55b1bb87edd1a9744ab09c142abfc2)):
>   text 	  data 	   bss 	 total 	kernel
>   -120 	  +496 	     0 	  +376 	2430_testconfig
>    -96 	     0 	     0 	   -96 	5912osk_testconfig
>   -116 	 +1328 	     0 	 +1212 	am33xx_testconfig
>   -132 	  +464 	     0 	  +332 	n800_b_testconfig
>   -100 	  +976 	     0 	  +876 	n800_multi_omap2xxx
>   -132 	  +464 	     0 	  +332 	n800_testconfig
>    -96 	     0 	     0 	   -96 	omap1510_defconfig
>   -128 	     0 	     0 	  -128 	omap1_defconfig
>    -92 	 +1480 	     0 	 +1388 	omap2_4_testconfig
>   -116 	 +2288 	     0 	 +2172 	omap2plus_defconfig
>   -116 	 +2312 	     0 	 +2196 	omap2plus_defconfig_cpupm
>    -96 	 +2320 	     0 	 +2224 	omap2plus_no_pm
>   -160 	 +1416 	     0 	 +1256 	omap3_4_testconfig
>    -96 	  +904 	     0 	  +808 	omap3_testconfig
>   -156 	  +488 	     0 	  +332 	omap4_testconfig
>   -108 	  +880 	     0 	  +772 	rmk_omap3430_ldp_oldconfig
>  +3960 	  +520 	     0 	 +4480 	rmk_omap4430_sdp_oldconfig
> 
> AnilKumar Ch (1):
>       ARM: OMAP2+: AM33XX: clock data: Add clkdev alias for cpu0
> 
> Jon Hunter (2):
>       ARM: OMAP2420: Cosmetic fix for timer clock aliases
>       ARM: OMAP4: Add timer clock aliases for device-tree
> 
> Michael Jones (1):
>       ARM: OMAP3: clock data: remove obsolete comment
> 
> Mike Turquette (1):
>       ARM: omap4: cm: add bitfield width values
> 
> Paul Walmsley (3):
>       ARM: OMAP3: clock data: Add the USB TLL clocks device name
>       ARM: OMAP2+: clock data: add some aliases for use by CPUFreq only
>       SPI: OMAP: remove unnecessary includes of plat/clock.h
> 
> Rajendra Nayak (3):
>       ARM: omap: clk: add clk_prepare and clk_unprepare
>       ARM: omap: hwmod: get rid of all omap_clk_get_by_name usage
>       ARM: OMAP2+: clock: Remove all direct dereferencing of struct clk
> 
> Vaibhav Hiremath (1):
>       ARM: AM33XX: cm: Add bit-field width values
> 
>  arch/arm/mach-omap2/board-apollon.c          |    4 +-
>  arch/arm/mach-omap2/board-h4.c               |    6 +-
>  arch/arm/mach-omap2/board-omap4panda.c       |    2 +-
>  arch/arm/mach-omap2/clkt2xxx_apll.c          |    2 +-
>  arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |   10 +-
>  arch/arm/mach-omap2/clkt34xx_dpll3m2.c       |   20 +-
>  arch/arm/mach-omap2/clkt_clksel.c            |   91 +++---
>  arch/arm/mach-omap2/clkt_dpll.c              |   26 +-
>  arch/arm/mach-omap2/clock.c                  |   11 +-
>  arch/arm/mach-omap2/clock2420_data.c         |   24 +-
>  arch/arm/mach-omap2/clock2430_data.c         |   22 ++
>  arch/arm/mach-omap2/clock33xx_data.c         |    1 +
>  arch/arm/mach-omap2/clock3xxx.c              |    8 +-
>  arch/arm/mach-omap2/clock3xxx_data.c         |   33 ++-
>  arch/arm/mach-omap2/clock44xx_data.c         |   21 ++
>  arch/arm/mach-omap2/cm-regbits-33xx.h        |  158 +++++++++-
>  arch/arm/mach-omap2/cm-regbits-44xx.h        |  411 +++++++++++++++++++++-----
>  arch/arm/mach-omap2/control.h                |    1 +
>  arch/arm/mach-omap2/display.c                |    4 +-
>  arch/arm/mach-omap2/dpll3xxx.c               |   48 +--
>  arch/arm/mach-omap2/gpmc.c                   |    2 +-
>  arch/arm/mach-omap2/omap_hwmod.c             |   45 ++-
>  arch/arm/mach-omap2/pm.c                     |    2 +-
>  arch/arm/plat-omap/clock.c                   |   27 --
>  arch/arm/plat-omap/include/plat/clock.h      |    5 +
>  arch/arm/plat-omap/omap_device.c             |    4 +-
>  drivers/spi/spi-omap-100k.c                  |    2 -
>  drivers/spi/spi-omap2-mcspi.c                |    1 -
>  28 files changed, 760 insertions(+), 231 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
