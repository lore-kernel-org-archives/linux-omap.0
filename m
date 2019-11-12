From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch v2 0/3] ARM: dts: am43x-vpfe/ov2659.patch
Date: Tue, 12 Nov 2019 08:29:26 -0600
Message-ID: <20191112142929.23058-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch series adds the missing camera endpoint (ov2659) as well as
the required source clocks nodes for the sensor.

On the am437x-sk-evm the camera sensor is sourced from clkout1 but that
clock nodes/tree was removed as it was unsed at the time, we are
re-adding the needed clock nodes here.

Changes since v1:
- Fix clock name to make it generic
- Add non-standard clock node naming to commit message as per Tony's
  comment
- Rename all clock nodes to use '-' instead of '_'

Benoit Parrot (2):
  ARM: dts: am437x-sk-evm: Add VPFE and OV2659 entries
  ARM: dts: am43x-epos-evm: Add VPFE and OV2659 entries

Tero Kristo (1):
  ARM: dts: am43xx: add support for clkout1 clock

 arch/arm/boot/dts/am437x-sk-evm.dts  | 27 +++++++++++++-
 arch/arm/boot/dts/am43x-epos-evm.dts | 23 +++++++++++-
 arch/arm/boot/dts/am43xx-clocks.dtsi | 54 ++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 2 deletions(-)

-- 
2.17.1
