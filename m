From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 0/3] ARM: dts: am43x/am335x-evm: add SD card hotplug support
Date: Fri, 27 Dec 2013 21:59:03 +0530
Message-ID: <1388161746-24179-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58938 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab3L0Q3M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Dec 2013 11:29:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, tony@atomide.com, Balaji T K <balajitk@ti.com>

Balaji T K (3):
  ARM: dts: am335x-evm: add SD card hotplug support
  ARM: dts: am335x-evmsk: add SD card hotplug support
  ARM: dts: am43x-epos-evm: add SD card hotplug support

 arch/arm/boot/dts/am335x-evm.dts     |    9 +++++++++
 arch/arm/boot/dts/am335x-evmsk.dts   |    9 +++++++++
 arch/arm/boot/dts/am4372.dtsi        |    1 +
 arch/arm/boot/dts/am43x-epos-evm.dts |    9 +++++++++
 4 files changed, 28 insertions(+), 0 deletions(-)

-- 
1.7.5.4

