From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/2] mfd: twl4030-power: use 'ti,system-power-controller' as alternative way to support system power off
Date: Wed, 3 Sep 2014 14:06:48 -0500
Message-ID: <1409771208-21867-3-git-send-email-nm@ti.com>
References: <1409771208-21867-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409771208-21867-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
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
 drivers/mfd/twl4030-power.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 3bc969a..1c129ba 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -627,6 +627,9 @@ static bool twl4030_power_use_poweroff(const struct twl4030_power_data *pdata,
 	if (pdata && pdata->use_poweroff)
 		return true;
 
+	if (of_property_read_bool(node, "ti,system-power-controller"))
+		return true;
+
 	if (of_property_read_bool(node, "ti,use_poweroff"))
 		return true;
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
