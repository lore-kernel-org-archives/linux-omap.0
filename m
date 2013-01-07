From: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Subject: [PATCH 3/5] capemgr: am335x-bone capemgr bindings
Date: Mon,  7 Jan 2013 20:51:04 +0200
Message-ID: <1357584666-17374-4-git-send-email-panto@antoniou-consulting.com>
References: <1357584666-17374-1-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1357584666-17374-1-git-send-email-panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
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
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Bindings which enable the DT overlay based cape manager for
the Texas Instruments Beaglebone platform.

Signed-off-by: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
---
 arch/arm/boot/dts/am335x-bone.dts | 68 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 11b240c..5faeece 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -38,7 +38,7 @@
 		};
 	};
 
-	ocp {
+	ocp: ocp {
 		uart1: serial@44e09000 {
 			status = "okay";
 		};
@@ -51,6 +51,35 @@
 				reg = <0x24>;
 			};
 
+			baseboard_eeprom: baseboard_eeprom@50 {
+				compatible = "at,24c256";
+				reg = <0x50>;
+			};
+		};
+
+		i2c3: i2c@4819c000 {
+			status = "okay";
+			clock-frequency = <100000>;
+
+			cape_eeprom0: cape_eeprom0@54 {
+				compatible = "at,24c256";
+				reg = <0x54>;
+			};
+
+			cape_eeprom1: cape_eeprom1@55 {
+				compatible = "at,24c256";
+				reg = <0x55>;
+			};
+
+			cape_eeprom2: cape_eeprom2@56 {
+				compatible = "at,24c256";
+				reg = <0x56>;
+			};
+
+			cape_eeprom3: cape_eeprom3@57 {
+				compatible = "at,24c256";
+				reg = <0x57>;
+			};
 		};
 	};
 
@@ -83,6 +112,43 @@
 			default-state = "off";
 		};
 	};
+
+	bone_capemgr {
+		compatible = "ti,bone-capemgr";
+		status = "okay";
+
+		eeprom = <&baseboard_eeprom>;
+
+		baseboardmaps {
+			baseboard_beaglebone: board@0 {
+				board-name = "A335BONE";
+				compatible-name = "ti,beaglebone";
+			};
+		};
+
+		slots {
+			slot@0 {
+				eeprom = <&cape_eeprom0>;
+			};
+
+			slot@1 {
+				eeprom = <&cape_eeprom1>;
+			};
+
+			slot@2 {
+				eeprom = <&cape_eeprom2>;
+			};
+
+			slot@3 {
+				eeprom = <&cape_eeprom3>;
+			};
+		};
+
+		/* mapping between board names and dtb objects */
+		capemaps {
+
+		};
+	};
 };
 
 /include/ "tps65217.dtsi"
-- 
1.7.12
