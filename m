From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 3/3] ARM: dts: dra7: Add scm_conf@1c04 node
Date: Tue, 4 Aug 2015 12:10:14 +0300
Message-ID: <55C08176.4000107@ti.com>
References: <1437992850-6008-1-git-send-email-rogerq@ti.com> <1437992850-6008-4-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437992850-6008-4-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com, tony@atomide.com
Cc: nm@ti.com, nsekhar@ti.com, balbi@ti.com, grygorii.strashko@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

This region contains CTRL_CORE_SMA_SW2..9 registers which
are not specific to any domain and can be reasonably
accessed via syscon driver.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---

v3: removed #address/size-cells.

 arch/arm/boot/dts/dra7.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 913032b..2cab476 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -149,6 +149,11 @@
 					pinctrl-single,register-width = <32>;
 					pinctrl-single,function-mask = <0x3fffffff>;
 				};
+
+				scm_conf1: scm_conf@1c04 {
+					compatible = "syscon";
+					reg = <0x1c04 0x0020>;
+				};
 			};
 
 			cm_core_aon: cm_core_aon@5000 {
-- 
2.1.4
