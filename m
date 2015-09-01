From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: DTS: dra72-evm: remove cpsw gpio hogging and add select-slave-gpio
Date: Tue, 1 Sep 2015 17:00:40 +0530
Message-ID: <1441107040-6105-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "David S . Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Since GPIO hogging fails to through error when booting with
gpio-pcf857x as module and NFS root filesystem. So by having
select-slave-gpio, it throw error to user so that the used can
make gpio-pcf857x as inbuilt for NFS. When using mmc/ramdisk as
root fs, cpsw will probe defer and re-probes again when
gpio-pcf857x module is inserted and ethernet becomes operational.

Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
---

This patch depends on driver changes [1] and tested on DRA72x, logs [2]

[1]: http://patchwork.ozlabs.org/patch/512783/
[2]: http://pastebin.ubuntu.com/12244652/

---
 arch/arm/boot/dts/dra72-evm.dts | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index be9a89b..96d1bd3 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -343,12 +343,6 @@
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
 
@@ -578,6 +572,7 @@
 	pinctrl-0 = <&cpsw_default>;
 	pinctrl-1 = <&cpsw_sleep>;
 	slaves = <1>;
+	select-slave-gpio = <&pcf_gpio_21 4 GPIO_ACTIVE_HIGH>;
 };
 
 &cpsw_emac0 {
-- 
2.5.0.474.g3a9835b

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
