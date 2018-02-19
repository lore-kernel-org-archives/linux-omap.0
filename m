From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 1/9] ARM: dts: am33xx: Reserve pm code and data regions in
 ocmcram sram node
Date: Sun, 18 Feb 2018 21:34:57 -0600
Message-ID: <1519011305-17822-2-git-send-email-d-gerlach@ti.com>
References: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Keerthy J <j-keerthy@ti.com>, Johan Hovold <johan@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add a 'pm_sram_code' reserved region to the ocmcram node to be exposed
by the mmio-sram driver as a pool but also mark it protect-exec so that
it can run code copied to it using sram_exec_copy.

Add another 'pm_sram_data' reserved region to the ocmcram node to act as
the data space for any code running from the 'pm_sram_code' region that
is exposed as a regular pool.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 628c77b0b386..a9bbf68db077 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -905,6 +905,21 @@
 		ocmcram: ocmcram@40300000 {
 			compatible = "mmio-sram";
 			reg = <0x40300000 0x10000>; /* 64k */
+			ranges = <0x0 0x40300000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			pm_sram_code: pm-sram-code@0 {
+				compatible = "ti,sram";
+				reg = <0x0 0x1000>;
+				protect-exec;
+			};
+
+			pm_sram_data: pm-sram-data@1000 {
+				compatible = "ti,sram";
+				reg = <0x1000 0x1000>;
+				pool;
+			};
 		};
 
 		elm: elm@48080000 {
-- 
2.16.1
