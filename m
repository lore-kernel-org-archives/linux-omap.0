From: Keerthy <j-keerthy@ti.com>
Subject: [RESEND PATCH 3/3] ARM: dts: am437x-sk-evm: disable DDR regulator in rtc-only/poweroff mode
Date: Thu, 11 Aug 2016 10:57:50 +0530
Message-ID: <1470893270-5042-4-git-send-email-j-keerthy@ti.com>
References: <1470893270-5042-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470893270-5042-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: devicetree@vger.kernel.org, robh+dt@kernel.org, broonie@kernel.org, lee.jones@linaro.org, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, j-keerthy@ti.com, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

Without this, the memory will remain active during poweroff consuming
extra power. Please note revision 2.1 PMIC seems to fail when DCDC3
disable is attempted, so this is not done on that PMIC revision. The
PMIC revision checks in the regulator patches make sure of this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index b5e84e6..3af92b6 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -457,6 +457,9 @@
 			regulator-state-mem {
 				regulator-on-in-suspend;
 			};
+			regulator-state-disk {
+				regulator-off-in-suspend;
+			};
 		};
 
 		dcdc4: regulator-dcdc4 {
-- 
1.9.1
