From: Andy Gross <andy.gross@ti.com>
Subject: [PATCH 0/2] ARM: dts: OMAP4+: Add dmm device bindings
Date: Tue, 19 Mar 2013 23:43:42 -0500
Message-ID: <1363754624-5209-1-git-send-email-andy.gross@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41442 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752303Ab3CTEoP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Mar 2013 00:44:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <bicousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, devicetree-discuss@lists.ozlabs.org, Nishanth Menon <nm@ti.com>, Andy Gross <andy.gross@ti.com>

This patch set adds devicetree bindings for the Dynamic Memory Manager (DMM)
inside the OMAP4 and OMAP5 devices, removes generation of the device node via
the hwmod, and adds documentation for the minimal binding.

This patch series is based on device tree patches queued up for OMAP 3.10.

Patches are located at:
https://github.com/andygross/omap_dmm_tiler/commits/for-benoit

Andy Gross (2):
  ARM: dts: OMAP4+: Add DMM bindings
  ARM: OMAP2+: Remove dmm device creation

 Documentation/devicetree/bindings/arm/omap/dmm.txt |   16 ++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |    7 +++++++
 arch/arm/boot/dts/omap5.dtsi                       |    7 +++++++
 arch/arm/mach-omap2/drm.c                          |   12 ------------
 4 files changed, 30 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/dmm.txt

-- 
1.7.5.4

