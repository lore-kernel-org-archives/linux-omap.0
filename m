From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 0/3] Add device tree support to AM33XX SoC
Date: Fri, 22 Jun 2012 15:10:46 +0530
Message-ID: <1340358050-29560-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55469 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761786Ab2FVJk7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 05:40:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, AnilKumar Ch <anilkumar@ti.com>

This patch series add device tree support for AM33XX SoC family.

Initialy Hiremath Vaibhav submitted a patch for AM33XX devices
based on omap3 family. Details at
http://marc.info/?t=132687107200002&r=1&w=2

AM33XX family is varied from omap3 family in these aspects
like memory maps, peripheral base addresses and configuration
parameters. In some cases we have to use a mix of omap3 and
omap4 parameters. So a seperate am33xx.dtsi file is created
for all the devices comes under am33xx family and revert of
above patch is required.

Two sepearte device tree source files are created (am335x-evm.dts
and am335x-bone.dts) to add support for AM335X EVM and BeagleBone
boards.

Linux booting is tested on AM335X-EVM and BeagleBone boards.

AnilKumar Ch (4):
  Revert "arm/dts: Add support for TI AM335x EVM board"
  arm/dts: Add initial DT support for AM33XX SoC family
  arm/dts: Add support for AM335x EVM
  arm/dts: Add support for AM335x BeagleBone

 .../devicetree/bindings/arm/omap/omap.txt          |    3 +
 arch/arm/boot/dts/am335x-bone.dts                  |   20 +++
 arch/arm/boot/dts/am335x-evm.dts                   |   25 +--
 arch/arm/boot/dts/am33xx.dtsi                      |  189 ++++++++++++++++++++
 4 files changed, 215 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-bone.dts
 create mode 100644 arch/arm/boot/dts/am33xx.dtsi

-- 
1.7.9.5

