From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 06/20] ARM: DTS: am43xx-epos-evm: McASP1 node for audio support
Date: Thu, 2 Jul 2015 17:06:21 +0300
Message-ID: <1435845995-19085-7-git-send-email-peter.ujfalusi@ti.com>
References: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435845995-19085-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add node for McASP1 along with the needed pinctrl entries.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 9b584d1e0232..11fced01975d 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -317,6 +317,24 @@
 				0x204 (DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)
 			>;
 		};
+
+		mcasp1_pins: mcasp1_pins {
+			pinctrl-single,pins = <
+				0x1a0 (PIN_INPUT_PULLDOWN | MUX_MODE3) /* MCASP0_ACLKR/MCASP1_ACLKX */
+				0x1a4 (PIN_INPUT_PULLDOWN | MUX_MODE3) /* MCASP0_FSR/MCASP1_FSX */
+				0x1a8 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)/* MCASP0_AXR1/MCASP1_AXR0 */
+				0x1ac (PIN_INPUT_PULLDOWN | MUX_MODE3) /* MCASP0_AHCLKX/MCASP1_AXR1 */
+			>;
+		};
+
+		mcasp1_sleep_pins: mcasp1_sleep_pins {
+			pinctrl-single,pins = <
+				0x1a0 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x1a4 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x1a8 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+				0x1ac (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			>;
+		};
 };
 
 &mmc1 {
@@ -706,3 +724,20 @@
 		};
 	};
 };
+
+&mcasp1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&mcasp1_pins>;
+	pinctrl-1 = <&mcasp1_sleep_pins>;
+
+	status = "okay";
+
+	op-mode = <0>;          /* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+	/* 4 serializer */
+	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
+		1 2 0 0
+	>;
+	tx-num-evt = <32>;
+	rx-num-evt = <32>;
+};
-- 
2.4.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
