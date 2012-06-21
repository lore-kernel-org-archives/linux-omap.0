From: Paul Walmsley <paul@pwsan.com>
Subject: (unknown)
Date: Thu, 21 Jun 2012 12:26:54 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206211225360.10198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35119 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756322Ab2FUS0z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jun 2012 14:26:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Omar Ramirez Luna <omar.luna@linaro.org>, peter.ujfalusi@ti.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit 485802a6c524e62b5924849dd727ddbb1497cc71:

  Linux 3.5-rc3 (2012-06-16 17:25:17 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-cleanup-a-for-3.6

for you to fetch changes up to 07b3a13957aa250ff5b5409b8ed756b113544112:

  Merge branches 'clock_cleanup_misc_3.6', 'control_clean_dspbridge_writes_cleanup_3.6', 'hwmod_soc_conditional_cleanup_3.6', 'mcbsp_clock_aliases_cleanup_3.6' and 'remove_clkdm_requirement_from_hwmod_3.6' into omap_cleanup_a_3.6 (2012-06-20 20:11:36 -0600)

- ----------------------------------------------------------------

Some OMAP hwmod, clock, and System Control Module cleanup patches for 3.6.

- ----------------------------------------------------------------

Testing logs are available at

http://www.pwsan.com/omap/bootlogs/20120620/omap_cleanup_a_3.6__07b3a13957aa250ff5b5409b8ed756b113544112/

The summary is that 5912OSK NFS root and N800 MMC don't boot to
userspace; this broke between v3.4-rc2 and v3.5-rc3.  3517 boards are
still broken with NFS root and also several stack tracebacks during
boot.  In terms of PM, core isn't entering idle on OMAP3 or OMAP4.
These problems all exist in v3.5-rc3 - they aren't caused by this
series.

object size (delta in bytes from v3.5-rc3 (485802a6c524e62b5924849dd727ddbb1497cc71)):
  text 	  data 	   bss 	 total 	kernel
     0 	     0 	     0 	     0 	5912osk_testconfig/vmlinux
 +4636 	  -400 	     0 	 +4236 	am33xx_testconfig/vmlinux
  +440 	  -408 	   +32 	   +64 	n800_multi_omap2xxx/vmlinux
  +416 	  -192 	   +32 	  +256 	n800_testconfig/vmlinux
     0 	     0 	     0 	     0 	omap1510_defconfig/vmlinux
     0 	     0 	     0 	     0 	omap1_defconfig/vmlinux
  +732 	  -456 	     0 	  +276 	omap2_4_testconfig/vmlinux
 +4776 	  -624 	     0 	 +4152 	omap2plus_defconfig/vmlinux
  +684 	  -664 	     0 	   +20 	omap2plus_no_pm/vmlinux
  +616 	  -336 	   +64 	  +344 	omap3_4_testconfig/vmlinux
  +360 	  -384 	     0 	   -24 	omap3_testconfig/vmlinux
  +580 	  -120 	   +64 	  +524 	omap4_testconfig/vmlinux


Kevin Hilman (7):
      ARM: OMAP4: hwmod: rename _enable_module to _omap4_enable_module()
      ARM: OMAP2+: hwmod: use init-time function ptrs for enable/disable module
      ARM: OMAP4: hwmod: drop extra cpu_is check from _wait_target_disable()
      ARM: OMAP2+: hwmod: use init-time function pointer for wait_target_ready
      ARM: OMAP2+: hwmod: use init-time function pointer for hardreset
      ARM: OMAP2+: hwmod: use init-time function pointer for _init_clkdm
      ARM: OMAP2+: CLEANUP: Remove ARCH_OMAPx ifdef from struct dpll_data

Omar Ramirez Luna (2):
      ARM: OMAP2+: control: new APIs to configure boot address and mode
      ARM: OMAP: dsp: interface to control module functions

Paul Walmsley (2):
      ARM: OMAP2+: hwmod: remove prm_clkdm, cm_clkdm; allow hwmods to have no clockdomain
      Merge branches 'clock_cleanup_misc_3.6', 'control_clean_dspbridge_writes_cleanup_3.6', 'hwmod_soc_conditional_cleanup_3.6', 'mcbsp_clock_aliases_cleanup_3.6' and 'remove_clkdm_requirement_from_hwmod_3.6' into omap_cleanup_a_3.6

Peter Ujfalusi (3):
      ARM: OMAP2: Move McBSP fck clock alias to hwmod data for OMAP2420
      ARM: OMAP2: Move McBSP fck clock alias to hwmod data for OMAP2430
      ARM: OMAP3: Move McBSP fck clock alias to hwmod data

 arch/arm/mach-omap2/Makefile                       |    1 -
 arch/arm/mach-omap2/clock2420_data.c               |    4 -
 arch/arm/mach-omap2/clock2430_data.c               |   10 -
 arch/arm/mach-omap2/clock3xxx_data.c               |   10 -
 arch/arm/mach-omap2/clockdomain.h                  |    2 -
 arch/arm/mach-omap2/clockdomains2420_data.c        |    2 -
 arch/arm/mach-omap2/clockdomains2430_data.c        |    2 -
 arch/arm/mach-omap2/clockdomains3xxx_data.c        |    2 -
 arch/arm/mach-omap2/clockdomains44xx_data.c        |    2 -
 arch/arm/mach-omap2/clockdomains_common_data.c     |   24 --
 arch/arm/mach-omap2/control.c                      |   43 ++
 arch/arm/mach-omap2/control.h                      |    2 +
 arch/arm/mach-omap2/dsp.c                          |    4 +
 .../include/mach/ctrl_module_core_44xx.h           |    1 +
 arch/arm/mach-omap2/omap_hwmod.c                   |  427 ++++++++++++++------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   10 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   16 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   23 ++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    4 +-
 arch/arm/plat-omap/include/plat/clock.h            |    2 -
 arch/arm/plat-omap/include/plat/dsp.h              |    3 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h       |    2 +
 22 files changed, 409 insertions(+), 187 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clockdomains_common_data.c
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP42cFAAoJEMePsQ0LvSpLmMAP/06LRRSFBPklr2hDmFPKBfBD
guF3rAN5zimEyknXp1RhoHJjcH0YCkUdQgD24w51yVwVB9zVW0M6G9hVi91cJj9X
1StRIwTbtb08yPdOlpywEXzHpjXz3AauCMRRxYJHi0FjajwHNKWWv+A/iolM0p8P
5o5ZY+D3AzJqfX/+A0FK2YKn2Z7X9kxg8uTTukhXhe38ldZJ2pHqA4ND2n2F+GnD
DUGqpnYu+QLTmw0x0NbpTNDarnmUEa/tH1NRny5Fh+ujYxH5NPTVvxHTW8tbm5bl
qkleWJaDc+D2pCnD3ch3cUlLgIfTZbo4KUg+Y4uv4QLrLx/QTu6TpyJaP+ZJw3sY
amakgmv3vzYzHMOf/0gxIe6xDZl6YFVXiOdJex4kQ5qodXRgmh82gYUrEKLLHuWn
+EKwIBM8xV5zYzA60vZ05ul7QqeNfwD5D6dd5As96QweVJFMGiIDWINGfxOtI/mH
ygXD6sSZvYhqGk2EVb+hje971urmI4aIrolt/xB4anOATiehaJuwhLjtp+5ZO7tL
5w3bybiUqKh+CN0DlpL/Srw0jaVp/pjZE8+4tzw/Mvm5T8wSVZL2ysJfmX4WffKl
k7RI46jiiQfFLJbSF5pgXUEm00/Ut3g7otp2F+iZLuAplJwoojl7cgezTSAgRc9E
Rhv07SsL5AAZ5OyCOdeQ
=rQK5
-----END PGP SIGNATURE-----
