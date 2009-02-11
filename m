From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH 2/2] USB: OTG: Twl4030 depends on REGULATOR_TWL4030
Date: Wed, 11 Feb 2009 09:06:42 +0200
Message-ID: <1234336002-26372-3-git-send-email-kalle.jokiniemi@digia.com>
References: <>
 <1234336002-26372-1-git-send-email-kalle.jokiniemi@digia.com>
 <1234336002-26372-2-git-send-email-kalle.jokiniemi@digia.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755985AbZBKHHq@vger.kernel.org>
In-Reply-To: <1234336002-26372-2-git-send-email-kalle.jokiniemi@digia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: david-b@pacbell.net
Cc: lrg@slimlogic.co.uk, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, jouni.hogander@nokia.com, broonie@sirena.org.uk, Kalle Jokiniemi <kalle.jokiniemi@digia.com>
List-Id: linux-omap@vger.kernel.org

From: Jouni Hogander <jouni.hogander@nokia.com>

Twl4030 doesn't work without twl4030-regulator so it should depend on
that.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
---
 drivers/usb/otg/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index ee55b44..5790a5b 100644
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -43,7 +43,7 @@ config ISP1301_OMAP
 
 config TWL4030_USB
 	tristate "TWL4030 USB Transceiver Driver"
-	depends on TWL4030_CORE
+	depends on TWL4030_CORE && REGULATOR_TWL4030
 	select USB_OTG_UTILS
 	help
 	  Enable this to support the USB OTG transceiver on TWL4030
-- 
1.5.4.3
