From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 07/11] Documentation: dt: OMAP: l3-noc: Add *reg* in required properties
Date: Tue, 19 Mar 2013 19:00:53 +0530
Message-ID: <1363699857-5505-8-git-send-email-santosh.shilimkar@ti.com>
References: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50282 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548Ab3CSN3l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Mar 2013 09:29:41 -0400
In-Reply-To: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

OMAP L3 driver needs reg address space for its operation and
hence its a required property.

Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 .../devicetree/bindings/arm/omap/l3-noc.txt        |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/l3-noc.txt b/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
index 6888a5e..c0105de 100644
--- a/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
+++ b/Documentation/devicetree/bindings/arm/omap/l3-noc.txt
@@ -6,6 +6,7 @@ provided by Arteris.
 Required properties:
 - compatible : Should be "ti,omap3-l3-smx" for OMAP3 family
                Should be "ti,omap4-l3-noc" for OMAP4 family
+- reg:	Contains L3 register address range for each noc domain.
 - ti,hwmods: "l3_main_1", ... One hwmod for each noc domain.
 
 Examples:
-- 
1.7.9.5

