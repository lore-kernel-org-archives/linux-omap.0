From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 0/4] Add AM33XX regulators device tree data
Date: Fri, 20 Jul 2012 12:16:25 +0530
Message-ID: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56742 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306Ab2GTGqx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jul 2012 02:46:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, AnilKumar Ch <anilkumar@ti.com>

This patch series add AM33XX regulators (tps65910/tps65217) device
tree data to am335x-evm and am335x-bone dts files. These patches
are based on Tony L "devel-dt" tree and tested on AM335x EVM and
Bone devices.

Resending patch 1 & 2 to group all the regulator DT data files.

AnilKumar Ch (4):
  ARM: OMAP2+: AM33XX: Add tps65910 device tree data
  ARM: OMAP2+: AM33XX: Add tps65217 device tree data
  arm/dts: Add tps65910 regulator DT data to am335x-evm.dts
  arm/dts: Add tps65217 regulator DT data to am335x-bone.dts

 arch/arm/boot/dts/am335x-bone.dts |   10 +++
 arch/arm/boot/dts/am335x-evm.dts  |   10 +++
 arch/arm/boot/dts/tps65217.dtsi   |   84 +++++++++++++++++++++++++
 arch/arm/boot/dts/tps65910.dtsi   |  123 +++++++++++++++++++++++++++++++++++++
 4 files changed, 227 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/tps65217.dtsi
 create mode 100644 arch/arm/boot/dts/tps65910.dtsi

