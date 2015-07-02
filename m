From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 16/20] ARM: DTS: am335x-evmsk: Switch using
 simple-audio-card for audio support
Date: Thu, 2 Jul 2015 17:06:31 +0300
Message-ID: <1435845995-19085-17-git-send-email-peter.ujfalusi@ti.com>
References: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The sound support consist only Headset output on the board and can be
handled by "simple-audio-card"

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 8abfe2a2ff4a..315bb02c9920 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -141,14 +141,26 @@
 	};
 
 	sound {
-		compatible = "ti,da830-evm-audio";
-		ti,model = "AM335x-EVMSK";
-		ti,audio-codec = <&tlv320aic3106>;
-		ti,mcasp-controller = <&mcasp1>;
-		ti,codec-clock-rate = <24000000>;
-		ti,audio-routing =
-			"Headphone Jack",       "HPLOUT",
-			"Headphone Jack",       "HPROUT";
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "AM335x-EVMSK";
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack";
+		simple-audio-card,routing =
+			"Headphone Jack",	"HPLOUT",
+			"Headphone Jack",	"HPROUT";
+		simple-audio-card,format = "dsp_b";
+		simple-audio-card,bitclock-master = <&sound_master>;
+		simple-audio-card,frame-master = <&sound_master>;
+		simple-audio-card,bitclock-inversion;
+
+		simple-audio-card,cpu {
+			sound-dai = <&mcasp1>;
+		};
+
+		sound_master: simple-audio-card,codec {
+			sound-dai = <&tlv320aic3106>;
+			system-clock-frequency = <24000000>;
+		};
 	};
 
 	panel {
@@ -471,6 +483,7 @@
 	};
 
 	tlv320aic3106: tlv320aic3106@1b {
+		#sound-dai-cells = <0>;
 		compatible = "ti,tlv320aic3106";
 		reg = <0x1b>;
 		status = "okay";
@@ -670,6 +683,7 @@
 };
 
 &mcasp1 {
+	#sound-dai-cells = <0>;
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&mcasp1_pins>;
 	pinctrl-1 = <&mcasp1_pins_sleep>;
-- 
2.4.5
