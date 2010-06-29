From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] omap: Enable interface clock for omap2 FS USB
Date: Tue, 29 Jun 2010 14:54:23 +0300
Message-ID: <20100629115423.17702.36906.stgit@baageli.muru.com>
References: <20100629115056.17702.56622.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57540 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab0F2LyL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 07:54:11 -0400
In-Reply-To: <20100629115056.17702.56622.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Looks like this code was only working on boards that had
the usb_l4_ick enabled in the bootloader.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/usb-fs.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-fs.c b/arch/arm/mach-omap2/usb-fs.c
index f63e576..a445519 100644
--- a/arch/arm/mach-omap2/usb-fs.c
+++ b/arch/arm/mach-omap2/usb-fs.c
@@ -24,6 +24,8 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/err.h>
 
 #include <asm/irq.h>
 
@@ -330,9 +332,16 @@ static u32 __init omap2_usb2_init(unsigned nwires, unsigned alt_pingroup)
 
 void __init omap2_usbfs_init(struct omap_usb_config *pdata)
 {
+	struct clk *ick;
+
 	if (!cpu_is_omap24xx())
 		return;
 
+	ick = clk_get(NULL, "usb_l4_ick");
+	if (IS_ERR(ick))
+		return;
+
+	clk_enable(ick);
 	pdata->usb0_init = omap2_usb0_init;
 	pdata->usb1_init = omap2_usb1_init;
 	pdata->usb2_init = omap2_usb2_init;
@@ -340,6 +349,8 @@ void __init omap2_usbfs_init(struct omap_usb_config *pdata)
 	ohci_device_init(pdata);
 	otg_device_init(pdata);
 	omap_otg_init(pdata);
+	clk_disable(ick);
+	clk_put(ick);
 }
 
 #endif

