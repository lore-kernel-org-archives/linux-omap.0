From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: hwmod cleanup series for 3.5
Date: Thu, 19 Apr 2012 11:58:43 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204191157180.29048@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60244 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588Ab2DSR6o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 13:58:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit 1f5e6247ca99287bac87aff4971a7eee9c2b223a:

  ARM: OMAP2/3: VENC hwmods: Remove OCPIF_SWSUP_IDLE flag from VENC slave interface (2012-04-13 05:28:34 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending tags/omap-cleanup-b-for-3.5

for you to fetch changes up to 3af35fbcd088e0b675fa423a879c596384894180:

  ARM: OMAP2xxx: hwmod data: start to fix the IVA1, IVA2 and DSP (2012-04-19 04:25:08 -0600)

- ----------------------------------------------------------------
Clean up various aspects of the OMAP hwmod code, which is the IP block
control code for OMAP SoCs.  In particular, this series results in
a considerable diffstat savings by changing the way that IP block
interconnections are defined.

- ----------------------------------------------------------------

I think this one is ready for broader testing now.

This series has been boot-tested on 5912OSK, N800, 2430SDP, CM-T3517,
3530ES3 Beagle, 3730ES1.2 EVM, and 4430ES2 Panda.  System suspend
entry and exit (via UART wakeup) was tested on 3530ES3 Beagle and
4430ES2 Panda.  Dynamic idle entry and exit (via UART wakeup) was
tested on 3530ES3 Beagle.  Logs of this testing are available at

    http://www.pwsan.com/omap/bootlogs/20120418/hwmod_cleanup_a_3.5__3af35fbcd088e0b675fa423a879c596384894180/


- - Paul

- ---

object size (delta in bytes from hwmod_fixes_b_3.4rc (1f5e6247ca99287bac87aff4971a7eee9c2b223a)):
 text 	 data 	  bss 	total 	kernel
    0 	    0 	    0 	    0 	5912osk_testconfig/vmlinux
+1208 	-3864 	    0 	-2656 	n800_multi_omap2xxx/vmlinux
+1204 	 +744 	    0 	+1948 	n800_testconfig/vmlinux
    0 	    0 	    0 	    0 	omap1_defconfig/vmlinux
- -2848 	-3672 	    0 	-6520 	omap2_4_testconfig/vmlinux
- -2796 	-2592 	 -256 	-5644 	omap2plus_defconfig/vmlinux
- -6956 	-2624 	 -192 	-9772 	omap2plus_no_pm/vmlinux
- -2864 	+1216 	 -256 	-1904 	omap3_4_testconfig/vmlinux
+1188 	 +992 	 -256 	+1924 	omap3_testconfig/vmlinux
+1276 	 +200 	    0 	+1476 	omap4_testconfig/vmlinux


Paul Walmsley (29):
      ARM: OMAP2+: hwmod: control all hardreset lines attached to a hwmod
      ARM: OMAP4: hwmod data: remove pseudo-hwmods associated with hardreset lines
      ARM: OMAP2+: hwmod: revise the IP block reset process
      ARM: OMAP2+: hwmod: reorganize and document the initialization process
      ARM: OMAP2+: hwmod: reorganize and document the reset and configuration process
      ARM: OMAP2+: hwmod: revise hardreset behavior
      ARM: OMAP2+: hwmod: provide a function to return the address space of the MPU RT
      ARM: OMAP2+: hwmod: add omap_hwmod_get_resource_byname()
      ARM: OMAP2+: timer: use a proper interface to get hwmod data
      ARM: OMAP2/3: hwmod data: update old names
      ARM: OMAP3: hwmod data: fix interfaces for the MMC hwmods
      ARM: OMAP3: hwmod data: add DSS->L3 interconnect for 3430ES1
      ARM: OMAP3: hwmod data: GPTIMER12 is attached to a separate interconnect
      ARM: OMAP4: hwmod data: remove bandgap hwmod
      ARM: OMAP4: hwmod data: add OCP_USER_DSP; mark omap44xx_dsp__iva appropriately
      ARM: OMAP4: hwmod data: uncomment some "excluded" hwmods
      ARM: OMAP2+: hwmod: extend OCP_* register offsets from 16 to 32 bits
      ARM: OMAP2+: hwmod: add _find_mpu_rt_port()
      ARM: OMAP2+: hwmod: add function to iterate over struct omap_hwmod_ocp_if
      ARM: OMAP2+: hwmod: consolidate finding the MPU port index and storing it
      ARM: OMAP2+: hwmod: add support for link registration
      ARM: OMAP2+: hwmod data: convert to link registration
      ARM: OMAP: hwmod: remove code support for direct hwmod registration
      ARM: OMAP2+: hwmod data: remove forward declarations, reorganize
      ARM: OMAP2xxx: hwmod data: share common hwmods between OMAP2420 and OMAP2430
      ARM: OMAP2xxx: hwmod data: share common interface data
      ARM: OMAP3: hwmod data: fix IVA interface clock
      ARM: OMAP3: hwmod data: add IVA hard reset lines, main clock, clockdomain
      ARM: OMAP2xxx: hwmod data: start to fix the IVA1, IVA2 and DSP

 arch/arm/mach-omap2/omap_hwmod.c                        | 1143 +++++++--
 arch/arm/mach-omap2/omap_hwmod_2420_data.c              | 1562 ++----------
 arch/arm/mach-omap2/omap_hwmod_2430_data.c              | 2315 +++++------------
 arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c |  266 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c      |  562 ++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c              | 4999 ++++++++++++++++--------------------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c              | 5087 +++++++++++++++----------------------
 arch/arm/mach-omap2/omap_hwmod_common_data.h            |   71 +-
 arch/arm/mach-omap2/timer.c                             |   15 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h            |   40 +-
 10 files changed, 6953 insertions(+), 9107 deletions(-)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPkFGaAAoJEMePsQ0LvSpLWboQAIfthvCdemzP/Y3OChHJqcks
q9dEYuRZzR0bk1t7GpoTK9CQ9WAB9MMuM17buplboVliDddX+Ls0dOcIzEmYvSHz
J0XUimPH8tUfyj3c14hpbHKNuTxlOfEcVg0F78K8ySRkVsFip79Zumdb9/x4EM9F
7JVEObnOcHTPslNZeDB9XJiZrT6IDyEo6gH/0qKto/FFMGXkYZm2yP2k2CQzJCV2
hmCzMYvTMukMA8xcGa443ANRhreOS1GKV3s+s9l9UYgekjeC3GruYPskoole7waK
/WbkzFjw7JxqUDmUC62utWgeyFv3rVChnki2nzrHpZpxGBLm4J2XQVKU/2576cld
cYiqcJd+wlFJ8MlXEC7zjzChLe3uOzxOELcVyq6J426+Lq1DFrv4iV+aAt5ezoY2
12d40sA52cwMDKO5ujYzXOheewx/ANLK4Nw1Vonn2NS5AeaqtDKlD6XVMUmr+PyB
KqE/11ajgczYXEBVq6cTspBh2n3NI2M5PZEoISfhgy7LKeN2aW+16E9dqSVaUicb
dSwoJlTd1e0TigXsXHLTsY9Mn628RPahbt7A7QbEHMA15HcKxG6JBNa3GFeZlgx/
RZ245c3nm66dSd+hmMtuQ/CwAAtIF3atLbXxOQNq4XCwgbm5BZaQrgGcbqhHM8LD
CJAJ58UOZ8vJeLyF5vMY
=ZE+T
-----END PGP SIGNATURE-----
