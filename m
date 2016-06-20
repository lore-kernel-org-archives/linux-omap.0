From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 9/9] ARM: dts: am437x-sk-evm: disable DDR regulator in rtc-only/poweroff mode
Date: Mon, 20 Jun 2016 14:13:38 +0530
Message-ID: <1466412218-5906-10-git-send-email-j-keerthy@ti.com>
References: <1466412218-5906-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466412218-5906-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, broonie@kernel.org, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, russ.dill@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, j-keerthy@ti.com, linux@armlinux.org.uk, Dave Gerlach <d-gerlach@ti.com>
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
index 03e3d02..1c04e27 100644
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
