From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH 3/4] ARM: dts: am33xx: add DMA properties for tscadc
Date: Wed, 21 Sep 2016 21:41:33 +0530
Message-ID: <20160921161134.6951-4-mugunthanvnm@ti.com>
References: <20160921161134.6951-1-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160921161134.6951-1-mugunthanvnm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-iio@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lee Jones <lee.jones@linaro.org>, Vignesh R <vigneshr@ti.com>, "Andrew F . Davis" <afd@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mugunthan V N <mugunthanvnm@ti.com>
List-Id: linux-omap@vger.kernel.org

Add DMA properties for tscadc

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 98748c6..6d607b8 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -917,6 +917,8 @@
 			interrupts = <16>;
 			ti,hwmods = "adc_tsc";
 			status = "disabled";
+			dmas = <&edma 53 0>, <&edma 57 0>;
+			dma-names = "fifo0", "fifo1";
 
 			tsc {
 				compatible = "ti,am3359-tsc";
-- 
2.10.0.129.g35f6318
