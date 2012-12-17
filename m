From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 0/2] ARM: dts: Add PMU support for OMAP2+
Date: Mon, 17 Dec 2012 11:49:06 -0600
Message-ID: <1355766548-5702-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49787 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917Ab2LQRtS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Dec 2012 12:49:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Jon Hunter <jon-hunter@ti.com>

Add device-tree PMU support for OMAP2, OMAP3 and OMAP4460. OMAP4430
is not included because PMU is not currently supported on this device
due to absence of a cross-trigger interface driver.

Tested with PERF on OMAP3430 Beagle Board and OMAP4460 Panda Board.
Boot tested only on OMAP2420 H4.

Jon Hunter (2):
  ARM: OMAP2+: Prepare for device-tree PMU support
  ARM: dts: OMAP2+: Add PMU nodes

 arch/arm/boot/dts/omap2.dtsi         |    5 +++++
 arch/arm/boot/dts/omap3.dtsi         |    6 ++++++
 arch/arm/boot/dts/omap4-panda-es.dts |    2 ++
 arch/arm/boot/dts/omap4460.dtsi      |   18 ++++++++++++++++++
 arch/arm/mach-omap2/pmu.c            |   14 +++++++++++---
 5 files changed, 42 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap4460.dtsi

-- 
1.7.10.4

