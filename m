From: Satish Patel <satish.patel@ti.com>
Subject: [RFC PATCH v1 0/2] clock and HWMOD changes for USIM module
Date: Mon, 6 Jan 2014 17:42:29 +0530
Message-ID: <1389010351-17320-1-git-send-email-satish.patel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36848 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753162AbaAFMMz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Jan 2014 07:12:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Patch set includes clock and HWMOD entries for AM43x's USIM modoule.

Note: I am in process of mainlining usim driver.

Satish Patel (2):
  ARM: dts: AM43xx-clocks: Entries added for ti-usim
  ARM: OMAP: AM43xx: HWMOD changes added for ti-usim

 arch/arm/boot/dts/am43xx-clocks.dtsi       |   34 ++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   39 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h             |    1 +
 drivers/clk/ti/clk-43xx.c                  |    4 +++
 4 files changed, 78 insertions(+), 0 deletions(-)

