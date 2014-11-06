From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Subject: [PATCH 00/11] ARM: dts: igep00x0: Add support for new hardware revisions.
Date: Thu,  6 Nov 2014 13:01:40 +0100
Message-ID: <1415275311-6857-1-git-send-email-eballetbo@iseebcn.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:56351 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbaKFMIQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2014 07:08:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: javier@dowhile0.org, devicetree@vger.kernel.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>

Hi,

This series is based on omap-for-v3.19/dt from tmlind repository and adds
device tree support for two new hardware revisions of IGEPv2 and IGEP COM
MODULE.

Please could these patches be queued for 3.19 considering that these are not
fixes, might be nice to get them merged for 3.19 series.

Best regards,

Enric Balletbo i Serra (11):
  ARM: dts: omap3-igep00x0: Fix UART2 pins that aren't common.
  ARM: dts: omap3-igep00x0: Move NAND configuration to a common place.
  ARM: dts: omap3-igep0030: Specify IGEP COM revision in device tree.
  ARM: dts: omap3-igep0020: Specify IGEPv2 revision in device tree.
  ARM: dts: omap3-igep00x0: Move outside common file the on board Wifi module.
  ARM: dts: omap3-igep0030-common: Introduce igep0030 common dtsi file.
  ARM: dts: omap3-igep0030-rev-g: Support IGEP COM MODULE Rev. G
  ARM: dts: omap3-igep0020-common: Introduce igep0020 common dtsi file.
  ARM: dts: omap3-igep0020-rev-f: Support IGEPv2 Rev. F
  ARM: dts: omap3-igep00x0: Remove i2c2 node.
  ARM: OAMP2+: igep00x0: Add pdata-quirks for the btwilink device.

 arch/arm/boot/dts/Makefile                   |   2 +
 arch/arm/boot/dts/omap3-igep.dtsi            | 103 +++++-----
 arch/arm/boot/dts/omap3-igep0020-common.dtsi | 246 +++++++++++++++++++++++
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts   |  46 +++++
 arch/arm/boot/dts/omap3-igep0020.dts         | 285 ++++-----------------------
 arch/arm/boot/dts/omap3-igep0030-common.dtsi |  60 ++++++
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts   |  68 +++++++
 arch/arm/boot/dts/omap3-igep0030.dts         | 124 +++++-------
 arch/arm/mach-omap2/pdata-quirks.c           |  36 +++-
 9 files changed, 585 insertions(+), 385 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-igep0020-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-igep0020-rev-f.dts
 create mode 100644 arch/arm/boot/dts/omap3-igep0030-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-igep0030-rev-g.dts

-- 
1.9.1

