From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH] ARM: dts: doc: Document missing compatible property for omap-sham driver
Date: Fri, 8 Nov 2013 11:07:36 +0530
Message-ID: <1383889056-17336-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: santosh.shilimkar@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, rob@landley.net, bcousson@baylibre.com, linux-doc@vger.kernel.org, joelf@ti.com, lokeshvutla@ti.com
List-Id: linux-omap@vger.kernel.org

A new compatible property "ti,omap5-sham" is added to the omap-sham driver
recently to support SHA/MD5 for OMAP5,DRA7 and AM43XX. Documenting the
same.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 .../devicetree/bindings/crypto/omap-sham.txt       |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/omap-sham.txt b/Documentation/devicetree/bindings/crypto/omap-sham.txt
index f839acd..ad91155 100644
--- a/Documentation/devicetree/bindings/crypto/omap-sham.txt
+++ b/Documentation/devicetree/bindings/crypto/omap-sham.txt
@@ -6,7 +6,7 @@ Required properties:
   SHAM versions:
   - "ti,omap2-sham" for OMAP2 & OMAP3.
   - "ti,omap4-sham" for OMAP4 and AM33XX.
-  Note that these two versions are incompatible.
+  - "ti,omap5-sham" for OMAP5, DRA7 and AM43XX.
 - ti,hwmods: Name of the hwmod associated with the SHAM module
 - reg : Offset and length of the register set for the module
 - interrupts : the interrupt-specifier for the SHAM module.
-- 
1.7.9.5

