From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 0/3] ARM: dts: EMIF and LPDDR2 device tree data for OMAP5 boards
Date: Wed, 10 Oct 2012 17:35:13 +0530
Message-ID: <1349870716-25511-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46084 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751955Ab2JJMFc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Oct 2012 08:05:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, lokeshvutla@ti.com, santosh.shilimkar@ti.com

Patch 1:
	Renaming elpida_ecb240abacn.dtsi as lpddr2_data.dtsi
Patch 2:
	Correcting size of memory defined for omap5
Patch 3:
	EMIF and LPDDR2 device tree data for OMAP5 boards

Testing:
- Boot tested on omap5-sevm board
- Built emif as a module

Lokesh Vutla (3):
  ARM: dts: Renaming elpida_ecb240abacn.dts as lpddr2_data.dtsi
  ARM: dts: Correcting size of memory defined for omap5
  ARM: dts: EMIF and LPDDR2 device tree data for OMAP5 boards

 arch/arm/boot/dts/elpida_ecb240abacn.dtsi |   67 ---------------
 arch/arm/boot/dts/lpddr2_data.dtsi        |  129 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4-panda.dts         |    2 +-
 arch/arm/boot/dts/omap4-sdp.dts           |    2 +-
 arch/arm/boot/dts/omap5-evm.dts           |   13 ++-
 arch/arm/boot/dts/omap5.dtsi              |   18 ++++
 6 files changed, 161 insertions(+), 70 deletions(-)
 delete mode 100644 arch/arm/boot/dts/elpida_ecb240abacn.dtsi
 create mode 100644 arch/arm/boot/dts/lpddr2_data.dtsi

-- 
1.7.10.4

