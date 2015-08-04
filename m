From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 01/10] ARM: dts: dra7: Add dt node for PCIe registers in
 sysctrl space
Date: Tue, 4 Aug 2015 21:00:24 +0530
Message-ID: <1438702233-8027-2-git-send-email-kishon@ti.com>
References: <1438702233-8027-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1438702233-8027-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rogerq@ti.com, tony@atomide.com, t-kristo@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nsekhar@ti.com, linux@arm.linux.org.uk, bcousson@baylibre.com, balbi@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Add new device tree node for the control module register space where
PCIe registers are present.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index aa6abfc..33c5655 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -154,6 +154,11 @@
 					compatible = "syscon";
 					reg = <0x1c04 0x0020>;
 				};
+
+				scm_conf2: scm_conf@1c24 {
+					compatible = "syscon";
+					reg = <0x1c24 0x0024>;
+				};
 			};
 
 			cm_core_aon: cm_core_aon@5000 {
-- 
1.7.9.5
