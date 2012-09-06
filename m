From: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v7 1/3] arm/dts: AM33XX: Add basic pinctrl device tree data
Date: Thu, 6 Sep 2012 15:08:22 +0530
Message-ID: <1346924304-27425-2-git-send-email-anilkumar@ti.com>
References: <1346924304-27425-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1346924304-27425-1-git-send-email-anilkumar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org, bryan.wu-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Adds basic pinctrl device tree data for AM33XX family of devices.
This patch is based on the pinctrl-single driver.

Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am33xx.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index be43511..58cffb7 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -40,6 +40,15 @@
 		};
 	};
 
+	am33xx_pinmux: pinmux@44e10800 {
+		compatible = "pinctrl-single";
+		reg = <0x44e10800 0x0238>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x7f>;
+	};
+
 	/*
 	 * XXX: Use a flat representation of the AM33XX interconnect.
 	 * The real AM33XX interconnect network is quite complex.Since
-- 
1.7.9.5
