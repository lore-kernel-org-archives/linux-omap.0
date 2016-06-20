From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 6/9] ARM: dts: am437x-gp-evm: disable DDR regulator in rtc-only/poweroff mode
Date: Mon, 20 Jun 2016 14:13:35 +0530
Message-ID: <1466412218-5906-7-git-send-email-j-keerthy@ti.com>
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
extra power.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 7b7ccc0..a9b09b4 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -540,6 +540,9 @@
 			regulator-state-mem {
 				regulator-on-in-suspend;
 			};
+			regulator-state-disk {
+				regulator-off-in-suspend;
+			};
 		};
 
 		dcdc5: regulator-dcdc5 {
-- 
1.9.1
