From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: [PATCH 0/4] ARM/dts: Update OMAP5 with address space and interrupts
Date: Mon, 22 Oct 2012 12:22:04 +0200
Message-ID: <1350901328-3525-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38409 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753149Ab2JVKWR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Oct 2012 06:22:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>

Since kernel 3.7 the DTS data are not overwriten by hwmod data we can add the address space
and interrupt line description inside dtsi file for OMAP5. This serie is updating the
current OMAP5 IP with missing entry.

It has been tested on OMAP5 with 3.7-audio-display feature tree.
- MMC is probing and functional
- TWL6041 probing (GPIO/I2C)
- booting (UART)

Sebastien Guiriec (4):
  ARM/dts: omap5: Update GPIO with address space and interrupt
  ARM/dts: omap5: Update I2C with address space and interrupts
  ARM/dts: omap5: Update UART with address space and interrupts
  ARM/dts: omap5: Update MMC with address space and interrupts

 arch/arm/boot/dts/omap5.dtsi |   56 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 4 deletions(-)

-- 
1.7.10.4

