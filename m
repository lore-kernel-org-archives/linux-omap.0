From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/4] ARM: OMAP2+: omap_hwmod: provide space for more hwmod flags
Date: Mon, 13 Mar 2017 13:53:13 +0200
Message-ID: <1489405996-10718-2-git-send-email-rogerq@ti.com>
References: <1489405996-10718-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1489405996-10718-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com
Cc: bcousson@baylibre.com, t-kristo@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Sekhar Nori <nsekhar@ti.com>

'flags' member of omap_hwmod structure is fast running
out of space with 16 different flags already defined.

Make flags a 32-bit entity so as to allow for more flags.

This results is a ~2.3K data section size increase with
TI config fragments.

before:
   text	   data	    bss	    dec	    hex	filename
8886648	 610452	 261876	9758976	 94e900	vmlinux

after:
   text	   data	    bss	    dec	    hex	filename
8886584	 612820	 261876	9761280	 94f200	vmlinux

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 7890401..9e1c4ed 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -698,7 +698,7 @@ struct omap_hwmod {
 	struct list_head		node;
 	struct omap_hwmod_ocp_if	*_mpu_port;
 	unsigned int			(*xlate_irq)(unsigned int);
-	u16				flags;
+	u32				flags;
 	u8				mpu_rt_idx;
 	u8				response_lat;
 	u8				rst_lines_cnt;
-- 
2.7.4
