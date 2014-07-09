From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v3.16-rc4
Date: Wed, 9 Jul 2014 08:35:52 -0700
Message-ID: <20140709153552.GA28884@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:29053 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755939AbaGIPfx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2014 11:35:53 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit cd3de83f147601356395b57a8673e9c5ff1e=
59d1:

  Linux 3.16-rc4 (2014-07-06 12:37:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/=
omap-for-v3.16/fixes-rc4

for you to fetch changes up to 1d29a0722f6c38f79785c9ffb911730598de84e2=
:

  ARM: OMAP2+: Remove non working OMAP HDMI audio initialization (2014-=
07-08 01:08:44 -0700)

----------------------------------------------------------------
=46ixes for omaps for the -rc series. It's mostly fixes for clock rates=
,
restart handling and phy regulators and SATA interconnect data.

Also few build fixes related to the DSP driver in staging, and trivial
stuff like removal of broken and soon to be unused platform data init
for HDMI audio that would be good to get into the -rc series if not
too late.

----------------------------------------------------------------
Enric Balletbo i Serra (1):
      ARM: dts: Fix TI CPSW Phy mode selection on IGEP COM AQUILA.

Guido Mart=C3=ADnez (1):
      ARM: OMAP2+: Make GPMC skip disabled devices

Jyri Sarha (1):
      ARM: OMAP2+: Remove non working OMAP HDMI audio initialization

Nishanth Menon (1):
      ARM: DRA7/AM43XX: fix header definition for omap44xx_restart

Peter Ujfalusi (2):
      ARM: dts: am335x-evm: Enable the McASP FIFO for audio
      ARM: dts: am335x-evmsk: Enable the McASP FIFO for audio

Rajendra Nayak (1):
      ARM: dts: dra7xx-clocks: Fix the l3 and l4 clock rates

Roger Quadros (3):
      ARM: DRA7: hwmod: Fixup SATA hwmod
      ARM: DRA7: hwmod: Add SYSCONFIG for usb_otg_ss
      ARM: dts: dra7-evm: Make VDDA_1V8_PHY supply always on

Suman Anna (2):
      ARM: OMAP3: PRM/CM: Add back macros used by TI DSP/Bridge driver
      ARM: OMAP2+: create dsp device only on OMAP3 SoCs

Tero Kristo (1):
      ARM: OMAP2+: clock/dpll: fix _dpll_test_fint arithmetics overflow

Tony Lindgren (2):
      Merge branch 'for-v3.16-rc/clk-dt-fixes' of https://github.com/t-=
kristo/linux-pm into fixes-rc4
      Merge tag 'for-v3.16-rc/omap-fixes-b' of git://git.kernel.org/...=
/pjw/omap-pending into omap-for-v3.16/fixes

 arch/arm/boot/dts/am335x-evm.dts          |  4 ++--
 arch/arm/boot/dts/am335x-evmsk.dts        |  4 ++--
 arch/arm/boot/dts/am335x-igep0033.dtsi    |  6 ++++++
 arch/arm/boot/dts/dra7-evm.dts            |  1 +
 arch/arm/boot/dts/dra7xx-clocks.dtsi      | 10 ++++++----
 arch/arm/mach-omap2/clkt_dpll.c           |  2 +-
 arch/arm/mach-omap2/cm-regbits-34xx.h     |  3 +++
 arch/arm/mach-omap2/common.h              |  3 ++-
 arch/arm/mach-omap2/devices.c             | 28 -----------------------=
-----
 arch/arm/mach-omap2/dsp.c                 | 10 ++++++++++
 arch/arm/mach-omap2/gpmc.c                |  2 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 18 +++++++++++++-----
 arch/arm/mach-omap2/prm-regbits-34xx.h    |  6 ++++++
 13 files changed, 53 insertions(+), 44 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
