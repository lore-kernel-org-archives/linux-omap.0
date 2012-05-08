From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: PRCM: first set of updates for v3.5
Date: Tue, 8 May 2012 11:16:39 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205081114510.8126@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48769 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757760Ab2EHRQj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 13:16:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi Tony,

this pull request is for some CM, PRM, clock, clockdomain, and
powerdomain updates for v3.5.  It is a prerequisite for some upcoming
hwmod pull requests.

Boot-tested on 5912OSK, N800, 2430SDP, 3517EVM, CM-T3517, 3530ES3
BeagleBoard, 37xx EVM, and 4430ES2 PandaBoard.  (Note that 3517EVM and
CM-T3517 don't boot fully to userspace due to issues with the EMAC
code and board files that are unrelated to this series.)  Static
suspend and dynamic idle to CSWR and OFF have been lightly tested on
3530ES3 BeagleBoard, 37xx EVM, and 4430ES2 PandaBoard.  (Note that
4430ES2 Pandaboard has a UART driver-related dynamic idle issue that
is unrelated to this series.)  Boot and test logs are available at:

http://www.pwsan.com/omap/bootlogs/20120508/prcm_devel_a_3.5__0135f6a04642c192bdf4b36e06937d3387e174ff/

object size (delta in bytes from omap4_hwmod_devel_a_3.5 (96566043b19ae76d3828ce75cbf28dc6d0bcaaf1)):
 text 	 data 	  bss 	total 	kernel
    0 	    0 	    0 	    0 	5912osk_testconfig/vmlinux
  -72 	  +40 	    0 	  -32 	n800_multi_omap2xxx/vmlinux
  -72 	  -24 	    0 	  -96 	n800_testconfig/vmlinux
    0 	    0 	    0 	    0 	omap1_defconfig/vmlinux
  +60 	 -240 	  +64 	 -116 	omap2_4_testconfig/vmlinux
  -36 	 -200 	  +64 	 -172 	omap2plus_defconfig/vmlinux
  -28 	 -256 	  +64 	 -220 	omap2plus_no_pm/vmlinux
  -36 	 -256 	  +64 	 -228 	omap3_4_testconfig/vmlinux
 -192 	    0 	    0 	 -192 	omap3_testconfig/vmlinux
  +52 	 -240 	  +64 	 -124 	omap4_testconfig/vmlinux

The following changes since commit 96566043b19ae76d3828ce75cbf28dc6d0bcaaf1:

  ARM: OMAP4: hwmod data: add DEBUGSS skeleton (2012-04-19 13:33:59 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-b-for-3.5

for you to fetch changes up to 0135f6a04642c192bdf4b36e06937d3387e174ff:

  Merge branches 'clock_am35xx_cleanup_3.5', 'prm_cm_devel_a_3.5', 'clock_devel_a_3.5' and 'pwrdm_clkdm_cleanup_3.5' into prcm_devel_a_3.5 (2012-05-07 23:55:56 -0600)

- ----------------------------------------------------------------

Some OMAP PRCM updates for 3.5.  Includes some clock, clockdomain,
powerdomain, PRM, and CM changes.

- ----------------------------------------------------------------
Kevin Hilman (3):
      ARM: OMAP3: clock data: replace 3503/3517 flag with AM35x flag for UART4
      ARM: OMAP3: clock data: treat all AM35x devices the same
      ARM: OMAP: clock: convert AM3517/3505 detection/flags to AM35xx

Mark A. Greer (1):
      arm: omap3: clockdomain data: Remove superfluous commas from gfx_sgx_3xxx_wkdeps[]

Paul Walmsley (2):
      ARM: OMAP3: clock data: add clockdomain for HDQ functional clock
      Merge branches 'clock_am35xx_cleanup_3.5', 'prm_cm_devel_a_3.5', 'clock_devel_a_3.5' and 'pwrdm_clkdm_cleanup_3.5' into prcm_devel_a_3.5

R Sricharan (1):
      ARM: OMAP4+: Add prm and cm base init function.

Rajendra Nayak (1):
      ARM: OMAP3: Fix CM register bit masks

Santosh Shilimkar (1):
      ARM: OMAP2+: powerdomain: Get rid off duplicate pwrdm_clkdm_state_switch() API

Tarun Kanti DebBarma (1):
      ARM: OMAP2+: dmtimer: cleanup iclk usage

Vaibhav Bedia (1):
      ARM: OMAP3+: dpll: Configure autoidle mode only if it's supported

Vaibhav Hiremath (1):
      ARM: OMAP2/3: Add idle_st bits for ST_32KSYNC timer to prcm-common header

 arch/arm/mach-omap2/clock.c                   |    2 +-
 arch/arm/mach-omap2/clock3xxx_data.c          |   25 +++++++------------------
 arch/arm/mach-omap2/clock44xx_data.c          |   11 -----------
 arch/arm/mach-omap2/clockdomain.c             |    7 +++----
 arch/arm/mach-omap2/clockdomains3xxx_data.c   |    6 +++---
 arch/arm/mach-omap2/cm-regbits-34xx.h         |    4 ++--
 arch/arm/mach-omap2/cminst44xx.c              |   28 ++++++++++++++++++----------
 arch/arm/mach-omap2/common.c                  |    1 +
 arch/arm/mach-omap2/common.h                  |    1 +
 arch/arm/mach-omap2/dpll3xxx.c                |   23 ++++++++++++++++++-----
 arch/arm/mach-omap2/powerdomain.c             |   10 ----------
 arch/arm/mach-omap2/powerdomain.h             |    1 -
 arch/arm/mach-omap2/prcm-common.h             |   17 +++++++++++++++++
 arch/arm/mach-omap2/prcm.c                    |    8 ++++++++
 arch/arm/mach-omap2/prminst44xx.c             |   27 ++++++++++++++++-----------
 arch/arm/mach-omap2/timer.c                   |    7 -------
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    4 +---
 arch/arm/plat-omap/include/plat/dmtimer.h     |    2 +-
 18 files changed, 97 insertions(+), 87 deletions(-)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqVRtAAoJEMePsQ0LvSpLu4gP/2EaOnsZLxGEA/ANDJjmKorz
gygbv9Ua9D16uY+9nQttOp43srNPfayWIlxHjP1+sPBBs9D9w99tBLIbBi8Z50GG
eiyA59AKMc2QJpHLfxy5yV2F8N+GwwKShU0PgDXaB9jTUm01zORO2N2hhbtFi/cm
fo1EijqIYGzSSMmy1Yi2SLSv1KThzDCY8PV99ASQyu3FSuIz52Y3LfIFJ7x7hXqY
mz8h7Yo/uSZG2m9KrVyTxBD0KGqp5wfGQ0Z6BVmUibC6f2W3b6RDAz8+QiPph4my
Dp4hMZTUqPtyvD3pGyIJTCguSERnwkVpkOSTI5tHWGLiYwNABSy17sQa9OG2pVLH
k34/6aot+9u9KrRD0T4YRWv+IHXUuQcQgnZgA3phV7JNzIceD9n5vueTcTclCvxF
8T+1oKfTtpolkARiz82Yvc3ZZXq6tva1mNMfO81pyAnMhRo/fvCrrrXZuLzdwEQy
ATjBcgjJTMbM5bxfJxUuPy1Ag2qo5JGVS5wnYB2svY8RvFN5awU1KL+apSVokBQN
ezyRLGDdhqKCpJm9ZqLNUuKMKRAJx+k8YrdbH3rOQLEh1AlshpNeZpfzNq4SpLHJ
gfjy+nNMiwwUuj5WmJAD/9vReaDwSVf7CXdGjSo7Yf1LfWkae2rUzBVLXiuBBhc3
77yrVWbz1Cl4cnFnW1vV
=vaaY
-----END PGP SIGNATURE-----
