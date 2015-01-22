From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 09/13] ARM: dts: omap3-gta04: enable power-off for wifi card.
Date: Thu, 22 Jan 2015 21:38:15 +0100
Message-ID: <1421959099-28319-10-git-send-email-marek@goldelico.com>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hns@goldelico.com, neilb@suse.de, NeilBrown <neil@brown.name>
List-Id: linux-omap@vger.kernel.org

From: NeilBrown <neil@brown.name>

Signed-off-by: NeilBrown <neil@brown.name>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index b65b5ed..ab5dd98 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -327,6 +327,7 @@
 	vmmc-supply = <&vaux4>;
 	bus-width = <4>;
 	ti,non-removable;
+	cap-power-off-card;
 };
 
 &mmc3 {
-- 
1.9.1
