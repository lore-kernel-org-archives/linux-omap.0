From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 1/4] ARM: OMAP2+: omap_hwmod: provide space for more hwmod
 flags
Date: Tue, 14 Mar 2017 14:07:17 +0200
Message-ID: <b5169045-7fb2-eb06-7427-25e83b3772bd@ti.com>
References: <1489405996-10718-1-git-send-email-rogerq@ti.com>
 <1489405996-10718-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1489405996-10718-2-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com
Cc: bcousson@baylibre.com, t-kristo@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

From: Sekhar Nori <nsekhar@ti.com>

'flags' member of omap_hwmod structure is fast running
out of space with 16 different flags already defined.

Make flags a 32-bit entity so as to allow for more flags.

This results is a ~2.3K data section size increase with
omap2plus_defconfig on v4.11-rc2.

before:
   text	   data	    bss	    dec	    hex	filename
8186930	3082444	8252992	19522366	129e33e	vmlinux

after:
   text	   data	    bss	    dec	    hex	filename
8186922	3084812	8252992	19524726	129ec76	vmlinux

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
v2:
-Updated size metrics for v4.11-rc2 in commit message.

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
