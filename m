From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 2/7] arm: omap: devicetree: add new properties for OMAP devices
Date: Tue, 9 Dec 2014 16:27:47 -0600
Message-ID: <1418164072-19087-3-git-send-email-balbi@ti.com>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47195 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753223AbaLIW2V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Dec 2014 17:28:21 -0500
In-Reply-To: <1418164072-19087-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Felipe Balbi <balbi@ti.com>

In order to get rid of some more hwmod data, we
introduce a few extra properties to OMAP DT
data in order to be able to pass the needed
information through DT.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 Documentation/devicetree/bindings/arm/omap/omap.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 4f6a82c..c6b9515 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -23,6 +23,13 @@ Optional properties:
   during suspend.
 - ti,no-reset-on-init: When present, the module should not be reset at init
 - ti,no-idle-on-init: When present, the module should not be idled at init
+- ti,rev_offs: IP block revision register offset (defaults to 0)
+- ti,sysc_offs: OCP_SYSCONFIG register offset (defaults to 0)
+- ti,syss_offs: OCP_SYSSTATUS register offset (defaults to 0)
+- ti,srst_udelay: Delay needed after a softreset in usecs (defaults to 0)
+- ti,idlemodes: Slave and Master supported idling modes
+- ti,clockact: default value of clock activity bits (defaults to 0)
+- ti,sysc_type: OCP_SYSCONFIG type. Valid types are 1, 2 or 3 (defaults to 1)
 
 Example:
 
-- 
2.2.0

