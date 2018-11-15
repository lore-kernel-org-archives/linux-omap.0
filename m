From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] bus: ti-sysc: Detect devices for debug on omap5
Date: Thu, 15 Nov 2018 14:38:26 -0800
Message-ID: <20181115223826.60477-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We want to see the names of detected devices when DEBUG is enabled.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -820,6 +820,7 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	SYSC_QUIRK("ocp2scp", 0, 0, 0x10, 0x14, 0x50060005, 0xfffffff0, 0),
 	SYSC_QUIRK("ocp2scp", 0, 0, -1, -1, 0x50060007, 0xffffffff, 0),
 	SYSC_QUIRK("padconf", 0, 0, 0x10, -1, 0x4fff0800, 0xffffffff, 0),
+	SYSC_QUIRK("padconf", 0, 0, -1, -1, 0x40001100, 0xffffffff, 0),
 	SYSC_QUIRK("prcm", 0, 0, -1, -1, 0x40000100, 0xffffffff, 0),
 	SYSC_QUIRK("prcm", 0, 0, -1, -1, 0x00004102, 0xffffffff, 0),
 	SYSC_QUIRK("prcm", 0, 0, -1, -1, 0x40000400, 0xffffffff, 0),
@@ -838,7 +839,9 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	SYSC_QUIRK("rtc", 0, 0x74, 0x78, -1, 0x4eb01908, 0xffff00f0, 0),
 	SYSC_QUIRK("timer32k", 0, 0, 0x4, -1, 0x00000060, 0xffffffff, 0),
 	SYSC_QUIRK("usbhstll", 0, 0, 0x10, 0x14, 0x00000004, 0xffffffff, 0),
+	SYSC_QUIRK("usbhstll", 0, 0, 0x10, 0x14, 0x00000008, 0xffffffff, 0),
 	SYSC_QUIRK("usb_host_hs", 0, 0, 0x10, 0x14, 0x50700100, 0xffffffff, 0),
+	SYSC_QUIRK("usb_host_hs", 0, 0, 0x10, -1, 0x50700101, 0xffffffff, 0),
 	SYSC_QUIRK("usb_otg_hs", 0, 0x400, 0x404, 0x408, 0x00000050,
 		   0xffffffff, 0),
 	SYSC_QUIRK("wdt", 0, 0, 0x10, 0x14, 0x502a0500, 0xfffff0f0, 0),
-- 
2.19.1
