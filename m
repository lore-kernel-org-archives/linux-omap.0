From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 0/4] ARM: DRA7: Add support for DRA72x devices
Date: Wed, 23 Apr 2014 14:32:51 +0530
Message-ID: <1398243775-4145-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41932 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbaDWJEn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 05:04:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, bcousson@baylibre.com, nm@ti.com, Rajendra Nayak <rnayak@ti.com>

DRA72x devices are single core Cortex A15 devices belonging to the
DRA7 family (Similar to the DRA74x devices which are dual core Cortex
A15 based)

The patches (based off 3.15-rc2) add minimal DT/kernel modifications to add
boot support for DRA72x devices reusing all the kernel data for DRA74x devices.

Rajendra Nayak (4):
  ARM: dts: dra7-evm: Remove the wrong and undocumented compatible
  ARM: dts: Add support for DRA72x family of devices
  ARM: OMAP2+: Add machine entry for dra72x devices
  ARM: DRA7: Add support for soc_is_dra74x() and soc_is_dra72x()
    varients

 .../devicetree/bindings/arm/omap/omap.txt          |   12 +++--
 arch/arm/boot/dts/Makefile                         |    3 +-
 arch/arm/boot/dts/dra7-evm.dts                     |    6 +--
 arch/arm/boot/dts/dra7.dtsi                        |   27 ------------
 arch/arm/boot/dts/dra72-evm.dts                    |   24 ++++++++++
 arch/arm/boot/dts/dra72x.dtsi                      |   25 +++++++++++
 arch/arm/boot/dts/dra74x.dtsi                      |   41 +++++++++++++++++
 arch/arm/mach-omap2/board-generic.c                |   46 ++++++++++++++------
 arch/arm/mach-omap2/soc.h                          |    7 +++
 9 files changed, 144 insertions(+), 47 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra72-evm.dts
 create mode 100644 arch/arm/boot/dts/dra72x.dtsi
 create mode 100644 arch/arm/boot/dts/dra74x.dtsi

-- 
1.7.9.5

