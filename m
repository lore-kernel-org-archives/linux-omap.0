From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 11/15] staging: omap-thermal: update DT entry documentation
Date: Tue, 26 Feb 2013 18:53:34 -0400
Message-ID: <1361919218-9788-12-git-send-email-eduardo.valentin@ti.com>
References: <1361919218-9788-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361919218-9788-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

Simple update on documentation file for DT. This patch
also adds an example for OMAP4430 and 0MAP4470, and also updated
OMAP4460's example.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap_bandgap.txt |   27 ++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap_bandgap.txt b/drivers/staging/omap-thermal/omap_bandgap.txt
index 6008a14..e30dc1c 100644
--- a/drivers/staging/omap-thermal/omap_bandgap.txt
+++ b/drivers/staging/omap-thermal/omap_bandgap.txt
@@ -10,21 +10,42 @@ to the silicon temperature.
 
 Required properties:
 - compatible : Should be:
-  - "ti,omap4460-control-bandgap" : for OMAP4460 bandgap
-  - "ti,omap5430-control-bandgap" : for OMAP5430 bandgap
+  - "ti,omap4430-bandgap" : for OMAP4430 bandgap
+  - "ti,omap4460-bandgap" : for OMAP4460 bandgap
+  - "ti,omap4470-bandgap" : for OMAP4470 bandgap
+  - "ti,omap5430-bandgap" : for OMAP5430 bandgap
 - interrupts : this entry should indicate which interrupt line
 the talert signal is routed to;
 Specific:
 - ti,tshut-gpio : this entry should be used to inform which GPIO
 line the tshut signal is routed to;
+- regs : this entry must also be specified and it is specific
+to each bandgap version, because the mapping may change from
+soc to soc, apart of depending on available features.
 
 Example:
+OMAP4430:
+bandgap {
+	reg = <0x4a002260 0x4 0x4a00232C 0x4>;
+	compatible = "ti,omap4430-bandgap";
+};
+
+OMAP4460:
+bandgap {
+	reg = <0x4a002260 0x4
+		0x4a00232C 0x4
+		0x4a002378 0x18>;
+	compatible = "ti,omap4460-bandgap";
+	interrupts = <0 126 4>; /* talert */
+	ti,tshut-gpio = <86>;
+};
 
+OMAP4470:
 bandgap {
 	reg = <0x4a002260 0x4
 		0x4a00232C 0x4
 		0x4a002378 0x18>;
-	compatible = "ti,omap4460-control-bandgap";
+	compatible = "ti,omap4470-bandgap";
 	interrupts = <0 126 4>; /* talert */
 	ti,tshut-gpio = <86>;
 };
-- 
1.7.7.1.488.ge8e1c
