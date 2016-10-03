From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [PATCH v2 4/4] ARM: dts: am4372: add DMA properties for tscadc
Date: Mon, 3 Oct 2016 18:33:18 +0530
Message-ID: <20161003130318.12591-5-mugunthanvnm@ti.com>
References: <20161003130318.12591-1-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161003130318.12591-1-mugunthanvnm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-iio@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Vignesh R <vigneshr@ti.com>, Mugunthan V N <mugunthanvnm@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, "Andrew F . Davis" <afd@ti.com>, John Syne <john3909@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-omap@vger.kernel.org

Add DMA properties for tscadc

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 0fadae5..6094d17 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -867,6 +867,8 @@
 			clocks = <&adc_tsc_fck>;
 			clock-names = "fck";
 			status = "disabled";
+			dmas = <&edma 53 0>, <&edma 57 0>;
+			dma-names = "fifo0", "fifo1";
 
 			tsc {
 				compatible = "ti,am3359-tsc";
-- 
2.10.0.372.g6fe1b14
