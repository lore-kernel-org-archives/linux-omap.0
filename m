From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 3/3] ARM: dts: omap5-uevm: enable iio gpadc for Palmas
Date: Mon,  5 Oct 2015 08:14:54 +0200
Message-ID: <8669dddf9a633eaa085aca228510c4107ff76cbe.1444025629.git.hns@goldelico.com>
References: <86F849CB-1A50-4BEB-99C6-79FF97971DCB@goldelico.com>
 <cover.1444025625.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444025625.git.hns@goldelico.com>
In-Reply-To: <cover.1444025625.git.hns@goldelico.com>
References: <cover.1444025625.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Marek Belisko <marek@goldelico.com>, Pradeep Goudagunta <pgoudagunta@nvidia.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Laxman Dewangan <ldewangan@nvidia.com>, gg@slimlogic.co.uk, jic23@jic23.retrosnub.co.uk
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap5-uevm.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 3b16e8f..c78ee2f 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -342,6 +342,15 @@
 
 			ti,ldo6-vibrator;
 
+			gpadc {
+				compatible = "ti,palmas-gpadc";
+				interrupts = <18 0
+					      16 0
+					      17 0>;
+				ti,channel0-current-microamp = <5>;
+				ti,channel3-current-microamp = <10>;
+			};
+
 			regulators {
 				smps123_reg: smps123 {
 					/* VDD_OPP_MPU */
-- 
2.5.1
