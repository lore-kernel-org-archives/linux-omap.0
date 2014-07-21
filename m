From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 3/7] arm: dts: omap3-gta04: Add wifi reset node
Date: Mon, 21 Jul 2014 23:05:23 +0200
Message-ID: <1405976727-15166-4-git-send-email-marek@goldelico.com>
References: <1405976727-15166-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1405976727-15166-1-git-send-email-marek@goldelico.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, hns@goldelico.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, Marek Belisko <marek@goldelico.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index 6d1a8d8..5b08d93 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -196,6 +196,9 @@
 		#size-cells = <0>;
 		reg = <0x45>;
 
+		gpio-controller;
+		#gpio-cells = <2>;
+
 		gta04_led0: red_aux@0 {
 			label = "gta04:red:aux";
 			reg = <0x0>;
@@ -216,6 +219,11 @@
 			label = "gta04:green:power";
 			reg = <0x4>;
 		};
+
+		wifi_reset: wifi_reset@6 {
+			reg = <0x6>;
+			compatible = "gpio";
+		};
 	};
 
 	/* compass aka magnetometer */
-- 
1.9.1
