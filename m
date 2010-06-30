From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/16] omap: mux: Fix omap_mux_init_gpio for omap24xx
Date: Wed, 30 Jun 2010 15:06:29 +0300
Message-ID: <20100630120629.2637.28177.stgit@baageli.muru.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51135 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755689Ab0F3MGV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 08:06:21 -0400
In-Reply-To: <20100630120226.2637.31198.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Looks like 24xx uses mode3 instead of mode4 for muxable GPIO pins.
This will be needed when 24xx mux code is converted to use the new
mux functions.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 8b3d269..76b5bf7 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -43,6 +43,7 @@
 
 #define OMAP_MUX_BASE_OFFSET		0x30	/* Offset from CTRL_BASE */
 #define OMAP_MUX_BASE_SZ		0x5ca
+#define MUXABLE_GPIO_MODE3		BIT(0)
 
 struct omap_mux_entry {
 	struct omap_mux		mux;
@@ -51,6 +52,7 @@ struct omap_mux_entry {
 
 static unsigned long mux_phys;
 static void __iomem *mux_base;
+static u8 omap_mux_flags;
 
 u16 omap_mux_read(u16 reg)
 {
@@ -394,7 +396,10 @@ int __init omap_mux_init_gpio(int gpio, int val)
 
 			old_mode = omap_mux_read(m->reg_offset);
 			mux_mode = val & ~(OMAP_MUX_NR_MODES - 1);
-			mux_mode |= OMAP_MUX_MODE4;
+			if (omap_mux_flags & MUXABLE_GPIO_MODE3)
+				mux_mode |= OMAP_MUX_MODE3;
+			else
+				mux_mode |= OMAP_MUX_MODE4;
 			printk(KERN_DEBUG "mux: Setting signal "
 				"%s.gpio%i 0x%04x -> 0x%04x\n",
 				m->muxnames[0], gpio, old_mode, mux_mode);
@@ -1032,6 +1037,9 @@ int __init omap_mux_init(u32 mux_pbase, u32 mux_size,
 		return -ENODEV;
 	}
 
+	if (cpu_is_omap24xx())
+		omap_mux_flags = MUXABLE_GPIO_MODE3;
+
 	omap_mux_init_package(superset, package_subset, package_balls);
 	omap_mux_init_list(superset);
 	omap_mux_init_signals(board_mux);

