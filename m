From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 3/3] ARM: dts: AM4372: update hdq compatible property
Date: Mon, 2 Mar 2015 16:19:34 +0530
Message-ID: <1425293374-30878-4-git-send-email-vigneshr@ti.com>
References: <1425293374-30878-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425293374-30878-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Evgeniy Polyakov <zbr@ioremap.net>, Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, NeilBrown <neilb@suse.de>, Benoit Cousson <bcousson@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This patch updates hdq node compatible property to "ti,am4372-hdq".

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 1943fc333e7c..ae0e8c15a6df 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -884,7 +884,7 @@
 		};
 
 		hdq: hdq@48347000 {
-			compatible = "ti,am43xx-hdq";
+			compatible = "ti,am4372-hdq";
 			reg = <0x48347000 0x1000>;
 			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&func_12m_clk>;
-- 
1.9.1
