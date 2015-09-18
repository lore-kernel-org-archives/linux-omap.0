From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/5] ARM: dts: DRA74x: Add IPC sub-mailbox nodes for all IPUs & DSPs
Date: Fri, 18 Sep 2015 13:16:30 -0500
Message-ID: <1442600194-62520-2-git-send-email-s-anna@ti.com>
References: <1442600194-62520-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442600194-62520-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add the sub-mailbox nodes that are used to communicate between
MPU and the remote processors IPU1, IPU2, DSP1 and DSP2.

The sub-mailbox nodes utilize the System Mailbox instances 5 and 6.
These sub-mailbox nodes are added to match the hard-coded mailbox
configuration used within the TI IPC 3.x software package. The
Dual-Cortex M4 IPU1 and IPU2 processor sub-systems are assumed to
be running in SMP-mode, and hence only a single sub-mailbox node
is added for each.

All these sub-mailbox nodes are left in disabled state, and should
be enabled (and modified if needed) as per the individual product
configuration in the corresponding board dts files.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra74x.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index feea98e0a4b5..33d11c2c8af3 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -93,3 +93,29 @@
 		 <&dss_video2_clk>;
 	clock-names = "fck", "video1_clk", "video2_clk";
 };
+
+&mailbox5 {
+	mbox_ipu1_ipc3x: mbox_ipu1_ipc3x {
+		ti,mbox-tx = <6 2 2>;
+		ti,mbox-rx = <4 2 2>;
+		status = "disabled";
+	};
+	mbox_dsp1_ipc3x: mbox_dsp1_ipc3x {
+		ti,mbox-tx = <5 2 2>;
+		ti,mbox-rx = <1 2 2>;
+		status = "disabled";
+	};
+};
+
+&mailbox6 {
+	mbox_ipu2_ipc3x: mbox_ipu2_ipc3x {
+		ti,mbox-tx = <6 2 2>;
+		ti,mbox-rx = <4 2 2>;
+		status = "disabled";
+	};
+	mbox_dsp2_ipc3x: mbox_dsp2_ipc3x {
+		ti,mbox-tx = <5 2 2>;
+		ti,mbox-rx = <1 2 2>;
+		status = "disabled";
+	};
+};
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
