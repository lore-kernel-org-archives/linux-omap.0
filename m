From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v4 0/5] ARM: DRA7: Add support for DRA72x devices
Date: Tue, 29 Apr 2014 16:35:08 +0530
Message-ID: <1398769513-8736-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42799 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964805AbaD2LHV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Apr 2014 07:07:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, bcousson@baylibre.com, nm@ti.com, arnd@arndb.de, s-anna@ti.com, Rajendra Nayak <rnayak@ti.com>

changes in v4:
-1- used full SoC names in compatibles eg "ti,dra742" and "ti,dra722"
-2- Created a seperate patch for replacing __initdata with __initconst

changes in v3:
Removed wildcards from compatible strings and duplicates from
.dt_compat strings as suggested by Arnd

DRA72x devices are single core Cortex A15 devices belonging to the
DRA7 family (Similar to the DRA74x devices which are dual core Cortex
A15 based)

The patches (based off 3.15-rc3) add minimal DT/kernel modifications to add
boot support on DRA722 device reusing all the kernel data for DRA742 device.

Rajendra Nayak (5):
  ARM: dts: dra7-evm: Remove the wrong and undocumented compatible
  ARM: dts: Add support for DRA72x family of devices
  ARM: OMAP2+: Replace all __initdata with __initconst for const init
  ARM: OMAP2+: Add machine entry for dra72x devices
  ARM: DRA7: Add support for soc_is_dra74x() and soc_is_dra72x()
    varients

 .../devicetree/bindings/arm/omap/omap.txt          |   12 ++++--
 arch/arm/boot/dts/Makefile                         |    3 +-
 arch/arm/boot/dts/dra7-evm.dts                     |    6 +--
 arch/arm/boot/dts/dra7.dtsi                        |   27 ------------
 arch/arm/boot/dts/dra72-evm.dts                    |   24 +++++++++++
 arch/arm/boot/dts/dra72x.dtsi                      |   25 +++++++++++
 arch/arm/boot/dts/dra74x.dtsi                      |   41 ++++++++++++++++++
 arch/arm/mach-omap2/board-generic.c                |   45 ++++++++++++++------
 arch/arm/mach-omap2/soc.h                          |    7 +++
 9 files changed, 142 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra72-evm.dts
 create mode 100644 arch/arm/boot/dts/dra72x.dtsi
 create mode 100644 arch/arm/boot/dts/dra74x.dtsi

-- 
1.7.9.5

