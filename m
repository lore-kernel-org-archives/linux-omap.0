From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 1a/3] watchdog: omap: clearify device tree documentation
Date: Fri, 24 Apr 2015 22:20:50 +0200
Message-ID: <1429906850-5420-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20150424190207.GU19431@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150424190207.GU19431-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

ti,hwmods doesn't belong into the compatible section but is a property
on it's own. Also reformat the section of required properties to match =
the
usual style of dt binding documents.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
Hello Felipe,

what about this patch before the previously sent patch 1?

Best regards
Uwe

 Documentation/devicetree/bindings/watchdog/omap-wdt.txt | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/omap-wdt.txt b/=
Documentation/devicetree/bindings/watchdog/omap-wdt.txt
index c227970671ea..597e19d18dca 100644
--- a/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
@@ -1,10 +1,8 @@
 TI Watchdog Timer (WDT) Controller for OMAP
=20
 Required properties:
-compatible:
-- "ti,omap3-wdt" for OMAP3
-- "ti,omap4-wdt" for OMAP4
-- ti,hwmods: Name of the hwmod associated to the WDT
+- compatible : "ti,omap3-wdt" for OMAP3 or "ti,omap4-wdt" for OMAP4
+- ti,hwmods : Name of the hwmod associated to the WDT
=20
 Examples:
=20
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
