From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 1/5] dt-bindings: arm: cpu: Add TI AM335x and AM437x enable method
Date: Thu, 12 Dec 2019 21:07:51 -0600
Message-ID: <20191213030755.16096-2-d-gerlach@ti.com>
References: <20191213030755.16096-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191213030755.16096-1-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

Add enable-method binding for "ti,am3352" and "ti,am4372".

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
CC: Rob Herring <robh+dt@kernel.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index c23c24ff7575..428b6b55b5da 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -201,6 +201,8 @@ properties:
               - rockchip,rk3066-smp
               - socionext,milbeaut-m10v-smp
               - ste,dbx500-smp
+              - ti,am3352
+              - ti,am4372
 
   cpu-release-addr:
     $ref: '/schemas/types.yaml#/definitions/uint64'
-- 
2.20.1
