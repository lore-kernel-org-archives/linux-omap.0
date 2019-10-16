From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch 0/3] ARM: dts: am43x-vpfe/ov2659.patch
Date: Wed, 16 Oct 2019 13:49:51 -0500
Message-ID: <20191016184954.14048-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch series adds the missing camera endpoint (ov2659) as well as
the required source clocks nodes for the sensor.

On the am437x-sk-evm the camera sensor is sourced from clkout1 but that
clock nodes/tree was removed as it was unsed at the time, we are
re-adding the needed clock nodes here.

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
