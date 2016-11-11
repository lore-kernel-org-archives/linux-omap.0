From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/14] ARM: OMAP2+: Remove legacy muxing for usb-tusb6010.c
Date: Fri, 11 Nov 2016 11:17:03 -0800
Message-ID: <20161111191711.5079-7-tony@atomide.com>
References: <20161111191711.5079-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161111191711.5079-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We are moving to device tree based booting, and this should be
done using pinctrl-single instead.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/usb-tusb6010.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -22,8 +22,6 @@
 
 #include "gpmc.h"
 
-#include "mux.h"
-
 static u8		async_cs, sync_cs;
 static unsigned		refclk_psec;
 
@@ -226,25 +224,6 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 	}
 	tusb_device.dev.platform_data = data;
 
-	/* REVISIT let the driver know what DMA channels work */
-	if (!dmachan)
-		tusb_device.dev.dma_mask = NULL;
-	else {
-		/* assume OMAP 2420 ES2.0 and later */
-		if (dmachan & (1 << 0))
-			omap_mux_init_signal("sys_ndmareq0", 0);
-		if (dmachan & (1 << 1))
-			omap_mux_init_signal("sys_ndmareq1", 0);
-		if (dmachan & (1 << 2))
-			omap_mux_init_signal("sys_ndmareq2", 0);
-		if (dmachan & (1 << 3))
-			omap_mux_init_signal("sys_ndmareq3", 0);
-		if (dmachan & (1 << 4))
-			omap_mux_init_signal("sys_ndmareq4", 0);
-		if (dmachan & (1 << 5))
-			omap_mux_init_signal("sys_ndmareq5", 0);
-	}
-
 	/* so far so good ... register the device */
 	status = platform_device_register(&tusb_device);
 	if (status < 0) {
-- 
2.10.2
