From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: clean up smatch warnings and unwrap strings,
 for 3.7
Date: Wed, 12 Sep 2012 15:08:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209121507510.17903@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40289 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760078Ab2ILPIs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 11:08:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-cleanup-b-for-3.7

for you to fetch changes up to 7852ec0536ca39cefffc6301dc77f8ae55592926:

  ARM: OMAP: unwrap strings (2012-09-12 02:57:10 -0600)

- ----------------------------------------------------------------
smatch and string-wrapping cleanups for the OMAP subarch code.

These changes fix some of the more meaningful warnings that smatch
returns for the OMAP subarch code, and unwraps strings that are
wrapped at the 80-column boundary, to conform with the current
practice.

Basic build, boot, and PM logs are available here:

http://www.pwsan.com/omap/testlogs/warnings_a_cleanup_3.7/20120912025927/

- ----------------------------------------------------------------

object size (delta in bytes from test_v3.6-rc5 (55d512e245bc7699a8800e23df1a24195dd08217)):
  text 	  data 	   bss 	 total 	kernel
   +80 	   +16 	     0 	   +96 	2430_testconfig
     0 	     0 	     0 	     0 	5912osk_testconfig
   +48 	   +16 	     0 	   +64 	am33xx_testconfig
   +64 	    -8 	     0 	   +56 	n800_b_testconfig
   +64 	    -8 	     0 	   +56 	n800_multi_omap2xxx
   +64 	   +24 	     0 	   +88 	n800_testconfig
     0 	     0 	     0 	     0 	omap1510_defconfig
     0 	     0 	     0 	     0 	omap1_defconfig
   +68 	   +16 	     0 	   +84 	omap2_4_testconfig
  +112 	   +16 	     0 	  +128 	omap2plus_defconfig
   +48 	   +16 	     0 	   +64 	omap2plus_defconfig_cpupm
  +100 	   +16 	     0 	  +116 	omap2plus_no_pm
   +20 	    +8 	     0 	   +28 	omap3_4_testconfig
   +20 	    +8 	     0 	   +28 	omap3_testconfig
   +84 	     0 	     0 	   +84 	omap4_testconfig
   +60 	     0 	     0 	   +60 	rmk_omap3430_ldp_oldconfig
   +64 	     0 	     0 	   +64 	rmk_omap4430_sdp_oldconfig

Paul Walmsley (2):
      ARM: OMAP: clean up some smatch warnings, fix some printk(KERN_ERR ...
      ARM: OMAP: unwrap strings

 arch/arm/mach-omap1/board-htcherald.c       |    3 +-
 arch/arm/mach-omap1/clock.c                 |    4 +-
 arch/arm/mach-omap1/clock_data.c            |   13 +++--
 arch/arm/mach-omap1/dma.c                   |    5 +-
 arch/arm/mach-omap1/lcd_dma.c               |    6 +--
 arch/arm/mach-omap1/leds-h2p2-debug.c       |   12 +++--
 arch/arm/mach-omap2/board-n8x0.c            |    7 ++-
 arch/arm/mach-omap2/board-overo.c           |    6 +--
 arch/arm/mach-omap2/board-zoom-debugboard.c |    7 ++-
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c      |   10 ++--
 arch/arm/mach-omap2/clkt_clksel.c           |   28 +++++-----
 arch/arm/mach-omap2/clkt_dpll.c             |    8 +--
 arch/arm/mach-omap2/clock.c                 |   20 +++-----
 arch/arm/mach-omap2/clock3xxx.c             |    3 +-
 arch/arm/mach-omap2/clockdomain.c           |   74 ++++++++++++---------------
 arch/arm/mach-omap2/common-board-devices.c  |    3 +-
 arch/arm/mach-omap2/dpll3xxx.c              |    7 ++-
 arch/arm/mach-omap2/gpio.c                  |    1 +
 arch/arm/mach-omap2/gpmc.c                  |    2 +-
 arch/arm/mach-omap2/id.c                    |    5 +-
 arch/arm/mach-omap2/irq.c                   |    5 +-
 arch/arm/mach-omap2/omap_hwmod.c            |   16 +++---
 arch/arm/mach-omap2/opp.c                   |   15 +++---
 arch/arm/mach-omap2/pm.c                    |    4 +-
 arch/arm/mach-omap2/pm34xx.c                |    8 ++-
 arch/arm/mach-omap2/pm44xx.c                |    8 ++-
 arch/arm/mach-omap2/powerdomain.c           |   36 ++++++-------
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c  |    4 +-
 arch/arm/mach-omap2/powerdomain44xx.c       |    4 +-
 arch/arm/mach-omap2/prcm.c                  |    8 +--
 arch/arm/mach-omap2/serial.c                |   12 +++--
 arch/arm/mach-omap2/sr_device.c             |   13 +++--
 arch/arm/mach-omap2/timer.c                 |    2 +-
 arch/arm/mach-omap2/vc.c                    |    5 +-
 arch/arm/mach-omap2/voltage.c               |   12 ++---
 arch/arm/mach-omap2/vp.c                    |   16 +++---
 arch/arm/plat-omap/dma.c                    |   51 ++++++++----------
 arch/arm/plat-omap/mux.c                    |    2 +-
 arch/arm/plat-omap/omap-pm-noop.c           |   39 +++++++-------
 arch/arm/plat-omap/omap_device.c            |   25 ++++-----
 40 files changed, 233 insertions(+), 276 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQUKUlAAoJEMePsQ0LvSpLo84QAKz+hxAsG5CCVheYwgPtrVTA
Z2sEAIb+La3lQHalzyxCYH/6Xf3LsXLhOQVRemtd9BQQYQvAEIfAt+9wnPeT/W2y
K9tjI6iNAfSIbzXNHOwXVqkBRemWsLMNwiBV4eh2BfLyPctHnxN1MP9bWgaBxqmS
EBAS4MlPnH0j6cZkeLBv4EZsSyJrOCiP98+M9UBX+iLgZNvwy+DEpwKQR/QP+KAx
HZ8oZWTvUVPfTzz4Bc3K9IQ35fo+NTie9yLn3c6WdnYvfNINNFTnEXG04ydegsGz
rIkBDYsK380RSPzYwnEAdXGt6dWDAhGQfOdHOdUBMqz2PXNtOTSNWJvp+YC4rqtS
NdGpTanUjQqNcRlTfZOJzBYsAzcBhezLXQEK40ew97cLBouaQsmsF8huYuQTLjhU
u2wonX5d4BEF7GxzuOfJhh7Ajktt7haL4hJD784PsxpgllA7lafxVkAqEMssi8nE
nu+C7qOei9QcFhL6aRKdGJM+XjbU+bzBnyE/NFPULnw1OMhbYJusZlL8cYrfUpZb
QU9SpbE/lttPoF5btXy1MpbAHRGvFKAJiQ/NxalON8M+GvIvimxFcDVG4oa+9QH6
SzrMdkZ3Hd7CSIyvkP4tCtQrK3uubgbOZrIuoqUPgCTSddJmUfYhfXJAj62zRn6/
dR8rg4jJpd407bYVbqgj
=OYam
-----END PGP SIGNATURE-----
