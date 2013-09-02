From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH RFC 6/6] ARM: dts: AM4372: prcm node (for reset)
Date: Mon, 2 Sep 2013 19:52:20 +0530
Message-ID: <3ed48b0a5057a3efee97f4d91bd54214312a5adb.1378129416.git.afzal@ti.com>
References: <cover.1378129416.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1378129416.git.afzal@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul@pwsan.com>, Russell King <linux@arm.linux.org.uk>, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <rob.herring@calxeda.com>, Benoit Cousson <bcousson@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

Add AM4372 prcm node with reset binding.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 5a68fde..d0d11b3 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -411,6 +411,12 @@
 			ti,hwmods = "epwmss5";
 			status = "disabled";
 		};
+
+		prcm: prcm@44df0000 {
+			compatible = "ti,am4372-prcm";
+			reg = <0x44df0000 0xa000>;
+			#reset-cells = <1>;
+		};
 	};
 
 	clocks {
-- 
1.8.3.4
