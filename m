From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 20/20] ARM: dts: am335x-boneblack: enable power off and rtc wake up
Date: Tue, 21 Oct 2014 19:38:06 +0200
Message-ID: <1413913086-12730-21-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1413913086-12730-1-git-send-email-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413913086-12730-1-git-send-email-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alessandro Zummo <a.zummo@towertech.it>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Felipe Balbi <balbi@ti.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lokesh Vutla <lokeshvutla@ti.com>, Guenter Roeck <linux@roeck-us.net>, nsekhar@ti.com, t-kristo@ti.com, j-keerthy@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-omap@vger.kernel.org

Configure the RTC as system-power controller, which allows the system to
be powered off as well as woken up again on subsequent RTC alarms.

Note that the PMIC needs to be put in SLEEP (rather than OFF) mode to
maintain RTC power. Specifically, this means that the PMIC
ti,pmic-shutdown-controller property must be left unset in order to be
able to wake up on RTC alarms.

Tested on BeagleBone Black (rev A5).

Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/arm/boot/dts/am335x-boneblack.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 305975d3f531..0c8cdc9520b7 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -75,3 +75,7 @@
 		status = "okay";
 	};
 };
+
+&rtc {
+	ti,system-power-controller;
+};
-- 
2.0.4
