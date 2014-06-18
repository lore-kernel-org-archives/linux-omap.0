From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 2/9] regulator: palmas: Add tps65917 compatible string
Date: Wed, 18 Jun 2014 15:28:53 +0530
Message-ID: <1403085540-20014-3-git-send-email-j-keerthy@ti.com>
References: <1403085540-20014-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403085540-20014-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

Add tps65917 compatible string.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 .../devicetree/bindings/regulator/palmas-pmic.txt  |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/regulator/palmas-pmic.txt b/Documentation/devicetree/bindings/regulator/palmas-pmic.txt
index 42e6b6b..725393c 100644
--- a/Documentation/devicetree/bindings/regulator/palmas-pmic.txt
+++ b/Documentation/devicetree/bindings/regulator/palmas-pmic.txt
@@ -7,6 +7,7 @@ Required properties:
   ti,twl6037-pmic
   ti,tps65913-pmic
   ti,tps65914-pmic
+  ti,tps65917-pmic
 and also the generic series names
   ti,palmas-pmic
 - interrupt-parent : The parent interrupt controller which is palmas.
-- 
1.7.9.5
