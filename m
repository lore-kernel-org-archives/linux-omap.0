From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/14] OMAP: PRCM/powerdomain/clockdomain patches for 2.6.38,
	part one
Date: Mon, 06 Dec 2010 18:24:58 -0700
Message-ID: <20101207012242.3708.45451.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41194 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225Ab0LGBn4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 20:43:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch series, intended for 2.6.38:

- includes Rajendra's powerdomain changes to add OMAP4 support;

- allocates static powerdomain and clockdomain data in C files
  rather than header files (long overdue);

- begins the process of cleaning up mach-omap2/prcm.c;

- splits the OMAP4 PRCM header files into per-hwmod or per-PRCM partition
  files;

- renames the OMAP4 PRCM *_MOD macros to *_INST so the names actually have
  some meaning in regards to the hardware;

- moves the OMAP2/3-specific PRCM functions into OMAP2/3-specific files, in
  preparation for creating OMAP4-specific versions;

- moves the CM context save/restore file to CM-specific code, and
  removes the PRM context save/restore code - which should save a few
  microseconds in the off-mode save/restore path.

The series applies on top of v2.6.37-rc4.  It is available via git from
git://git.pwsan.com/linux-2.6 in the branch 'pwrdm_prcm_a_2.6.38'.

Kevin, I'd appreciate review and acks, if appropriate, on the patches
that touch code that you maintain.  Rajendra, Santosh, I've made some
minor changes to your patches; if you have the chance you might want
to take a look and comment if necessary.

Boot-tested on N800, OMAP35xx Beagle, and OMAP4430ES2 Panda.

A followup series that builds on this one will be sent tomorrow.


- Paul

---

pwrdm_prcm_a_2.6.38
   text	   data	    bss	    dec	    hex	filename
5707592	 473984	5608864	11790440	 b3e868	vmlinux.orig
5709988	 473952	5608800	11792740	 b3f164	vmlinux.patched

Paul Walmsley (8):
      OMAP2+: powerdomains: move powerdomain static data to .c files
      OMAP2+: clockdomains: move clockdomain static data to .c files
      OMAP3: control/PRCM: add omap3_ctrl_write_boot_mode()
      OMAP3: control/PRCM: move CONTROL_PADCONF_SYS_NIRQ save/restore to SCM code
      OMAP4: PRCM: reorganize existing OMAP4 PRCM header files
      OMAP4: PRCM: rename _MOD macros to _INST
      OMAP2/3: PRCM: split OMAP2/3-specific PRCM code into OMAP2/3-specific files
      OMAP3: PRM/CM: separate CM context save/restore; remove PRM context save/restore

Rajendra Nayak (5):
      OMAP: powerdomain: Move static allocations from powerdomains.h to a .c file
      OMAP: powerdomain: Infrastructure to put arch specific code
      OMAP: powerdomain: Arch specific funcs for state control
      OMAP: powerdomain: Arch specific funcs for logic control
      OMAP: powerdomain: Arch specific funcs for mem control

Santosh Shilimkar (1):
      OMAP4: powerdomain: Add pwrdm_clear_all_prev_pwrst


 arch/arm/mach-omap2/Makefile                     |   44 +
 arch/arm/mach-omap2/clkt2xxx_apll.c              |    2 
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c          |    2 
 arch/arm/mach-omap2/clkt2xxx_osc.c               |    2 
 arch/arm/mach-omap2/clkt2xxx_sys.c               |    2 
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c     |    2 
 arch/arm/mach-omap2/clkt_dpll.c                  |    1 
 arch/arm/mach-omap2/clock.c                      |    4 
 arch/arm/mach-omap2/clock2420_data.c             |    4 
 arch/arm/mach-omap2/clock2430.c                  |    2 
 arch/arm/mach-omap2/clock2430_data.c             |    4 
 arch/arm/mach-omap2/clock34xx.c                  |    2 
 arch/arm/mach-omap2/clock3517.c                  |    2 
 arch/arm/mach-omap2/clock3xxx.c                  |    4 
 arch/arm/mach-omap2/clock3xxx_data.c             |    4 
 arch/arm/mach-omap2/clock44xx_data.c             |   10 
 arch/arm/mach-omap2/clockdomain.c                |    5 
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |   67 --
 arch/arm/mach-omap2/clockdomains44xx_data.c      |   46 +
 arch/arm/mach-omap2/cm-regbits-24xx.h            |    2 
 arch/arm/mach-omap2/cm-regbits-34xx.h            |    2 
 arch/arm/mach-omap2/cm-regbits-44xx.h            |    3 
 arch/arm/mach-omap2/cm.c                         |   68 --
 arch/arm/mach-omap2/cm.h                         |  137 ----
 arch/arm/mach-omap2/cm1_44xx.h                   |  251 +++++++
 arch/arm/mach-omap2/cm2_44xx.h                   |  648 +++++++------------
 arch/arm/mach-omap2/cm2xxx_3xxx.c                |  393 ++++++++++++
 arch/arm/mach-omap2/cm2xxx_3xxx.h                |   70 +-
 arch/arm/mach-omap2/cm44xx.h                     |  668 --------------------
 arch/arm/mach-omap2/cm4xxx.c                     |    2 
 arch/arm/mach-omap2/control.c                    |   40 +
 arch/arm/mach-omap2/control.h                    |    1 
 arch/arm/mach-omap2/dpll3xxx.c                   |    4 
 arch/arm/mach-omap2/dsp.c                        |    9 
 arch/arm/mach-omap2/io.c                         |   22 -
 arch/arm/mach-omap2/omap_hwmod.c                 |    6 
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c       |    4 
 arch/arm/mach-omap2/pm-debug.c                   |    4 
 arch/arm/mach-omap2/pm24xx.c                     |    4 
 arch/arm/mach-omap2/pm34xx.c                     |    8 
 arch/arm/mach-omap2/powerdomain-common.c         |  111 +++
 arch/arm/mach-omap2/powerdomain.c                |  400 +++---------
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c       |  232 +++++++
 arch/arm/mach-omap2/powerdomain44xx.c            |  177 +++++
 arch/arm/mach-omap2/powerdomains.h               |  151 ----
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |   81 ++
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.h |   22 +
 arch/arm/mach-omap2/powerdomains2xxx_data.c      |   47 +
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |   47 +
 arch/arm/mach-omap2/powerdomains44xx_data.c      |   70 +-
 arch/arm/mach-omap2/prcm-common.h                |   85 ---
 arch/arm/mach-omap2/prcm.c                       |  481 --------------
 arch/arm/mach-omap2/prcm_mpu44xx.h               |   91 +++
 arch/arm/mach-omap2/prm-regbits-24xx.h           |    2 
 arch/arm/mach-omap2/prm-regbits-34xx.h           |    8 
 arch/arm/mach-omap2/prm-regbits-44xx.h           |    2 
 arch/arm/mach-omap2/prm.h                        |  369 -----------
 arch/arm/mach-omap2/prm2xxx_3xxx.c               |   52 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.h               |  116 +--
 arch/arm/mach-omap2/prm44xx.c                    |    2 
 arch/arm/mach-omap2/prm44xx.h                    |  743 +++++++++++-----------
 arch/arm/mach-omap2/scrm44xx.h                   |   32 +
 arch/arm/mach-omap2/sdrc.c                       |    2 
 arch/arm/mach-omap2/sdrc2xxx.c                   |    2 
 arch/arm/mach-omap2/serial.c                     |    4 
 arch/arm/mach-omap2/sleep34xx.S                  |    4 
 arch/arm/mach-omap2/sram242x.S                   |    4 
 arch/arm/mach-omap2/sram243x.S                   |    4 
 arch/arm/mach-omap2/sram34xx.S                   |    2 
 arch/arm/plat-omap/include/plat/clockdomain.h    |   11 
 arch/arm/plat-omap/include/plat/common.h         |    2 
 arch/arm/plat-omap/include/plat/powerdomain.h    |   57 ++
 arch/arm/plat-omap/include/plat/prcm.h           |   10 
 arch/arm/plat-omap/mcbsp.c                       |    2 
 arch/arm/plat-omap/sram.c                        |    5 
 75 files changed, 2663 insertions(+), 3322 deletions(-)
 rename arch/arm/mach-omap2/{clockdomains.h => clockdomains2xxx_3xxx_data.c} (95%)
 rename arch/arm/mach-omap2/{clockdomains44xx.h => clockdomains44xx_data.c} (90%)
 delete mode 100644 arch/arm/mach-omap2/cm.c
 create mode 100644 arch/arm/mach-omap2/cm1_44xx.h
 copy arch/arm/mach-omap2/{cm44xx.h => cm2_44xx.h} (53%)
 create mode 100644 arch/arm/mach-omap2/cm2xxx_3xxx.c
 copy arch/arm/mach-omap2/{cm.h => cm2xxx_3xxx.h} (68%)
 create mode 100644 arch/arm/mach-omap2/powerdomain-common.c
 create mode 100644 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
 create mode 100644 arch/arm/mach-omap2/powerdomain44xx.c
 create mode 100644 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
 create mode 100644 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.h
 rename arch/arm/mach-omap2/{powerdomains24xx.h => powerdomains2xxx_data.c} (76%)
 rename arch/arm/mach-omap2/{powerdomains34xx.h => powerdomains3xxx_data.c} (89%)
 rename arch/arm/mach-omap2/{powerdomains44xx.h => powerdomains44xx_data.c} (85%)
 create mode 100644 arch/arm/mach-omap2/prcm_mpu44xx.h
 copy arch/arm/mach-omap2/{prm.h => prm2xxx_3xxx.h} (82%)
 create mode 100644 arch/arm/mach-omap2/scrm44xx.h

