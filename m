From: Dan Murphy <dmurphy@ti.com>
Subject: [RFC 07/11] ARM: TI: Describe the ti reset DT entries
Date: Tue, 29 Apr 2014 15:19:46 -0500
Message-ID: <1398802790-29287-8-git-send-email-dmurphy@ti.com>
References: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44070 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758342AbaD2UUa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Apr 2014 16:20:30 -0400
In-Reply-To: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, devicetree@vger.kernel.org
Cc: t-kristo@ti.com, s-anna@ti.com, p.zabel@pengutronix.de, Dan Murphy <dmurphy@ti.com>

Describe the TI reset DT entries for TI SoC's.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/reset/ti,reset.txt         |   34 ++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/ti,reset.txt

diff --git a/Documentation/devicetree/bindings/reset/ti,reset.txt b/Documentation/devicetree/bindings/reset/ti,reset.txt
new file mode 100644
index 0000000..19f5603
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/ti,reset.txt
@@ -0,0 +1,34 @@
+Texas Instruments Reset Controller
+======================================
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Specifying the reset entries for the IP module
+==============================================
+Parent module:
+This is the module node that contains the reset registers and bits.
+
+example:
+			prcm_resets: resets {
+				compatible = "ti,dra7-resets";
+				#reset-cells = <1>;
+			};
+
+Required Properties:
+compatible - Should be "ti-<Soc>-resets
+
+DRA7xx:
+Compatible - ti,dra7-resets
+Reset indices - include/dt-bindings/reset/ti,dra7-resets.h
+
+OMAP5:
+Compatible - ti,omap5-resets
+Reset indices - include/dt-bindings/reset/ti,omap5-resets.h
+
+AM33xx:
+Compatible - ti-am335x-resets
+Reset indices - include/dt-bindings/reset/ti,am33xx-resets.h
+
+AM43xx:
+Compatible - ti,am4372-resets
+Reset indices - include/dt-bindings/reset/ti,am437x-resets.h
-- 
1.7.9.5

