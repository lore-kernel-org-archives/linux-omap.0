From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 0/2] OMAP4+: Get rid of internal SRAM handling
Date: Tue, 27 Aug 2013 15:41:43 +0530
Message-ID: <1377598305-15539-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57199 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab3H0KMV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Aug 2013 06:12:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com, Rajendra Nayak <rnayak@ti.com>

Make all OMAP DT only platforms (am33xx, am43xx, omap4 and omap5)
use drivers/misc/sram.c driver instead of the omap internal
implementation for SRAM handling.

Rajendra Nayak (2):
  ARM: AM335x: Get rid of unused sram init function
  ARM: OMAP4+: Move SRAM data to DT

 arch/arm/boot/dts/am33xx.dtsi        |    5 +++++
 arch/arm/boot/dts/am4372.dtsi        |    5 +++++
 arch/arm/boot/dts/omap4.dtsi         |    5 +++++
 arch/arm/boot/dts/omap5.dtsi         |    5 +++++
 arch/arm/configs/omap2plus_defconfig |    1 +
 arch/arm/mach-omap2/sram.c           |   39 +---------------------------------
 arch/arm/mach-omap2/sram.h           |    1 -
 7 files changed, 22 insertions(+), 39 deletions(-)

-- 
1.7.9.5

