From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv3 4/6] ARM: dts: motorola-cpcap-mapphone: add audio-codec
Date: Tue, 25 Jul 2017 17:10:28 +0200
Message-ID: <20170725151030.26863-5-sebastian.reichel@collabora.co.uk>
References: <20170725151030.26863-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170725151030.26863-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Add node for audio-codec to its DT file.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
index 1eb5da1dc8f0..86033aee8a29 100644
--- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
+++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
@@ -68,6 +68,12 @@
 			};
 		};
 
+		cpcap_audio: audio-codec {
+			#sound-dai-cells = <1>;
+			compatible = "motorola,cpcap-audio-codec";
+			vdd-supply = <&vaudio>;
+		};
+
 		cpcap_rtc: rtc {
 			compatible = "motorola,cpcap-rtc";
 
-- 
2.13.2
