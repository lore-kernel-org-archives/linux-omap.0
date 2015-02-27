From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] usb: musb: fix Kconfig regression
Date: Fri, 27 Feb 2015 21:12:45 +0100
Message-ID: <7445620.7S2XydQea5@wuerfel>
References: <20150217185518.GA3825@amd> <20150226230307.GA27809@fuloong-minipc.musicnaut.iki.fi> <20150227153809.GS11056@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150227153809.GS11056@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, sre@debian.org, kernel list <linux-kernel@vger.kernel.org>, sre@ring0.de, Sakari Ailus <sakari.ailus@iki.fi>, Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

A recent bug fix I did that was marked for stable backports
introduced a slightly wrong dependency on CONFIG_OMAP_CONTROL_PHY.

I was missing the fact that the PHY driver already stubs out the
omap_control_usb_set_mode, and we only need to add a dependency
to prevent the musb-omap2430 driver from being built-in when
the phy driver is a loadable module, but we should not prevent it
from being built altogether when the phy driver is disabled.

This changes the dependency to allow OMAP_CONTROL_PHY to
be disabled, but to disallow USB_MUSB_OMAP2PLUS from being
built-in if OMAP_CONTROL_PHY is a loadable module.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: ca784be36cc725 ("usb: start using the control module driver")
Cc: <stable@vger.kernel.org> # v3.9+
Cc: Felipe Balbi <balbi@ti.com>

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 14e1628483d9..39db8b603627 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -79,7 +79,8 @@ config USB_MUSB_TUSB6010
 
 config USB_MUSB_OMAP2PLUS
 	tristate "OMAP2430 and onwards"
-	depends on ARCH_OMAP2PLUS && USB && OMAP_CONTROL_PHY
+	depends on ARCH_OMAP2PLUS && USB
+	depends on OMAP_CONTROL_PHY || !OMAP_CONTROL_PHY
 	select GENERIC_PHY
 
 config USB_MUSB_AM35X
