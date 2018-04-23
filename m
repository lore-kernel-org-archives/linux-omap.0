From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 15/16] bus: ti-sysc: Tag sdio and wdt with legacy mode for suspend
Date: Mon, 23 Apr 2018 10:45:48 -0700
Message-ID: <20180423174549.57412-16-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Looks like these two device drivers don't yet behave properly for suspend
unless configured with the legacy option.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -883,6 +883,14 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	/* Uarts on omap4 and later */
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x50411e03, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
+
+	/* These devices don't yet suspend properly without legacy setting */
+	SYSC_QUIRK("sdio", 0, 0, 0x10, -1, 0x40202301, 0xffffffff,
+		   SYSC_QUIRK_LEGACY_IDLE),
+	SYSC_QUIRK("wdt", 0, 0, 0x10, 0x14, 0x502a0500, 0xffffffff,
+		   SYSC_QUIRK_LEGACY_IDLE),
+	SYSC_QUIRK("wdt", 0, 0, 0x10, 0x14, 0x502a0d00, 0xffffffff,
+		   SYSC_QUIRK_LEGACY_IDLE),
 };
 
 static void sysc_init_revision_quirks(struct sysc *ddata)
-- 
2.17.0
