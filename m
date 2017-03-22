From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 03/15] ARM: dts: ti: fix PCI bus dtc warnings
Date: Tue, 21 Mar 2017 21:03:01 -0500
Message-ID: <20170322020313.24338-3-robh@kernel.org>
References: <20170322020313.24338-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170322020313.24338-1-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

dtc recently added PCI bus checks. Fix these warnings.

Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "Benoît Cousson" <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
Sub-arch maintainers, please apply to your trees unless arm-soc wants 
to take the whole lot.

 arch/arm/boot/dts/dra7.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 2c9e56f4aac5..bbfb9d5a70a9 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -283,6 +283,7 @@
 				device_type = "pci";
 				ranges = <0x81000000 0 0          0x03000 0 0x00010000
 					  0x82000000 0 0x20013000 0x13000 0 0xffed000>;
+				bus-range = <0x00 0xff>;
 				#interrupt-cells = <1>;
 				num-lanes = <1>;
 				linux,pci-domain = <0>;
@@ -319,6 +320,7 @@
 				device_type = "pci";
 				ranges = <0x81000000 0 0          0x03000 0 0x00010000
 					  0x82000000 0 0x30013000 0x13000 0 0xffed000>;
+				bus-range = <0x00 0xff>;
 				#interrupt-cells = <1>;
 				num-lanes = <1>;
 				linux,pci-domain = <1>;
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
