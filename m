From: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>
Subject: [RFC/PATCH v2 10/13] dt: omap4: panda board: set clock freq for i2c
	devices
Date: Tue, 23 Aug 2011 10:03:38 +0500
Message-ID: <1314074021-25186-11-git-send-email-manjugk@ti.com>
References: <1314074021-25186-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


Update omap4 panda dts file with required clock frequencies
for the i2c client devices existing on panda board.

Signed-off-by: G, Manjunath Kondaiah <manjugk-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap4-panda.dts |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index c28aa95..6b831ca 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -3,4 +3,20 @@
 / {
 	model = "TI OMAP4 PandaBoard";
 	compatible = "ti,omap4-panda", "ti,omap4430";
+
+	i2c1 {
+		clock-frequency = <400000>;
+	};
+
+	i2c2 {
+		clock-frequency = <400000>;
+	};
+
+	i2c3 {
+		clock-frequency = <400000>;
+	};
+
+	i2c4 {
+		clock-frequency = <400000>;
+	};
 };
-- 
1.7.4.1
