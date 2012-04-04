From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP: clock, powerdomain, clockdomain, hwmod fixes
 for early v3.4-rc
Date: Wed, 4 Apr 2012 17:00:07 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204041658200.7161@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34294 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932468Ab2DDXAI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 19:00:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:

  Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending tags/omap-fixes-a-for-3.4rc

for you to fetch changes up to cf1a9298231d7719b67ad0eae6236c91888b7a32:

  Merge branches 'clock_fixes_3.4rc', 'clockdomain_fixes_3.4rc', 'hsmmc_erratum_2_1_1_128_refine_3.4rc1', 'hwmod_data_fixes_a_3.4rc', 'hwmod_fixes_3.4rc', 'powerdomain_fixes_a_3.4rc' and 'prcm_fixes_3.4rc' into fixes_for_3.4rc2 (2012-04-04 14:53:33 -0600)

These changes have been boot-tested on OMAP37xx ES1.0 Beagleboard-XM,
OMAP2420 N800, OMAP4430 ES2.0 Pandaboard, and OMAP35xx ES3.0
BeagleBoard.  System suspend and serial wakeup has been tested
on OMAP4430 ES2.0 Pandaboard, and dynamic retention idle and serial
wakeup has been tested on OMAP35xx ES3.0 BeagleBoard.

- ----------------------------------------------------------------

OMAP clock, powerdomain, clockdomain, hwmod, and PRCM fixes
intended for the early v3.4-rc series.  Also contains an
HSMMC integration refinement of an earlier hardware bug
workaround.

ARM: OMAP3: clock data: fill in some missing clockdomains
ARM: OMAP4: clock data: Force a DPLL clkdm/pwrdm ON before a relock
ARM: OMAP4: clock data: fix mult and div mask for USB_DPLL
ARM: OMAP2+: powerdomain: Wait for powerdomain transition in pwrdm_state_switch()
ARM: OMAP: hwmod: Use sysc_fields->srst_shift and get rid of hardcoded SYSC_TYPE2_SOFTRESET_MASK
ARM: OMAP4: prm: fix interrupt register offsets
ARM: OMAP AM3517/3505: clock data: change EMAC clocks aliases
ARM: OMAP2+: hwmod: Fix wrong SYSC_TYPE1_XXX_MASK bit definitions
ARM: OMAP2+: hwmod: Make omap_hwmod_softreset wait for reset status
ARM: OMAP2+: hwmod: Restore sysc after a reset
ARM: OMAP: clock: fix race in disable all clocks
ARM: OMAP4: hwmod data: Add aliases for McBSP fclk clocks
ARM: OMAP2+: omap_hwmod: Allow io_ring wakeup configuration for all modules
ARM: OMAP3xxx: clock data: fix DPLL4 CLKSEL masks
ARM: OMAP3xxx: HSMMC: avoid erratum workaround when transceiver is attached
ARM: OMAP44xx: clockdomain data: correct the emu_sys_clkdm CLKTRCTRL data

- ----------------------------------------------------------------
Ameya Palande (1):
      ARM: OMAP4: clock data: fix mult and div mask for USB_DPLL

Govindraj.R (1):
      ARM: OMAP2+: omap_hwmod: Allow io_ring wakeup configuration for all modules

Grazvydas Ignotas (2):
      ARM: OMAP3xxx: HSMMC: avoid erratum workaround when transceiver is attached
      ARM: OMAP3xxx: clock data: fix DPLL4 CLKSEL masks

Ilya Yanok (1):
      ARM: OMAP AM3517/3505: clock data: change EMAC clocks aliases

Nishanth Menon (1):
      ARM: OMAP: clock: fix race in disable all clocks

Paul Walmsley (4):
      ARM: OMAP44xx: clockdomain data: correct the emu_sys_clkdm CLKTRCTRL data
      ARM: OMAP4: hwmod data: Add aliases for McBSP fclk clocks
      ARM: OMAP3: clock data: fill in some missing clockdomains
      Merge branches 'clock_fixes_3.4rc', 'clockdomain_fixes_3.4rc', 'hsmmc_erratum_2_1_1_128_refine_3.4rc1', 'hwmod_data_fixes_a_3.4rc', 'hwmod_fixes_3.4rc', 'powerdomain_fixes_a_3.4rc' and 'prcm_fixes_3.4rc' into fixes_for_3.4rc2

Rajendra Nayak (4):
      ARM: OMAP2+: hwmod: Restore sysc after a reset
      ARM: OMAP2+: hwmod: Make omap_hwmod_softreset wait for reset status
      ARM: OMAP: hwmod: Use sysc_fields->srst_shift and get rid of hardcoded SYSC_TYPE2_SOFTRESET_MASK
      ARM: OMAP4: clock data: Force a DPLL clkdm/pwrdm ON before a relock

Santosh Shilimkar (1):
      ARM: OMAP2+: powerdomain: Wait for powerdomain transition in pwrdm_state_switch()

Tero Kristo (1):
      ARM: OMAP4: prm: fix interrupt register offsets

Vaibhav Hiremath (1):
      ARM: OMAP2+: hwmod: Fix wrong SYSC_TYPE1_XXX_MASK bit definitions

 arch/arm/mach-omap2/clock3xxx_data.c         |   18 +++--
 arch/arm/mach-omap2/clock44xx_data.c         |    5 +-
 arch/arm/mach-omap2/clockdomains44xx_data.c  |    2 +-
 arch/arm/mach-omap2/hsmmc.c                  |    7 ++
 arch/arm/mach-omap2/omap_hwmod.c             |   96 ++++++++++++--------------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   28 ++++++++
 arch/arm/mach-omap2/powerdomain.c            |    8 ++-
 arch/arm/mach-omap2/prm44xx.c                |   21 +++---
 arch/arm/plat-omap/clock.c                   |    5 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   12 ++--
 10 files changed, 121 insertions(+), 81 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPfM6EAAoJEMePsQ0LvSpLMAwQAK36qu6QVz1CwXszh+xxhK+e
+d9MlU2A5WHNBwZeP8L8uW91HO1MsD4m3/PF0G1j6ck1Ul6y9RhVihNlThAPLQ9T
qELhQwzq3PEcTrjDbR9ch9uL4tBMKmHyxTpzLj9mEhrBlwZu3zi8su5631UIlHwj
ki9OEEOrDCdFgZqjPiyYmKFuxAFo29oWlHdiGXTWPIQLNjYJTc1uApCh8l7bskx9
4cAHfOZabktrUR50OVrVH2ZCe1vbhOMKhf/dS5TXOjUcJErbwUKChBWdRdMgGpd/
812WCkXY0gQETLud72tLeGjoR9TmAbbJHFa6cSml3kfHgYHOkGMEP//sq0zsmZ4y
06RcRxczgrwOrfzNDnGffv3che6YxTS2cAyoVSXMcLQ3DgQbaTfc+j4HhcthFp7C
QnGLTzkEvytOk0uP6ZP0Z7dhU6a7Kd+oPVx/Q7cFyBL927yO/2FpefGPed22uTzx
2BvcYthz+vNZU86tFCa+KXjoy3+SOaeSmJa3rJD+Q704wG7nZUT9q/0O9lxARvNf
EBKnInGq9B9KPYh7xHZIscLmyIJsAmTdyairtPeMv9Uyw+qGR4yssW2Rs7u3EdiA
qYxkaFtLBF4VGTtUgptylHgOhEw/NB54XOurENt89fmFKGghIHLIaJTZ3V2O/k7+
gu49aqNRCPgStrD2g+We
=EaFF
-----END PGP SIGNATURE-----
