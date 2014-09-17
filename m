From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH V2 1/2] Documentation: devicetree: mfd: twl4030-power: Use the standard 'ti,system-power-controller' to mark power control
Date: Wed, 17 Sep 2014 07:34:11 -0500
Message-ID: <1410957252-764-2-git-send-email-nm@ti.com>
References: <1410957252-764-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410957252-764-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

ti,system-power-controller is more or less the standard way of
indicating that the PMIC is the system wide power controller and hence
may be used to switch off the system. Almost ALL TI PMIC drivers and
many Maxim PMIC drivers follow the same style.

So support 'ti,system-power-controller' in addition to the usual
'ti,use_poweroff' to indicate that the PMIC instance has control for
switching off the system.

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---

V2: picked up documentation suggestion from Sebastien
V1: https://patchwork.kernel.org/patch/4836381/

 .../devicetree/bindings/mfd/twl4030-power.txt      |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/twl4030-power.txt b/Documentation/devicetree/bindings/mfd/twl4030-power.txt
index b9ee7b9..a7390c7 100644
--- a/Documentation/devicetree/bindings/mfd/twl4030-power.txt
+++ b/Documentation/devicetree/bindings/mfd/twl4030-power.txt
@@ -23,8 +23,13 @@ down during off-idle. Note that this does not work on all boards
 depending on how the external oscillator is wired.
 
 Optional properties:
-- ti,use_poweroff: With this flag, the chip will initiates an ACTIVE-to-OFF or
-		   SLEEP-to-OFF transition when the system poweroffs.
+
+- ti,system-power-controller: This indicates that TWL4030 is the
+  power supply master of the system. With this flag, the chip will
+  initiates an ACTIVE-to-OFF or SLEEP-to-OFF transition when the
+  system poweroffs.
+
+- ti,use_poweroff: Deprecated name for ti,system-power-controller
 
 Example:
 &i2c1 {
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
