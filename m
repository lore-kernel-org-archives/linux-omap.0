From: Andy Gross <andy.gross@ti.com>
Subject: [PATCH v2 0/2] ARM: dts: OMAP4+: Add dmm device bindings
Date: Wed, 10 Apr 2013 15:50:41 -0500
Message-ID: <1365627043-11846-1-git-send-email-andy.gross@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58400 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934626Ab3DJUvF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Apr 2013 16:51:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>, Andy Gross <andy.gross@ti.com>

This patch set adds devicetree bindings for the Dynamic Memory Manager (DMM)
inside the OMAP4 and OMAP5 devices, creates the platform_device using the DT
entry if present or falls back to using the hwmod entry if not, and adds
documentation for the minimal binding.

v2: Handle both DT and non DT device creation

Andy Gross (2):
  ARM: dts: OMAP4+: Add DMM bindings
  ARM: OMAP2+: Enable DT usage during dmm create

 Documentation/devicetree/bindings/arm/omap/dmm.txt |   16 ++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |    7 +++++++
 arch/arm/boot/dts/omap5.dtsi                       |    7 +++++++
 arch/arm/mach-omap2/drm.c                          |   17 +++++++++++------
 4 files changed, 41 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/dmm.txt

-- 
1.7.5.4

