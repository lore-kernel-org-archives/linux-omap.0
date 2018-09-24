From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] bus: ti-sysc: Detect more devices on am473x for debugging
Date: Mon, 24 Sep 2018 15:44:44 -0700
Message-ID: <20180924224445.97239-4-tony@atomide.com>
References: <20180924224445.97239-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924224445.97239-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

When debug is enabled, we want to see what devices we're detecting
to make things a bit easier for us. Many of these devices will also
be available on am335x and dra7, and some just need updating the
revision register mask.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -895,33 +895,50 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 		   SYSC_QUIRK_LEGACY_IDLE),
 
 #ifdef DEBUG
+	SYSC_QUIRK("adc", 0, 0, 0x10, -1, 0x47300001, 0xffffffff, 0),
 	SYSC_QUIRK("aess", 0, 0, 0x10, -1, 0x40000000, 0xffffffff, 0),
 	SYSC_QUIRK("control", 0, 0, 0x10, -1, 0x40000900, 0xffffffff, 0),
+	SYSC_QUIRK("cpgmac", 0, 0x1200, 0x1208, 0x1204, 0x4edb1902,
+		   0xffffffff, 0),
+	SYSC_QUIRK("dcan", 0, 0, -1, -1, 0x00001401, 0xffffffff, 0),
+	SYSC_QUIRK("dwc3", 0, 0, 0x10, -1, 0x500a0200, 0xffffffff, 0),
+	SYSC_QUIRK("epwmss", 0, 0, 0x4, -1, 0x47400001, 0xffffffff, 0),
 	SYSC_QUIRK("gpu", 0, 0x1fc00, 0x1fc10, -1, 0, 0, 0),
 	SYSC_QUIRK("hdq1w", 0, 0, 0x14, 0x18, 0x00000006, 0xffffffff, 0),
+	SYSC_QUIRK("hdq1w", 0, 0, 0x14, 0x18, 0x0000000a, 0xffffffff, 0),
 	SYSC_QUIRK("hsi", 0, 0, 0x10, 0x14, 0x50043101, 0xffffffff, 0),
 	SYSC_QUIRK("iss", 0, 0, 0x10, -1, 0x40000101, 0xffffffff, 0),
-	SYSC_QUIRK("i2c", 0, 0, 0x10, 0x90, 0x5040000a, 0xffffffff, 0),
+	SYSC_QUIRK("i2c", 0, 0, 0x10, 0x90, 0x5040000a, 0xfffffff0, 0),
 	SYSC_QUIRK("mcasp", 0, 0, 0x4, -1, 0x44306302, 0xffffffff, 0),
+	SYSC_QUIRK("mcasp", 0, 0, 0x4, -1, 0x44307b02, 0xffffffff, 0),
 	SYSC_QUIRK("mcbsp", 0, -1, 0x8c, -1, 0, 0, 0),
 	SYSC_QUIRK("mcspi", 0, 0, 0x10, -1, 0x40300a0b, 0xffffffff, 0),
+	SYSC_QUIRK("mcspi", 0, 0, 0x110, 0x114, 0x40300a0b, 0xffffffff, 0),
 	SYSC_QUIRK("mailbox", 0, 0, 0x10, -1, 0x00000400, 0xffffffff, 0),
+	SYSC_QUIRK("m3", 0, 0, -1, -1, 0x5f580105, 0x0fff0f00, 0),
 	SYSC_QUIRK("ocp2scp", 0, 0, 0x10, 0x14, 0x50060005, 0xffffffff, 0),
+	SYSC_QUIRK("ocp2scp", 0, 0, -1, -1, 0x50060007, 0xffffffff, 0),
 	SYSC_QUIRK("padconf", 0, 0, 0x10, -1, 0x4fff0800, 0xffffffff, 0),
 	SYSC_QUIRK("prcm", 0, 0, -1, -1, 0x40000100, 0xffffffff, 0),
+	SYSC_QUIRK("prcm", 0, 0, -1, -1, 0x40000400, 0xffffffff, 0),
 	SYSC_QUIRK("scm", 0, 0, 0x10, -1, 0x40000900, 0xffffffff, 0),
+	SYSC_QUIRK("scm", 0, 0, -1, -1, 0x4f000100, 0xffffffff, 0),
 	SYSC_QUIRK("scrm", 0, 0, -1, -1, 0x00000010, 0xffffffff, 0),
 	SYSC_QUIRK("sdio", 0, 0, 0x10, -1, 0x40202301, 0xffffffff, 0),
+	SYSC_QUIRK("sdio", 0, 0x2fc, 0x110, 0x114, 0x31010000, 0xffffffff, 0),
 	SYSC_QUIRK("sdma", 0, 0, 0x2c, 0x28, 0x00010900, 0xffffffff, 0),
 	SYSC_QUIRK("slimbus", 0, 0, 0x10, -1, 0x40000902, 0xffffffff, 0),
 	SYSC_QUIRK("slimbus", 0, 0, 0x10, -1, 0x40002903, 0xffffffff, 0),
 	SYSC_QUIRK("spinlock", 0, 0, 0x10, -1, 0x50020000, 0xffffffff, 0),
+	SYSC_QUIRK("rng", 0, 0x1fe0, 0x1fe4, -1, 0x00000020, 0xffffffff, 0),
+	SYSC_QUIRK("rtc", 0, 0x74, 0x78, -1, 0x4eb01908, 0xffffffff, 0),
+	SYSC_QUIRK("timer32k", 0, 0, 0x4, -1, 0x00000060, 0xffffffff, 0),
 	SYSC_QUIRK("usbhstll", 0, 0, 0x10, 0x14, 0x00000004, 0xffffffff, 0),
 	SYSC_QUIRK("usb_host_hs", 0, 0, 0x10, 0x14, 0x50700100, 0xffffffff, 0),
 	SYSC_QUIRK("usb_otg_hs", 0, 0x400, 0x404, 0x408, 0x00000050,
 		   0xffffffff, 0),
-	SYSC_QUIRK("wdt", 0, 0, 0x10, 0x14, 0x502a0500, 0xffffffff, 0),
-	SYSC_QUIRK("wdt", 0, 0, 0x10, 0x14, 0x502a0d00, 0xffffffff, 0),
+	SYSC_QUIRK("wdt", 0, 0, 0x10, 0x14, 0x502a0500, 0xfffff0f0, 0),
+	SYSC_QUIRK("vfpe", 0, 0, 0x104, -1, 0x4d001200, 0xffffffff, 0),
 #endif
 };
 
-- 
2.19.0
