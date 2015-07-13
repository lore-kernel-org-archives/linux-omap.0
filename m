From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v4 3/3] ARM: dts: AM4372: Add the wkupm3 rproc node
Date: Mon, 13 Jul 2015 12:34:55 -0500
Message-ID: <1436808895-21206-4-git-send-email-d-gerlach@ti.com>
References: <1436808895-21206-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1436808895-21206-1-git-send-email-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

Add the Wakeup M3 remote processor device node for
the AM4372 SoC. The WkupM3 remote processor is used
to implement and achieve low-power functionality on
the AM33xx & AM43xx SoCs.

This node is added as a child of the recently added
l4_wkup node to reflect its presence within the SoC.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index ade28c79..6f6f393 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -83,6 +83,15 @@
 			#size-cells = <1>;
 			ranges = <0 0x44c00000 0x287000>;
 
+			wkup_m3: wkup_m3@100000 {
+				compatible = "ti,am4372-wkup-m3";
+				reg = <0x100000 0x4000>,
+				      <0x180000	0x2000>;
+				reg-names = "umem", "dmem";
+				ti,hwmods = "wkup_m3";
+				ti,pm-firmware = "am335x-pm-firmware.elf";
+			};
+
 			prcm: prcm@1f0000 {
 				compatible = "ti,am4-prcm";
 				reg = <0x1f0000 0x11000>;
-- 
2.4.5
