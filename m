From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 5/6] ARM: dts: motorola-cpcap-mapphone: set initial mode for vaudio
Date: Wed, 12 Jul 2017 17:18:45 +0200
Message-ID: <20170712151846.24621-6-sebastian.reichel@collabora.co.uk>
References: <20170712151846.24621-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170712151846.24621-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
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
