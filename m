From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 2/2] ARM: dts: motorola-cpcap-mapphone: set initial mode for vaudio
Date: Fri,  7 Jul 2017 22:08:13 +0200
Message-ID: <20170707200813.20371-3-sebastian.reichel@collabora.co.uk>
References: <20170707200813.20371-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170707200813.20371-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Set default mode for vaudio, which may be left in standby mode
if the system is booted via kexec from Android.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
index 86033aee8a29..7c6d61fb5cf2 100644
--- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
+++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
@@ -261,5 +261,6 @@
 		regulator-min-microvolt = <2775000>;
 		regulator-max-microvolt = <2775000>;
 		regulator-enable-ramp-delay = <1000>;
+		regulator-initial-mode = <0x00>; /* NORMAL */
 	};
 };
-- 
2.13.2
