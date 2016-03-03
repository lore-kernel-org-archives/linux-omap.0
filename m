From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/2] ARM: dts: dra7: do not gate cpsw clock due to errata i877
Date: Thu, 3 Mar 2016 14:12:05 +0530
Message-ID: <1456994525-20573-3-git-send-email-lokeshvutla@ti.com>
References: <1456994525-20573-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456994525-20573-1-git-send-email-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>

Errata id: i877

Description:
------------
The RGMII 1000 Mbps Transmit timing is based on the output clock
(rgmiin_txc) being driven relative to the rising edge of an internal
clock and the output control/data (rgmiin_txctl/txd) being driven relative
to the falling edge of an internal clock source. If the internal clock
source is allowed to be static low (i.e., disabled) for an extended period
of time then when the clock is actually enabled the timing delta between
the rising edge and falling edge can change over the lifetime of the
device. This can result in the device switching characteristics degrading
over time, and eventually failing to meet the Data Manual Delay Time/Skew
specs.
To maintain RGMII 1000 Mbps IO Timings, SW should minimize the
duration that the Ethernet internal clock source is disabled. Note that
the device reset state for the Ethernet clock is "disabled".
Other RGMII modes (10 Mbps, 100Mbps) are not affected

Workaround:
-----------
If the SoC Ethernet interface(s) are used in RGMII mode at 1000 Mbps,
SW should minimize the time the Ethernet internal clock source is disabled
to a maximum of 200 hours in a device life cycle. This is done by enabling
the clock as early as possible in IPL (QNX) or SPL/u-boot (Linux/Android)
by setting the register CM_GMAC_CLKSTCTRL[1:0]CLKTRCTRL = 0x2:SW_WKUP.

So, do not allow to gate the cpsw clocks using ti,no-idle property in
cpsw node assuming 1000 Mbps is being used all the time. If someone does
not need 1000 Mbps and wants to gate clocks to cpsw, this property needs
to be deleted in their respective board files.

Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 6a4572a..340b657 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1466,6 +1466,16 @@
 			       0x48485200 0x2E00>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			/*
+			 * Do not allow gating of cpsw clock as workaround
+			 * for errata i877. Keeping internal clock disabled
+			 * causes the device switching characteristics
+			 * to degrade over time and eventually fail to meet
+			 * the data manual delay time/skew specs.
+			 */
+			ti,no-idle;
+
 			/*
 			 * rx_thresh_pend
 			 * rx_pend
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
