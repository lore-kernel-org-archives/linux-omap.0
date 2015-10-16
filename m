From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 3/3] ARM: dts: omap5-uevm: enable iio gpadc for Palmas
Date: Fri, 16 Oct 2015 14:53:40 +0200
Message-ID: <05c57453151c9e2cbd3f15145f1e15223410cd87.1445000017.git.hns@goldelico.com>
References: <cover.1445000017.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1445000017.git.hns@goldelico.com>
In-Reply-To: <cover.1445000017.git.hns@goldelico.com>
References: <cover.1445000017.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Marek Belisko <marek@goldelico.com>, Pradeep Goudagunta <pgoudagunta@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Graeme Gregory <gg@slimlogic.co.uk>, jic23@jic23.retrosnub.co.uk, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-iio@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap5-uevm.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 0e8128b..63f81bb 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -342,6 +342,16 @@
 
 			ti,ldo6-vibrator;
 
+			gpadc {
+				compatible = "ti,palmas-gpadc";
+				interrupts = <18 0
+					      16 0
+					      17 0>;
+				#io-channel-cells = <1>;
+				ti,channel0-current-microamp = <5>;
+				ti,channel3-current-microamp = <10>;
+			};
+
 			regulators {
 				smps123_reg: smps123 {
 					/* VDD_OPP_MPU */
-- 
2.5.1
