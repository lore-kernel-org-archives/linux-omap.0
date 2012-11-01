From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3] ARM: dts: AM33xx: Add SPI node
Date: Thu, 1 Nov 2012 14:49:41 +0100
Message-ID: <50927DF5.4080008@ti.com>
References: <1351680669-20718-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1351680669-20718-1-git-send-email-avinashphilip-l0cyMroinI0@public.gmane.org>
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
To: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Cc: afzal-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Avinash,

On 10/31/2012 11:51 AM, Philip, Avinash wrote:
> Add McSPI data node to AM33XX device tree file. The McSPI module (and so
> as the driver) is reused from OMAP4.
> 
> Signed-off-by: Philip, Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>
> Tested-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>

I've just realized the interrupt-parent was still there, so I removed both.

Please find below the updated version.

Regards,
Benoit

----
>From 9fd3c748aac9418cd377249ca463050783d2198f Mon Sep 17 00:00:00 2001
From: Philip, Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>
Date: Wed, 31 Oct 2012 16:21:09 +0530
Subject: [PATCH] ARM: dts: AM33XX: Add SPI node

Add McSPI data node to AM33XX device tree file. The McSPI module (and so
as the driver) is reused from OMAP4.

Signed-off-by: Philip, Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>
Tested-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
[b-cousson-l0cyMroinI0@public.gmane.org: Remove interrupt-parent]
Signed-off-by: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am33xx.dtsi |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 97a7bd3..5dfd682 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -299,5 +299,27 @@
 				      76>;
 			ti,hwmods = "rtc";
 		};
+
+		spi0: spi@48030000 {
+			compatible = "ti,omap4-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x48030000 0x400>;
+			interrupt = <65>;
+			ti,spi-num-cs = <2>;
+			ti,hwmods = "spi0";
+			status = "disabled";
+		};
+
+		spi1: spi@481a0000 {
+			compatible = "ti,omap4-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x481a0000 0x400>;
+			interrupt = <125>;
+			ti,spi-num-cs = <2>;
+			ti,hwmods = "spi1";
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.0.4
