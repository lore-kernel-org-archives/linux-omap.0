From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 2/2] ARM: omap/dts: update the documentation
Date: Fri, 31 Aug 2012 18:06:12 +0200
Message-ID: <1346429172-5902-3-git-send-email-florian.vaussard@epfl.ch>
References: <1346429172-5902-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.218]:40458 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754392Ab2HaQG5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 12:06:57 -0400
In-Reply-To: <1346429172-5902-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Benoit Cousson <b-cousson@ti.com>, Steve Sakoman <steve@sakoman.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Philippe Retornaz <philippe.retornaz@epfl.ch>, linux-arm-kernel@lists.infradead.org

Add the Tobi/Overo board to the list of supported platforms.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 .../devicetree/bindings/arm/omap/omap.txt          |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index ccdd0e5..d0051a7 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -36,6 +36,9 @@ Boards:
 - OMAP3 BeagleBoard : Low cost community board
   compatible = "ti,omap3-beagle", "ti,omap3"
 
+- OMAP3 Tobi with Overo : Commercial expansion board with daughter board
+  compatible = "ti,omap3-tobi", "ti,omap3-overo", "ti,omap3"
+
 - OMAP4 SDP : Software Developement Board
   compatible = "ti,omap4-sdp", "ti,omap4430"
 
-- 
1.7.5.4

