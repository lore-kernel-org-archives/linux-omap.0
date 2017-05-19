From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] ARM: dts: am572x-idk: Enable the system mailboxes 5 and 6
Date: Fri, 19 May 2017 15:47:41 -0500
Message-ID: <20170519204742.1563-2-s-anna@ti.com>
References: <20170519204742.1563-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170519204742.1563-1-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Enable the System Mailboxes 5 and 6 and the corresponding
child sub-mailbox (IPC 3.x) nodes for the AM572x IDK board.
This is needed to enable communication with the respective
remote processors IPU1, IPU2, DSP1 and DSP2 from the MPU.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am572x-idk.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index 8350b4b34b08..9da6d83ca185 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -91,3 +91,23 @@
 &pcie1 {
 	gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
 };
+
+&mailbox5 {
+	status = "okay";
+	mbox_ipu1_ipc3x: mbox_ipu1_ipc3x {
+		status = "okay";
+	};
+	mbox_dsp1_ipc3x: mbox_dsp1_ipc3x {
+		status = "okay";
+	};
+};
+
+&mailbox6 {
+	status = "okay";
+	mbox_ipu2_ipc3x: mbox_ipu2_ipc3x {
+		status = "okay";
+	};
+	mbox_dsp2_ipc3x: mbox_dsp2_ipc3x {
+		status = "okay";
+	};
+};
-- 
2.12.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
