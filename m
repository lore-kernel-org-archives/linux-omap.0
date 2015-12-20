From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v2 1/3] devicetree/bindings: add reset-gpios and vcc-supply for panel-dpi
Date: Sun, 20 Dec 2015 12:13:20 +0100
Message-ID: <1450610002-10531-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1450610002-10531-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450610002-10531-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Some displays have a reset input and/or need a regulator to function
properly. Allow to specify them for panel-dpi devices.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 Documentation/devicetree/bindings/display/panel/panel-dpi.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-dpi.=
txt b/Documentation/devicetree/bindings/display/panel/panel-dpi.txt
index 216c894d4f99..b52ac52757df 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-dpi.txt
+++ b/Documentation/devicetree/bindings/display/panel/panel-dpi.txt
@@ -7,6 +7,8 @@ Required properties:
 Optional properties:
 - label: a symbolic name for the panel
 - enable-gpios: panel enable gpio
+- reset-gpios: GPIO to control the RESET pin
+- vcc-supply: phandle of regulator that will be used to enable power t=
o the display
=20
 Required nodes:
 - "panel-timing" containing video timings
--=20
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
