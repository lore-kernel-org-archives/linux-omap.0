From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 5/7] arm: dts: am33xx: add DMA properties for UART
Date: Tue, 29 Jul 2014 20:59:02 +0200
Message-ID: <1406660344-25307-6-git-send-email-bigeasy@linutronix.de>
References: <1406660344-25307-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1406660344-25307-1-git-send-email-bigeasy@linutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: tony@atomide.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/boot/dts/am33xx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 4a4e02d..cdccbd6 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -200,6 +200,8 @@
 			reg = <0x44e09000 0x2000>;
 			interrupts = <72>;
 			status = "disabled";
+			dmas = <&edma 26>, <&edma 27>;
+			dma-names = "tx", "rx";
 		};
 
 		uart1: serial@48022000 {
@@ -209,6 +211,8 @@
 			reg = <0x48022000 0x2000>;
 			interrupts = <73>;
 			status = "disabled";
+			dmas = <&edma 28>, <&edma 29>;
+			dma-names = "tx", "rx";
 		};
 
 		uart2: serial@48024000 {
@@ -218,6 +222,8 @@
 			reg = <0x48024000 0x2000>;
 			interrupts = <74>;
 			status = "disabled";
+			dmas = <&edma 30>, <&edma 31>;
+			dma-names = "tx", "rx";
 		};
 
 		uart3: serial@481a6000 {
-- 
2.0.1
