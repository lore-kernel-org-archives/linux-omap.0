From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/4] arm: am43xx: add PMU support
Date: Fri, 23 Jan 2015 17:11:40 -0600
Message-ID: <1422054704-14915-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49875 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754995AbbAWXMT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Jan 2015 18:12:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org, Felipe Balbi <balbi@ti.com>

Hi all,

with these patches we can use perf with AM43xx devices
and get actual statistics.

Full boot logs: http://hastebin.com/yoxaxurohu

Felipe Balbi (4):
  arm: omap: hwmod: 43xx: add DebugSS hwmod data
  arm: dts: am4372: add missing debugss clocks
  clk: ti: 43xx: add debugss clocks to DT_CLK() table
  arm: dts: am4372: add pmu DT data

 arch/arm/boot/dts/am4372.dtsi              |  8 +++++
 arch/arm/boot/dts/am43xx-clocks.dtsi       | 51 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 40 +++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h             |  1 +
 drivers/clk/ti/clk-43xx.c                  |  6 ++++
 5 files changed, 106 insertions(+)

-- 
2.3.0-rc1

