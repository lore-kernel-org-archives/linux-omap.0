From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 0/5] AM437x: HDQ/1wire protocol
Date: Wed, 16 Apr 2014 18:02:07 +0530
Message-ID: <1397651532-31456-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37693 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714AbaDPMcy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Apr 2014 08:32:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: zbr@ioremap.net, tony@atomide.com, michael.opdenacker@free-electrons.com, wsa@the-dreams.de, paul@pwsan.com, bcousson@baylibre.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Sourav Poddar <sourav.poddar@ti.com>

This series adds support for HDQ/1w protocol driver for
am43x epos evm where it can be used for measuring the
temperature of a slave device connected to a particular header.

Tested the patch series on AM437x, hdq master and slave devices are
getting registered and interrupts are getting triggered for break and tx
conditions. 

Sourav Poddar (5):
  drivers: w1: omap_hdq: cleanup and bug fixes.
  w1: omap_hdq: Add compatible property for omap hdq driver.
  arm: mach-omap2: selective device build from the platform code.
  arm: dts: am4372: Add hdq device tree data.
  arm: hwmod: am437x: Add hwmod data for hdq1w.

 .../devicetree/bindings/hdq1w/omap_hdq.txt         |   20 +++++
 arch/arm/boot/dts/am4372.dtsi                      |   10 +++
 arch/arm/boot/dts/am43x-epos-evm.dts               |   12 +++
 arch/arm/mach-omap2/hdq1w.c                        |    2 +
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |   36 ++++++++
 arch/arm/mach-omap2/prcm43xx.h                     |    1 +
 drivers/w1/masters/omap_hdq.c                      |   93 ++++++++++++++++----
 7 files changed, 157 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hdq1w/omap_hdq.txt

-- 
1.7.9.5

