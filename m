From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 16/16] bus: ti-sysc: Show module information for suspend if DEBUG is enabled
Date: Mon, 23 Apr 2018 10:45:49 -0700
Message-ID: <20180423174549.57412-17-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Let's show module info if DEBUG is enabled to make it easier to follow
what happens on the suspend and resume path.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -891,6 +891,24 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 		   SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("wdt", 0, 0, 0x10, 0x14, 0x502a0d00, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
+
+#ifdef DEBUG
+	SYSC_QUIRK("aess", 0, 0, 0x10, -1, 0x40000000, 0xffffffff, 0),
+	SYSC_QUIRK("gpu", 0, 0x1fc00, 0x1fc10, -1, 0, 0, 0),
+	SYSC_QUIRK("hdq1w", 0, 0, 0x14, 0x18, 0x00000006, 0xffffffff, 0),
+	SYSC_QUIRK("hsi", 0, 0, 0x10, 0x14, 0x50043101, 0xffffffff, 0),
+	SYSC_QUIRK("iss", 0, 0, 0x10, -1, 0x40000101, 0xffffffff, 0),
+	SYSC_QUIRK("mcasp", 0, 0, 0x4, -1, 0x44306302, 0xffffffff, 0),
+	SYSC_QUIRK("mcbsp", 0, -1, 0x8c, -1, 0, 0, 0),
+	SYSC_QUIRK("mailbox", 0, 0, 0x10, -1, 0x00000400, 0xffffffff, 0),
+	SYSC_QUIRK("slimbus", 0, 0, 0x10, -1, 0x40000902, 0xffffffff, 0),
+	SYSC_QUIRK("slimbus", 0, 0, 0x10, -1, 0x40002903, 0xffffffff, 0),
+	SYSC_QUIRK("spinlock", 0, 0, 0x10, -1, 0x50020000, 0xffffffff, 0),
+	SYSC_QUIRK("usbhstll", 0, 0, 0x10, 0x14, 0x00000004, 0xffffffff, 0),
+	SYSC_QUIRK("usb_host_hs", 0, 0, 0x10, 0x14, 0x50700100, 0xffffffff, 0),
+	SYSC_QUIRK("usb_otg_hs", 0, 0x400, 0x404, 0x408, 0x00000050,
+		   0xffffffff, 0),
+#endif
 };
 
 static void sysc_init_revision_quirks(struct sysc *ddata)
-- 
2.17.0
