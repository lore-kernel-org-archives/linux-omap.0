From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 4/9] ARM: dts: am4372: Update emif node
Date: Sun, 18 Feb 2018 21:35:00 -0600
Message-ID: <1519011305-17822-5-git-send-email-d-gerlach@ti.com>
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

Now that we will use ti-emif-sram driver for am4372 PM, update the
emif DT node with the required sram property.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 81a03c1ad770..10dc52a07b32 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -237,6 +237,8 @@
 			compatible = "ti,emif-am4372";
 			reg = <0x4c000000 0x1000000>;
 			ti,hwmods = "emif";
+			sram = <&pm_sram_code
+				&pm_sram_data>;
 		};
 
 		edma: edma@49000000 {
-- 
2.16.1
