From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 8/8] arm/dts: AM335x-evm: Add TSC/ADC MFD device support
Date: Thu, 24 Jan 2013 09:15:12 +0530
Message-ID: <1358999112-31192-9-git-send-email-rachna@ti.com>
References: <1358999112-31192-1-git-send-email-rachna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358999112-31192-1-git-send-email-rachna-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, gururaja.hebbar-l0cyMroinI0@public.gmane.org, "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>

Add support for core multifunctional device along
with its clients touchscreen and ADC.

Signed-off-by: Patil, Rachna <rachna-l0cyMroinI0@public.gmane.org>
---
Changes in v4:
	Non-standard properties prefixed with vendor name.

 arch/arm/boot/dts/am335x-evm.dts |   13 +++++++++++++
 arch/arm/boot/dts/am33xx.dtsi    |    8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index d649644..bfd7928 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -244,3 +244,16 @@
 &cpsw_emac1 {
 	phy_id = <&davinci_mdio>, <1>;
 };
+
+&tscadc {
+	tsc {
+		ti,wires = <4>;
+		ti,x-plate-resistance = <200>;
+		ti,steps-to-configure = <5>;
+		ti,wire-config = <0x00 0x11 0x22 0x33>;
+	};
+
+	adc {
+		ti,adc-channels = <4>;
+	};
+};
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index c2f14e8..211ec42 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -385,5 +385,13 @@
 				mac-address = [ 00 00 00 00 00 00 ];
 			};
 		};
+
+		tscadc: tscadc@44e0d000 {
+			compatible = "ti,ti-tscadc";
+			reg = <0x44e0d000 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <16>;
+			ti,hwmods = "adc_tsc";
+		};
 	};
 };
-- 
1.7.9.5
