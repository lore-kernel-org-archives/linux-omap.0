From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC 2/5] OMAP: mux: Make low level function private
Date: Fri, 24 Sep 2010 11:15:45 +0200
Message-ID: <1285319748-28976-3-git-send-email-b-cousson@ti.com>
References: <1285319748-28976-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46371 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711Ab0IXJP4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Sep 2010 05:15:56 -0400
In-Reply-To: <1285319748-28976-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

omap_mux_read / omap_mux_write should not be accessed directly
outside the mux framework.
Do we really have use case that require dynamic mux change beside
GPIO?

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/mux.c |    4 ++--
 arch/arm/mach-omap2/mux.h |   18 ------------------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 83e7686..8285cb8 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -55,7 +55,7 @@ static u8 omap_mux_flags;
 static struct mux_partition mux_partitions[MAX_PARTITIONS_NR];
 static u32 mux_partitions_cnt;
 
-u16 omap_mux_read(u16 reg, u8 id)
+static u16 omap_mux_read(u16 reg, u8 id)
 {
 	void __iomem *mux_base = mux_partitions[id].base;
 
@@ -65,7 +65,7 @@ u16 omap_mux_read(u16 reg, u8 id)
 		return __raw_readw(mux_base + reg);
 }
 
-void omap_mux_write(u16 val, u16 reg, u8 id)
+static void omap_mux_write(u16 val, u16 reg, u8 id)
 {
 	void __iomem *mux_base = mux_partitions[id].base;
 
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 9b28576..da67501 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -173,24 +173,6 @@ u16 omap_mux_get_gpio(int gpio);
 void omap_mux_set_gpio(u16 val, int gpio);
 
 /**
- * omap_mux_read() - read mux register
- * @mux_offset:		Offset of the mux register
- * @id:			identifier of the control module partition
- *
- */
-u16 omap_mux_read(u16 mux_offset, u8 id);
-
-/**
- * omap_mux_write() - write mux register
- * @val:		New mux register value
- * @mux_offset:		Offset of the mux register
- * @id:			identifier of the control module partition
- *
- * This should be only needed for dynamic remuxing of non-gpio signals.
- */
-void omap_mux_write(u16 val, u16 mux_offset, u8 id);
-
-/**
  * omap_mux_write_array() - write an array of mux registers
  * @board_mux:		Array of mux registers terminated by MAP_MUX_TERMINATOR
  *
-- 
1.6.0.4

