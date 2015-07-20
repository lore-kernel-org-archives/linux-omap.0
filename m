From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH] ARM: dts: am437x: add aliases for all UART instances
Date: Mon, 20 Jul 2015 16:42:20 +0530
Message-ID: <b1af39962d1cae5c344e8593ca738c825af40955.1437390674.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
Cc: Eyal Reizer <eyalr@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Add serialN aliases for all 6 UART instances on
the AM437x SoC so each board's .dts file does not
have to define its own aliases.

Remove the alias added for am437x-gp-evm.dts now
that we have the aliases defined in am4372.dtsi
file.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi       | 5 +++++
 arch/arm/boot/dts/am437x-gp-evm.dts | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index ade28c790f4b..7eb43a4f6176 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -23,6 +23,11 @@
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
 		ethernet0 = &cpsw_emac0;
 		ethernet1 = &cpsw_emac1;
 	};
diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 84aa30c3235a..f435dc9b44ca 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -21,7 +21,6 @@
 
 	aliases {
 		display0 = &lcd0;
-		serial3 = &uart3;
 	};
 
 	vmmcsd_fixed: fixedregulator-sd {
-- 
2.4.4.408.g16da57c
