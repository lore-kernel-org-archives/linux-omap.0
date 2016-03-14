From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: am43xx: fix edma memcpy channel allocation
Date: Mon, 14 Mar 2016 11:01:50 +0200
Message-ID: <1457946110-4612-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

EDMA was allocating DMA channels 32 and 33 for memcpy usage, out of which
channel 33 is actually used by DES crypto engine. This bad allocation of
the channel causes a crash in the DES crypto engine, as the channel
gets configured for memcpy usage instead of hardware <-> memory DMA.

Fixed by allocating DMA channels 58 and 59 for memcpy usage (I2C0 RX/TX),
which are not used by anybody.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Suggested-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am4372.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 92068fb..cdd3d78 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -207,7 +207,7 @@
 			ti,tptcs = <&edma_tptc0 7>, <&edma_tptc1 5>,
 				   <&edma_tptc2 0>;
 
-			ti,edma-memcpy-channels = <32 33>;
+			ti,edma-memcpy-channels = <58 59>;
 		};
 
 		edma_tptc0: tptc@49800000 {
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
