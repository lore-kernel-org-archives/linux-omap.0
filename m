From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 3/3] ARM: dts: omap5-uevm: enable iio gpadc for Palmas
Date: Wed, 23 Sep 2015 14:49:16 +0200
Message-ID: <4254897D-374E-4122-A1A6-269A22C2D622@goldelico.com>
References: <1437657169.3419965.331206849.51D66A2E@webmail.messagingengine.com> <cover.1443012491.git.hns@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1443012491.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Marek Belisko <marek@goldelico.com>, Pradeep Goudagunta <pgoudagunta@nvidia.com>, Nikolaus Schaller <hns@goldelico.com>, Laxman Dewangan <ldewangan@nvidia.com>, gg@slimlogic.co.uk, jic23@jic23.retrosnub.co.uk
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, notaz@openpandora.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
arch/arm/boot/dts/omap5-uevm.dts | 22 ++++++++++++++++++++++
1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 3b16e8f..0d4c8ff 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -342,6 +342,28 @@

			ti,ldo6-vibrator;

+			gpadc {
+				compatible = "ti,palmas-gpadc";
+				interrupts = <18 0
+					      16 0
+					      17 0>;
+				ti,channel0-current-microamp = <5>;
+				ti,channel3-current-microamp = <10>;
+				iio_map {
+					ch1 {
+						ti,adc-channel-number = <1>;
+						ti,adc-consumer-device = "generic-adc-thermal.0";
+						ti,adc-consumer-channel ="battery-temp-channel";
+					};
+
+					ch6 {
+						ti,adc-channel-number = <6>;
+						ti,adc-consumer-device = "palmas-battery";
+						ti,adc-consumer-channel ="vbat_channel";
+					};
+				};
+			};
+
			regulators {
				smps123_reg: smps123 {
					/* VDD_OPP_MPU */
-- 
2.5.1
