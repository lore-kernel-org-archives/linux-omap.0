From: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/2] ARM: dts: am335x-evm, am335x-evmsdk: switch mmc1 to 4-bit mode
Date: Fri, 27 Sep 2013 17:05:10 +0530
Message-ID: <1380281710-12728-2-git-send-email-balajitk@ti.com>
References: <1380281710-12728-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380281710-12728-1-git-send-email-balajitk-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

set bus-width to make SD card operate in 4 bit mode.

Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
---
based on git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.13/dts

 arch/arm/boot/dts/am335x-evm.dts   |    1 +
 arch/arm/boot/dts/am335x-evmsk.dts |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 23b0a3e..028ca09 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -521,4 +521,5 @@
 &mmc1 {
 	status = "okay";
 	vmmc-supply = <&vmmc_reg>;
+	bus-width = <4>;
 };
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index bc93895..563a2b1 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -423,4 +423,5 @@
 &mmc1 {
 	status = "okay";
 	vmmc-supply = <&vmmc_reg>;
+	bus-width = <4>;
 };
-- 
1.7.5.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
