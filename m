From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/2] ARM: dts: dra7: Add ti,secure-ram node to ocmcram1 node
Date: Tue, 10 May 2016 14:49:42 -0500
Message-ID: <1462909782-14639-3-git-send-email-d-gerlach@ti.com>
References: <1462909782-14639-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462909782-14639-1-git-send-email-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Secure variants of DRA7xx and AM57xx SoCs may need to reserve a region
of the SRAM for use by secure software. To account for this, add a child
node to the ocmcram1 node that will act as a placeholder at the start
of the SRAM for the reserved region of memory that may be required
by secure services. The node is added with size 0 so that by default
parts will have the full space available but the bootloader or board dts
file is able to resize the node as needed depending on how much reserved
space is needed, if any, so end users of the ocmcram1 region on HS parts
must be aware that a smaller amount of SRAM than expected may be available.

Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index fd6f74856bd3..f46a265ce315 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -292,6 +292,21 @@
 			ranges = <0x0 0x40300000 0x80000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			/*
+			 * This is a placeholder for an optional reserved
+			 * region for use by secure software. The size
+			 * of this region is not known until runtime so it
+			 * is set as zero to either be updated to reserve
+			 * space or left unchanged to leave all SRAM for use.
+			 * On HS parts that that require the reserved region
+			 * either the bootloader can update the size to
+			 * the required amount or the node can be overridden
+			 * from the board dts file for the secure platform.
+			 */
+			sram-hs@0 {
+				compatible = "ti,secure-ram";
+				reg = <0x0 0x0>;
+			};
 		};
 
 		/*
-- 
2.7.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
