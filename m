From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 1/9] mfd: Add DT bindings for tps65917 PMIC
Date: Wed, 18 Jun 2014 15:28:52 +0530
Message-ID: <1403085540-20014-2-git-send-email-j-keerthy@ti.com>
References: <1403085540-20014-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403085540-20014-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

Add DT bindings for tps65917 PMIC.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 Documentation/devicetree/bindings/mfd/palmas.txt |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/palmas.txt b/Documentation/devicetree/bindings/mfd/palmas.txt
index e5f0f83..eda8989 100644
--- a/Documentation/devicetree/bindings/mfd/palmas.txt
+++ b/Documentation/devicetree/bindings/mfd/palmas.txt
@@ -6,6 +6,7 @@ twl6037 (palmas)
 tps65913 (palmas)
 tps65914 (palmas)
 tps659038
+tps65917
 
 Required properties:
 - compatible : Should be from the list
@@ -16,6 +17,7 @@ Required properties:
   ti,tps65914
   ti,tps80036
   ti,tps659038
+  ti,tps65917
 and also the generic series names
   ti,palmas
 - interrupt-controller : palmas has its own internal IRQs
-- 
1.7.9.5
