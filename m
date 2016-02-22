From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2] ARM: OMAP: X15: Add support for eeprom
Date: Mon, 22 Feb 2016 10:51:06 -0600
Message-ID: <1456159868-32416-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org


X15 and BB family of boards use AT24 compatible eeproms

Enable support for the same.

Nishanth Menon (2):
  ARM: dts: am57xx-beagle-x15: Add eeprom information
  ARM: omap2plus_defconfig: Enable AT24 eeprom

 arch/arm/boot/dts/am57xx-beagle-x15.dts | 5 +++++
 arch/arm/configs/omap2plus_defconfig    | 1 +
 2 files changed, 6 insertions(+)

-- 
2.7.0
