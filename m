From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/4] ARM: dm8168-evm: add SATA support
Date: Tue, 14 Mar 2017 12:14:11 +0100
Message-ID: <1489490055-2318-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Neil Armstrong <narmstrong@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

This series implements support for the on-board SATA controller
on the dm8168-evm board.

The first patch adds the clock domain and hwmod entries for the
SATA module.

The second patch models the external reference clock used by SATA.

The third adds the SATA node to the SoC's device tree.

The fourth enables the SATA driver by default in omap2plus_defconfig.

Tested together with the series implementing the driver for
ahci-dm816 on a DM8168-EVM board.

v1 -> v2:
  PATCH 1/4:
    - removed the unused define from cm81xx.h
  PATCH 3/4:
    - fixed the size of the mapped register region

Bartosz Golaszewski (3):
  ARM: dts: dm8168-evm: add the external reference clock for SATA
  ARM: dts: dm8168-evm: add SATA node
  ARM: omap2plus_defconfig: enable ahci-dm816 module

Kevin Hilman (1):
  ARM: OMAP2+: dm81xx: Add clkdm and hwmod for SATA

 arch/arm/boot/dts/dm8168-evm.dts            | 10 +++++++++
 arch/arm/boot/dts/dm816x.dtsi               |  7 ++++++
 arch/arm/configs/omap2plus_defconfig        |  1 +
 arch/arm/mach-omap2/clockdomains81xx_data.c | 10 +++++++++
 arch/arm/mach-omap2/cm81xx.h                |  1 +
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c  | 34 +++++++++++++++++++++++++++++
 6 files changed, 63 insertions(+)

-- 
2.9.3
