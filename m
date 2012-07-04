From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: miscellaneous PRCM & hwmod patches for 3.6
Date: Wed, 4 Jul 2012 09:43:19 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207040935070.6760@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46997 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459Ab2GDPnU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 11:43:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:

  Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-f-for-3.6

for you to fetch changes up to 8cb8de5d87b75f2ecaa1189079764340ea366c0e:

  Merge branches 'hwmod_am335x_support_3.6', 'clkdm_pwrdm_devel_a_3.6' and 'misc_devel_3.6' into omap_devel_f_3.6 (2012-07-04 06:05:51 -0600)

- ----------------------------------------------------------------

Miscellaneous OMAP clock, hwmod, clockdomain, and powerdomain patches
for 3.6.  Mostly small infrastructure improvements, and preparation
for OMAP5 and AM33xx code.

- ----------------------------------------------------------------

Test logs are available here:

http://www.pwsan.com/omap/testlogs/omap_devel_f_3.6/20120704085233/

On 3530ES3 Beagle, wakeup from dynamic retention idle is broken; can
be worked around by reverting commit
91930652a23de0873a157aa1d9962cb878d64451 ("OMAP2+: UART: Add mechanism
to probe uart pins and configure rx wakeup") -- but needs a better
fix.  Evidently this is being gated by lack of availability of a
BeagleBoard for testing.  On 3530ES3 Beagle and 37xx EVM, CORE
powerdomain won't enter low power states; this seems to be due to the
32k sync timer problem; a revised fix has been posted.  On 4430ES2
Panda, large UART transmit buffers are being corrupted when dynamic
idle is enabled; no fix yet for this.  All of these problems are
present with the stock v3.5-rc5 kernel.

object size (delta in bytes from test_v3.5-rc5 (6887a4131da3adaab011613776d865f4bcfb5678)):
  text 	  data 	   bss 	 total 	kernel
  +680 	  +192 	     0 	  +872 	2430_testconfig/vmlinux
     0 	     0 	     0 	     0 	5912osk_testconfig/vmlinux
  +760 	  +704 	     0 	 +1464 	am33xx_testconfig/vmlinux
  +712 	  +160 	     0 	  +872 	n800_b_testconfig/vmlinux
  +744 	  +224 	     0 	  +968 	n800_multi_omap2xxx/vmlinux
  +712 	  +160 	     0 	  +872 	n800_testconfig/vmlinux
     0 	     0 	     0 	     0 	omap1510_defconfig/vmlinux
     0 	     0 	     0 	     0 	omap1_defconfig/vmlinux
  +712 	  +640 	     0 	 +1352 	omap2_4_testconfig/vmlinux
  +752 	  +960 	     0 	 +1712 	omap2plus_defconfig/vmlinux
  +752 	  +896 	     0 	 +1648 	omap2plus_no_pm/vmlinux
  +688 	  +704 	     0 	 +1392 	omap3_4_testconfig/vmlinux
 +4784 	  +256 	     0 	 +5040 	omap3_testconfig/vmlinux
 +4784 	  +448 	     0 	 +5232 	omap4_testconfig/vmlinux



Jon Hunter (2):
      ARM: OMAP4: clockdomain/CM code: Update supported transition modes
      ARM: OMAP2+: powerdomain code: Fix Wake-up power domain power status

Kishon Vijay Abraham I (1):
      ARM: OMAP2+: hwmod code: add support to set dmadisable in hwmod framework

Paul Walmsley (1):
      Merge branches 'hwmod_am335x_support_3.6', 'clkdm_pwrdm_devel_a_3.6' and 'misc_devel_3.6' into omap_devel_f_3.6

R Sricharan (1):
      ARM: OMAP2+: PRM/CM: Move the stubbed prm and cm functions to prcm.c file and make them __weak

Sakari Ailus (1):
      ARM: OMAP3: control: add definition for CONTROL_CAMERA_PHY_CTRL

Tarun Kanti DebBarma (1):
      ARM: OMAP2+: hwmod: add omap_hwmod_get_main_clk() API

Vaibhav Hiremath (2):
      ARM: OMAP2+: hwmod: Add new sysc_type3 into omap_hwmod required for am33xx
      ARM: OMAP3/4: omap_hwmod: Add rstst_offs field to struct omap_hwmod_omap4_prcm

Vikram Pandita (1):
      ARM: OMAP3+: dpll: optimize noncore dpll locking logic

 arch/arm/mach-omap2/clockdomain44xx.c        |   10 +++-
 arch/arm/mach-omap2/cminst44xx.c             |   14 -----
 arch/arm/mach-omap2/cminst44xx.h             |   25 ---------
 arch/arm/mach-omap2/control.h                |    1 +
 arch/arm/mach-omap2/dpll3xxx.c               |   12 +++-
 arch/arm/mach-omap2/omap_hwmod.c             |   76 ++++++++++++++++++++++++--
 arch/arm/mach-omap2/omap_hwmod_common_data.c |   10 ++++
 arch/arm/mach-omap2/powerdomain.c            |    6 +-
 arch/arm/mach-omap2/prcm.c                   |   23 ++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h           |   65 ----------------------
 arch/arm/mach-omap2/prm_common.c             |   62 +++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   19 +++++++
 12 files changed, 209 insertions(+), 114 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9GKMAAoJEMePsQ0LvSpLu0QP/0tWcwek93htyYJ4N2vg64rq
uazy+wXY+SDOIDBazkY5OgWlgrpT8CSy37Qg5hfNfmXO78aTwOVI38JFG664i6TB
ld+s85VXOrWpP5qO0GyZ9THy8ZBv57HrBz4wisVS2KM+CoVsIyczmLCFgSM9LKR4
3muQi2Z0Zcwjpk6AozHvGihkX2gvzd+urRFqCeo5ksWroMohTyl4E8fhtfAxFKd0
rXkmrrPGKpaqwuX6xMrlx5Tx3jzDweXzKRQFjrNCs7LwupCKSDx1fFTL5ZnMCApI
XeAupUrk4R0Wdg0TMpkGoIoLUGiqhDdn6jQ/Stn2Ge1DNrHUxiXqe+x4vqVxJcqx
Ez8QKqvZ34btcQ2nS9m0y8Kau2yeUGcc2PJAtb+WzA1xu1l+gR2oKToSY8dy0dPW
HCKnSaxk1OsqfmHSMeK+kS12O33jdouzOdhna9nO1BdB61gNK6qNQE828jJ8/5W+
0LmZwrEOl/a1J7bre5cUMyA1KmwdHDDfT1EQ9E5BgvgxxevKQwTOYQ9pbSXcsgsS
+vOqeixKAozlgPofjcV93J863gi7xrZykRcCiiOZrd1LxT6gXichkazP0U2HeA1O
CuxcVgxAQStsPDElwYMj/VLakvn5DQJjxuThPyRLxWIiHkWkUZ68ECPhwVnhrP5W
jEWUTaW839I/DwSvA1eh
=mnq9
-----END PGP SIGNATURE-----
