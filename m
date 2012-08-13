From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/2] ARM: OMAP5: Enable local timer support
Date: Mon, 13 Aug 2012 16:37:23 +0530
Message-ID: <1344856045-15134-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32825 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601Ab2HMLHd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Aug 2012 07:07:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.orig, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Below are the couple of patches which enables the architected cpu local timer
support for OMAP5 devices.

Santosh Shilimkar (2):
  ARM: OMAP: Add initialisation for the real-time counter.
  ARM: OMAP5: Enable arch timer support

 arch/arm/boot/dts/omap5.dtsi |    6 +++
 arch/arm/mach-omap2/Kconfig  |    5 +++
 arch/arm/mach-omap2/timer.c  |   96 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 106 insertions(+), 1 deletion(-)

-- 
1.7.9.5

