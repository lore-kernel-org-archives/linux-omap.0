From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/4] OMAP IOMMU DTS nodes
Date: Thu, 13 Feb 2014 12:22:52 -0600
Message-ID: <1392315776-33197-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55328 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbaBMSXk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Feb 2014 13:23:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree@vger.kernel.org, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Hi,

This series includes patches that adds the iommu DT nodes on
OMAP3 (IVA), and OMAP4 and OMAP5 SoCs. It also includes an
updated OMAP3 ISP iommu DT node patch posted previously [1].

Posting the series separately from the driver DT adapation
changes [2]. The series adds the DTS patches in line with the
new OMAP IOMMU bindings [3] posted alongside the DT adaptation.

[1] http://marc.info/?l=linux-omap&m=138728486000628&w=2
[2] http://marc.info/?l=linux-omap&m=139231544416973&w=2
[3] http://marc.info/?l=linux-omap&m=139231545116981&w=2

Florian Vaussard (3):
  ARM: dts: OMAP3: Update ISP IOMMU node
  ARM: dts: OMAP3: Add IVA IOMMU node
  ARM: dts: OMAP4: Add IOMMU nodes

Suman Anna (1):
  ARM: dts: OMAP5: Add IOMMU nodes

 arch/arm/boot/dts/omap3.dtsi | 17 ++++++++++++++---
 arch/arm/boot/dts/omap4.dtsi | 17 +++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi | 17 +++++++++++++++++
 3 files changed, 48 insertions(+), 3 deletions(-)

-- 
1.8.5.3

