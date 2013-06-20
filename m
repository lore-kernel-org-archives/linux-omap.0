From: J Keerthy <j-keerthy@ti.com>
Subject: [PATCH 1/4] MFD: Add TPS659038 documentation under Palmas
Date: Thu, 20 Jun 2013 16:34:49 +0530
Message-ID: <1371726289-10042-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, grant.likely@secretlab.ca
Cc: broonie@kernel.org, j-keerthy@ti.com, ldewangan@nvidia.com, sameo@linux.intel.com, swarren@nvidia.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, gg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

Add TPS659038 documentation under Palmas.

Signed-off-by: J Keerthy <j-keerthy@ti.com>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>
---
 Documentation/devicetree/bindings/mfd/palmas.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/palmas.txt b/Documentation/devicetree/bindings/mfd/palmas.txt
index 7bcd59c..89cb773 100644
--- a/Documentation/devicetree/bindings/mfd/palmas.txt
+++ b/Documentation/devicetree/bindings/mfd/palmas.txt
@@ -5,6 +5,7 @@ twl6035 (palmas)
 twl6037 (palmas)
 tps65913 (palmas)
 tps65914 (palmas)
+tps659038
 
 Required properties:
 - compatible : Should be from the list
@@ -14,6 +15,7 @@ Required properties:
   ti,tps65913
   ti,tps65914
   ti,tps80036
+  ti,tps659038
 and also the generic series names
   ti,palmas
 - interrupt-controller : palmas has its own internal IRQs
-- 
1.7.5.4

