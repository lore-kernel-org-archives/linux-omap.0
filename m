From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: AM43x-epos: Fix clk parent for synctimer
Date: Tue, 8 Mar 2016 12:24:35 +0530
Message-ID: <1457420075-26158-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

commit 55ee7017ee31 ("arm: omap2: board-generic: use omap4_local_timer_init
for AM437x") makes synctimer32k as the clocksource on AM43xx. By default
the synctimer32k is clocked by 32K RTC OSC on AM43xx. But this 32K RTC OSC
is not available on epos boards which makes it fail to boot.

Synctimer32k can also be clocked by a peripheral PLL, so making this as
clock parent for synctimer3k on epos boards.

Reported-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
Tested on AM43x-epos board:
Before this patch: http://pastebin.ubuntu.com/15326328/
After this patch: http://pastebin.ubuntu.com/15326323/

 arch/arm/boot/dts/am43x-epos-evm.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 948fb29..e415332 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -794,3 +794,8 @@
 	tx-num-evt = <32>;
 	rx-num-evt = <32>;
 };
+
+&synctimer_32kclk {
+	assigned-clocks = <&mux_synctimer32k_ck>;
+	assigned-clock-parents = <&clkdiv32k_ick>;
+};
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
