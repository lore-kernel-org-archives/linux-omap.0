From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 1/2] ARM: dts: dra7: Increase max-voltage of pbias regulator
Date: Mon, 9 Oct 2017 11:23:11 +0530
Message-ID: <20171009055312.24165-2-kishon@ti.com>
References: <20171009055312.24165-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171009055312.24165-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, Ravikumar Kattekola <rk@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Ravikumar Kattekola <rk@ti.com>

As per recent TRM, PBIAS cell on dra7 devices supports
3.3v and not 3.0v as documented earlier.

Update PBIAS regulator max voltage to match this.

Document reference:
SPRUI30C – DRA75x, DRA74x Technical reference manual- November 2016

Tested on:
DRA75x PG 2.0 REV H EVM

Signed-off-by: Ravikumar Kattekola <rk@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 02a136a4661a..14d75c589369 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -170,7 +170,7 @@
 						pbias_mmc_reg: pbias_mmc_omap5 {
 							regulator-name = "pbias_mmc_omap5";
 							regulator-min-microvolt = <1800000>;
-							regulator-max-microvolt = <3000000>;
+							regulator-max-microvolt = <3300000>;
 						};
 					};
 
-- 
2.11.0
