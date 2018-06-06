From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 8/8] ARM: dts: am335x-sl50: enable tsadc on SL50 board.
Date: Wed,  6 Jun 2018 17:54:13 +0200
Message-ID: <20180606155413.23542-8-enric.balletbo@collabora.com>
References: <20180606155413.23542-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606155413.23542-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, devicetree@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The tsadc is used to read various voltages on the board, so enable it
to be able to read these voltages from userspace.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm/boot/dts/am335x-sl50.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index e11a6def36a4..522fc7decfd7 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -729,3 +729,11 @@
 &lcdc {
 	status = "okay";
 };
+
+&tscadc {
+	status = "okay";
+};
+
+&am335x_adc {
+	ti,adc-channels = <0 1 2 3 4 5 6 7>;
+};
-- 
2.17.1
