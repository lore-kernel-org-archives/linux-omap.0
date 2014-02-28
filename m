From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv2 0/4] OMAP IOMMU DTS nodes
Date: Fri, 28 Feb 2014 14:49:50 -0600
Message-ID: <1393620594-14957-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41831 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596AbaB1Uu0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Feb 2014 15:50:26 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree@vger.kernel.org, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Hi,

This is an updated series of the OMAP IOMMU DTS nodes
for OMAP3, OMAP4 and OMAP5. The main change is the removal
of the dma-window property from all the IOMMU DT nodes, as
per the discussion on the bindings posted previously [1].

This series goes along with the v3 version of the driver
DT adaptation series [2]. The DTS patches are updated
as per the new bindings document patch [3].

[1] http://marc.info/?l=linux-omap&m=139345649217892&w=2
[2] http://marc.info/?l=linux-omap&m=139362022805667&w=2
[3] http://marc.info/?l=linux-omap&m=139362026905683&w=2

v1:
DTS patches as per v2 series of driver DT adaptation
series.
http://marc.info/?l=linux-omap&m=139231582217147&w=2

Florian Vaussard (3):
  ARM: dts: OMAP3: Update ISP IOMMU node
  ARM: dts: OMAP3: Add IVA IOMMU node
  ARM: dts: OMAP4: Add IOMMU nodes

Suman Anna (1):
  ARM: dts: OMAP5: Add IOMMU nodes

 arch/arm/boot/dts/omap3.dtsi | 15 ++++++++++++---
 arch/arm/boot/dts/omap4.dtsi | 15 +++++++++++++++
 arch/arm/boot/dts/omap5.dtsi | 15 +++++++++++++++
 3 files changed, 42 insertions(+), 3 deletions(-)

-- 
1.9.0

