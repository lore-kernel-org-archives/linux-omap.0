From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/22] OMAP PRCM/clock/powerdomain/hwmod: remaining patches
	for 2.6.35
Date: Tue, 18 May 2010 20:18:36 -0600
Message-ID: <20100519021800.19716.8938.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39767 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361Ab0ESCU6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 22:20:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

here are some remaining patches intended for 2.6.35, in case
anyone has comments.  The series consists almost entirely of fixes:

- hwmod infrastructure fixes from Beno=C3=AEt,

- OMAP4 PRCM macro fixes from Beno=C3=AEt,

- OMAP4 clock/powerdomain fixes from Rajendra,

- and some miscellaneous patches.


- Paul


size:
   text    data     bss     dec     hex filename
3130596  195296   93248 3419140  342c04 vmlinux.omap3beagle.old
3130600  195296   93248 3419144  342c08 vmlinux.omap3beagle

---

Benoit Cousson (13):
      OMAP4: hwmod: Replace module & device offsets by absolute clkctrl=
 address
      OMAP: CM: Move MAX_MODULE_READY_TIME to cm.h
      OMAP4: hwmod & CM: Implement the omap4_cm_wait_module_ready funct=
ion
      OMAP4: hwmod: Replace OCPIF_HAS_IDLEST by HWMOD_NO_IDLEST
      OMAP: hwmod: Fix wrong pointer iteration in oh->slaves
      OMAP: hwmod: Remove IS_ERR check with omap_clk_get_by_name return=
 value
      OMAP: hwmod: Replace WARN by pr_warning if clock lookup failed
      OMAP: hwmod: Do not exit the iteration if one clock init failed
      OMAP: hwmod: Rename hwmod name for the MPU
      OMAP: hwmod: Replace WARN by pr_warning for clockdomain check
      OMAP4: CM: Remove non-functional registers in ES1.0
      OMAP4: PRM: Remove MPU internal code name and apply PRCM naming c=
onvention
      OMAP4: PRCM: Remove duplicate definition of base addresses

Laine Walker-Avina (1):
      OMAP3 clock: add support for setting the divider for sys_clkout2 =
using clk_set_rate

Paul Walmsley (2):
      OMAP powerdomain, hwmod, omap_device: add some credits
      OMAP2 clock: fix recursive spinlock attempt when CONFIG_CPU_FREQ=3D=
y

Rajendra Nayak (6):
      OMAP4: PRCM: Add offset defines for all PRM registers
      OMAP4: PRCM: Add offset defines for all CM registers
      OMAP4 clock: Support clk_set_parent
      OMAP: timers: Fix clock source names for OMAP4
      OMAP4 powerdomain: Fix pwrsts flags for ALWAYS ON domains
      OMAP4 powerdomain: Support LOWPOWERSTATECHANGE for powerdomains


 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c  |   17 -
 arch/arm/mach-omap2/clock3xxx_data.c          |    2=20
 arch/arm/mach-omap2/clockdomains44xx.h        |    4=20
 arch/arm/mach-omap2/cm.c                      |    3=20
 arch/arm/mach-omap2/cm.h                      |   11 +
 arch/arm/mach-omap2/cm44xx.h                  |  301 +++++++++++++++++=
--
 arch/arm/mach-omap2/cm4xxx.c                  |   54 ++-
 arch/arm/mach-omap2/omap_hwmod.c              |  121 ++++----
 arch/arm/mach-omap2/omap_hwmod_2420_data.c    |    2=20
 arch/arm/mach-omap2/omap_hwmod_2430_data.c    |    2=20
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |    2=20
 arch/arm/mach-omap2/powerdomain.c             |   30 ++
 arch/arm/mach-omap2/powerdomains44xx.h        |   23 +
 arch/arm/mach-omap2/prcm-common.h             |   18 -
 arch/arm/mach-omap2/prm.h                     |    4=20
 arch/arm/mach-omap2/prm44xx.h                 |  389 +++++++++++++++++=
++++++--
 arch/arm/plat-omap/clock.c                    |    5=20
 arch/arm/plat-omap/dmtimer.c                  |    4=20
 arch/arm/plat-omap/include/plat/omap44xx.h    |    1=20
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |   16 +
 arch/arm/plat-omap/include/plat/powerdomain.h |    7=20
 arch/arm/plat-omap/omap_device.c              |    4=20
 22 files changed, 814 insertions(+), 206 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
