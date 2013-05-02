From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 4/5] ARM: dts: OMAP4460: Add device nodes for ABB
Date: Thu, 2 May 2013 12:20:13 -0500
Message-ID: <1367515215-30753-5-git-send-email-nm@ti.com>
References: <1367515215-30753-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1367515215-30753-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
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
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, "Andrii.Tseglytskyi" <andrii.tseglytskyi-l0cyMroinI0@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: "Andrii.Tseglytskyi" <andrii.tseglytskyi-l0cyMroinI0@public.gmane.org>

Add ABB device nodes for OMAP4460 device Data is based on OMAP4460
Technical Reference Manual revision Z (April 2013)

[nm-l0cyMroinI0@public.gmane.org: co-developer]
Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap4460.dtsi |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
index 2cf227c..e854c41 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -29,4 +29,42 @@
 			     <0 55 0x4>;
 		ti,hwmods = "debugss";
 	};
+
+	ocp {
+		abb_mpu: regulator-abb-mpu {
+			status = "okay";
+
+			reg = <0x4a307bd0 0x8>, <0x4a306014 0x4>,
+			      <0x4A002268 0x4>;
+			reg-names = "base-address", "int-address",
+				    "efuse-address";
+
+			ti,abb_info = <
+			/*uV		ABB	efuse	rbb_m	fbb_m	vset_m*/
+			1025000		0	0	0	0	0
+			1200000		0	0	0	0	0
+			1313000		0	0	0x100000 0x40000 0
+			1375000		1	0	0	0	0
+			1389000		1	0	0	0	0
+			>;
+		};
+
+		abb_iva: regulator-abb-iva {
+			status = "okay";
+
+			reg = <0x4a307bd8 0x8>, <0x4a306010 0x4>,
+			      <0x4A002268 0x4>;
+			reg-names = "base-address", "int-address",
+				    "efuse-address";
+
+			ti,abb_info = <
+			/*uV		ABB	efuse	rbb_m	fbb_m	vset_m*/
+			950000		0	0	0	0	0
+			1140000		0	0	0	0	0
+			1291000		0	0	0x200000 0	0
+			1375000		1	0	0	0	0
+			1376000		1	0	0	0	0
+			>;
+		};
+	};
 };
-- 
1.7.9.5
