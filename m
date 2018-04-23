From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 14/16] bus: ti-sysc: Detect UARTs for SYSC_QUIRK_LEGACY_IDLE quirk on omap4
Date: Mon, 23 Apr 2018 10:45:47 -0700
Message-ID: <20180423174549.57412-15-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Starting with omap4, UARTs have different revision register that we need to
detect to enable SYSC_QUIRK_LEGACY_IDLE. Otherwise UARTs won't idle properly.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -880,6 +880,9 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 		   SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000052, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
+	/* Uarts on omap4 and later */
+	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x50411e03, 0xffffffff,
+		   SYSC_QUIRK_LEGACY_IDLE),
 };
 
 static void sysc_init_revision_quirks(struct sysc *ddata)
-- 
2.17.0
