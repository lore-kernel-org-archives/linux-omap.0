From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 3/3] omap4: panda: Pass regulator data from dt
Date: Tue, 13 Dec 2011 15:49:35 +0530
Message-ID: <1323771575-3550-4-git-send-email-rnayak@ti.com>
References: <1323771575-3550-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1323771575-3550-1-git-send-email-rnayak-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Pass the adjustable voltage regulator information for
omap4panda board from device tree.

Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap4-panda.dts |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index b66bcd6..f6cc48a 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -40,6 +40,30 @@
 			compatible = "ti,twl4030-rtc";
 			interrupts = <11>;
 		};
+
+		vaux2: regulator@0 {
+			compatible = "ti,twl6030-vaux2","ti,twl6030";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <2800000>;
+		};
+
+		vaux3: regulator@1 {
+			compatible = "ti,twl6030-vaux3","ti,twl6030";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		vmmc: regulator@2 {
+			compatible = "ti,twl6030-vmmc","ti,twl6030";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		vpp: regulator@3 {
+			compatible = "ti,twl6030-vpp","ti,twl6030";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2500000>;
+		};
 	};
 };
 
-- 
1.7.1
