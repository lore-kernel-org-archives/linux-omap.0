From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] phy: cpcap-usb: Fix flakey host idling and enumerating of devices
Date: Fri, 30 Aug 2019 14:44:09 -0700
Message-ID: <20190830214409.49232-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

We must let the USB host idle things properly before we switch to debug
UART mode. Otherwise the USB host may never idle after disconnecting
devices, and that causes the next enumeration to be flakey. This happens
as the USB PHY mode gets disabled too early.

Cc: Jacopo Mondi <jacopo@jmondi.org>
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Michael Scott <hashcode0f@gmail.com>
Cc: NeKit <nekit1000@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Fixes: 6d6ce40f63af ("phy: cpcap-usb: Add CPCAP PMIC USB support")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/phy/motorola/phy-cpcap-usb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
--- a/drivers/phy/motorola/phy-cpcap-usb.c
+++ b/drivers/phy/motorola/phy-cpcap-usb.c
@@ -274,12 +274,12 @@ static void cpcap_usb_detect(struct work_struct *work)
 		return;
 	}
 
-	/* Default to debug UART mode */
-	error = cpcap_usb_set_uart_mode(ddata);
+	error = musb_mailbox(MUSB_VBUS_OFF);
 	if (error)
 		goto out_err;
 
-	error = musb_mailbox(MUSB_VBUS_OFF);
+	/* Default to debug UART mode */
+	error = cpcap_usb_set_uart_mode(ddata);
 	if (error)
 		goto out_err;
 
-- 
2.23.0
