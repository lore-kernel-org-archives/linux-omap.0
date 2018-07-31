From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 14/32] ARM: dts: omap3-gta04: explicitly describe that mmc1 has no CD/WP
Date: Tue, 31 Jul 2018 09:11:17 +0200
Message-ID: <0de5f6396eada90f203e046b4e8803b28a88d8f0.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ladis@linux-mips.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

There are neither CD nor WP switches for mmc1. The µSD slot is
located under the SIM card under the battery and not accessible
during operation.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index cdee97f532c5..bb4c9ad62edb 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -505,6 +505,7 @@
 	vmmc-supply = <&vmmc1>;
 	bus-width = <4>;
 	ti,non-removable;
+	broken-cd;	/* hardware has no CD */
 };
 
 &mmc2 {
-- 
2.12.2
