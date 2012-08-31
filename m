From: Ravi Babu <ravibabu@ti.com>
Subject: [PATCH v9 08/13] arm/dts: am33xx: Add dt data for usbss
Date: Fri, 31 Aug 2012 16:39:54 +0530
Message-ID: <1346411399-23964-9-git-send-email-ravibabu@ti.com>
References: <1346411399-23964-1-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48263 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679Ab2HaLKL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 07:10:11 -0400
In-Reply-To: <1346411399-23964-1-git-send-email-ravibabu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

Added device tree data for usbss on am33xx. There are two musb controllers
on am33xx platform so have port0_mode and port1_mode additional data.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Santhapuri, Damodar <damodar.santhapuri@ti.com>
Signed-off-by: Ravi Babu <ravibabu@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   11 +++++++++++
 drivers/usb/musb/musb_dsps.c  |    6 +++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 59509c4..bdde9c9 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -154,5 +154,16 @@
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
 		};
+
+		usb_otg_hs: usb_otg_hs {
+			compatible = "ti,musb-am33xx";
+			ti,hwmods = "usb_otg_hs";
+			multipoint = <1>;
+			num-eps = <16>;
+			ram-bits = <12>;
+			port0-mode = <3>;
+			port1-mode = <3>;
+			power = <250>;
+		};
 	};
 };
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 2c104bf..32c8d68 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -581,9 +581,9 @@ static int __devinit dsps_create_musb_pdev(struct dsps_glue *glue, u8 id)
 			goto err2;
 		}
 
-		of_property_read_u32(np, "num_eps", (u32 *)&config->num_eps);
-		of_property_read_u32(np, "ram_bits", (u32 *)&config->ram_bits);
-		sprintf(res_name, "port%d_mode", id);
+		of_property_read_u32(np, "num-eps", (u32 *)&config->num_eps);
+		of_property_read_u32(np, "ram-bits", (u32 *)&config->ram_bits);
+		sprintf(res_name, "port%d-mode", id);
 		of_property_read_u32(np, res_name, (u32 *)&pdata->mode);
 		of_property_read_u32(np, "power", (u32 *)&pdata->power);
 		config->multipoint = of_property_read_bool(np, "multipoint");
-- 
1.7.0.4

