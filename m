From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/1] ARM: DTS: dra72-evm: remove cpsw gpio hogging and add select-slave-gpio
Date: Mon, 21 Sep 2015 13:34:46 +0530
Message-ID: <1442822686-28063-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Since GPIO hogging fails to through error when booting with
gpio-pcf857x as module and NFS root filesystem. So by having
mode-gpio, it throw error to user so that the used can make
gpio-pcf857x as inbuilt for NFS. When using mmc/ramdisk as root
fs, cpsw will probe defer and re-probes again when gpio-pcf857x
module is inserted and ethernet becomes operational.

Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
---

The driver patch is applied to net-next branch (also present in
linux-next) with commit '1d147ccbfc35 ("drivers: net: cpsw: Add
support to drive gpios for ethernet to be functional") and logs
[1] also pushed a branch [2] for testing.

[1]: http://pastebin.ubuntu.com/12306224/
[2]: git://git.ti.com/~mugunthanvnm/ti-linux-kernel/linux.git cpsw-gpio-optional-v3

---
 arch/arm/boot/dts/dra72-evm.dts | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index c11ccb1..b7eca13 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -353,12 +353,6 @@
 		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-
-		cpsw_sel_s0 {
-			gpio-hog;
-			gpios = <4 GPIO_ACTIVE_HIGH>;
-			output-low;
-		};
 	};
 };
 
@@ -590,6 +584,7 @@
 	pinctrl-0 = <&cpsw_default>;
 	pinctrl-1 = <&cpsw_sleep>;
 	slaves = <1>;
+	mode-gpios = <&pcf_gpio_21 4 GPIO_ACTIVE_HIGH>;
 };
 
 &cpsw_emac0 {
-- 
2.6.0.rc2.10.gf4d9753

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
