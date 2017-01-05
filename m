From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] ARM: dts: Fix omap3 off mode pull defines
Date: Thu,  5 Jan 2017 11:07:18 -0800
Message-ID: <20170105190718.28010-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

We need to also have OFFPULLUDENABLE bit set to use the off mode pull values.
Otherwise the line is pulled down internally if no external pull exists.

This is has some documentation at:

http://processors.wiki.ti.com/index.php/Optimizing_OMAP35x_and_AM/DM37x_OFF_mode_PAD_configuration

Note that the value is still glitchy during off mode transitions as documented
in spz319f.pdf "Advisory 1.45". It's best to use external pulls instead of
relying on the internal ones for off mode and even then anything pulled up
will get driven down momentarily on off mode restore for GPIO banks other
than bank1.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 include/dt-bindings/pinctrl/omap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/pinctrl/omap.h b/include/dt-bindings/pinctrl/omap.h
--- a/include/dt-bindings/pinctrl/omap.h
+++ b/include/dt-bindings/pinctrl/omap.h
@@ -45,8 +45,8 @@
 #define PIN_OFF_NONE		0
 #define PIN_OFF_OUTPUT_HIGH	(OFF_EN | OFFOUT_EN | OFFOUT_VAL)
 #define PIN_OFF_OUTPUT_LOW	(OFF_EN | OFFOUT_EN)
-#define PIN_OFF_INPUT_PULLUP	(OFF_EN | OFF_PULL_EN | OFF_PULL_UP)
-#define PIN_OFF_INPUT_PULLDOWN	(OFF_EN | OFF_PULL_EN)
+#define PIN_OFF_INPUT_PULLUP	(OFF_EN | OFFOUT_EN | OFF_PULL_EN | OFF_PULL_UP)
+#define PIN_OFF_INPUT_PULLDOWN	(OFF_EN | OFFOUT_EN | OFF_PULL_EN)
 #define PIN_OFF_WAKEUPENABLE	WAKEUP_EN
 
 /*
-- 
2.11.0
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
