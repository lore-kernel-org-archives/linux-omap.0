From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL v2] ARM: AM33xx: hwmod/clock: add hwmod data and some
 clock/hwmod fixes for 3.7
Date: Wed, 12 Sep 2012 23:45:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209122344250.7275@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209121558540.17903@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41797 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933413Ab2ILXpN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 19:45:13 -0400
In-Reply-To: <alpine.DEB.2.00.1209121558540.17903@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-a2-for-3.7

for you to fetch changes up to 83c115426818378370b8cf2be16ca19bdcdc2ac4:

  ARM: AM33XX: clock: Add dcan clock aliases for device-tree (2012-09-12 16:28:35 -0600)

- ----------------------------------------------------------------
AM33xx hwmod data and miscellaneous clock and hwmod fixes.  AM33xx
should now boot on mainline after this is applied, according to
Vaibhav.

This second version includes trailing commas at the end of structure
records at Tony's request.  It also adds a OMAP_INTC_START macro
expansion to each IRQ number to make the sparseirq conversion easier.

Basic build, boot, and PM test transcripts are here:

http://www.pwsan.com/omap/testlogs/am33xx_hwmod_clock_devel_3.7/20120912165952/

- ----------------------------------------------------------------

object size (delta in bytes from test_v3.6-rc5 (55d512e245bc7699a8800e23df1a24195dd08217)):
  text 	  data 	   bss 	 total 	kernel
 +8972 	+16432 	   +64 	+25468 	2430_testconfig
     0 	     0 	     0 	     0 	5912osk_testconfig
 +8784 	+16440 	     0 	+25224 	am33xx_testconfig
 +8960 	+16464 	     0 	+25424 	n800_b_testconfig
 +8980 	+16408 	     0 	+25388 	n800_multi_omap2xxx
 +8960 	+16488 	     0 	+25448 	n800_testconfig
     0 	     0 	     0 	     0 	omap1510_defconfig
     0 	     0 	     0 	     0 	omap1_defconfig
 +8832 	+16488 	     0 	+25320 	omap2_4_testconfig
 +8864 	+16472 	     0 	+25336 	omap2plus_defconfig
 +8800 	+16440 	     0 	+25240 	omap2plus_defconfig_cpupm
 +8860 	+16488 	     0 	+25348 	omap2plus_no_pm
 +4712 	+16488 	   +64 	+21264 	omap3_4_testconfig
 +8956 	+16408 	     0 	+25364 	omap3_testconfig
 +8872 	+16472 	     0 	+25344 	omap4_testconfig
 +9040 	+16464 	     0 	+25504 	rmk_omap3430_ldp_oldconfig
 +4820 	+14632 	     0 	+19452 	rmk_omap4430_sdp_oldconfig

Note that the object sizes for many .configs are larger than they
should be, since CONFIG_SOC_AM33XX is selected by default during 'make
oldnoconfig'.  The next time these configs are updated, it will be
deselected - probably during the next baseline test.

Vaibhav Hiremath (4):
      ARM: OMAP2+: hwmod: Hook-up am33xx support in omap_hwmod framework
      ARM: OMAP3+: hwmod: Add AM33XX HWMOD data
      ARM: OMAP2+: dpll: Add missing soc_is_am33xx() check for common functions
      ARM: AM33XX: clock: Add dcan clock aliases for device-tree

 arch/arm/mach-omap2/Makefile                 |    1 +
 arch/arm/mach-omap2/clkt_dpll.c              |    4 +-
 arch/arm/mach-omap2/clock33xx_data.c         |    2 +
 arch/arm/mach-omap2/dpll3xxx.c               |    4 +-
 arch/arm/mach-omap2/io.c                     |    2 +
 arch/arm/mach-omap2/omap_hwmod.c             |  178 ++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c   | 3384 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 8 files changed, 3572 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_33xx_data.c
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQUR4UAAoJEMePsQ0LvSpLqEYP/Ra6lTg17JS6wQ2X6BTaOP1J
zhalnLsJmYVoVUOpLFgJC5uDih7Qc0rk8vkqZOrJYUlSfYThT/bO8JXFKTLU7CnM
I0K6Pf9YLEkBMgUwvm1vIz794YpLJ2WcE/vplnwjcAQTsmnA2pzVqlul9qwzb6oI
6+XauRTs4g9DJXnhqwEZTSki/d3J41aKkYikP25Kc2N+6yzDZYH2xOR5NVDs7tou
KL0MGuQ84DZbZXjkbd5pWXR552ae28L0ik5qmOjDw4Q+PnSok91pNlMElxDZ/60w
fHd8Pk4c4dpzRYv/27DNR4dqVrkYT6r5QF11Dg/qSOqY6thz+wBxylmeHFs1QfyY
B6x8pkuEXe5ouSbQmItbxSc8ohKWnia07ZNrq3/Eqpu++burUaRJcnKoM/WJ55u1
Vu/itM4MW6fzgBT7RZete76KLzP5GAiZ9pG6QFB1oKzcx68/NgzOO8T4Eb6VIQ8o
2ZEgbYBWaO0Cxhix+0Fge8XeccyrDA/advBuAhe4cmOnOnFSMd/FLt5UQYvOcIeQ
2Y7maBC9+ASJ5BKv+9uRoMfDzsVRS+CfuobdRuRDkaxmFTmX6vLiaagNWVopGKc/
TQPfnO2jBXnIWKWJVaG958RHC4bJv3vyefKbcvOUv0/lkAsNrz4xSWB5SA1kFxqe
qxb+nbAkluRj814qX1Be
=QQmG
-----END PGP SIGNATURE-----
