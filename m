From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 2/5] ARM: dts: am335x-boneblack: Enable 1GHz OPP for cpu
Date: Mon, 6 Mar 2017 09:23:39 -0600
Message-ID: <1488813822-26042-3-git-send-email-d-gerlach@ti.com>
References: <1488813822-26042-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1488813822-26042-1-git-send-email-d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Lukasz Majewski <lukma@denx.de>, Yegor Yefremov <yegorslists@googlemail.com>
List-Id: linux-omap@vger.kernel.org

Although all PG2.0 silicon may not support 1GHz OPP for the MPU, older
Beaglebone Blacks may have PG2.0 silicon populated and these particular
parts are guaranteed to support the OPP, so enable it for PG2.0 on
am335x-boneblack only.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am335x-boneblack.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 77273df1a028..935ed17d22e4 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -15,3 +15,14 @@
 	model = "TI AM335x BeagleBone Black";
 	compatible = "ti,am335x-bone-black", "ti,am335x-bone", "ti,am33xx";
 };
+
+&cpu0_opp_table {
+	/*
+	 * All PG 2.0 silicon may not support 1GHz but some of the early
+	 * BeagleBone Blacks have PG 2.0 silicon which is guaranteed
+	 * to support 1GHz OPP so enable it for PG 2.0 on this board.
+	 */
+	oppnitro@1000000000 {
+		opp-supported-hw = <0x06 0x0100>;
+	};
+};
-- 
2.11.0
