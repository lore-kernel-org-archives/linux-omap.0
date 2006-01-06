From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] misc patch on 24xx
Date: Fri, 06 Jan 2006 16:35:06 +0900
Message-ID: <0ISN0041GUEIYE@mmp1.samsung.com>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: 
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi

We need to display correct SRAM physical address.

Regards,
Kyungmin Park

 diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -147,7 +147,8 @@ void __init omap_map_sram(void)
 	iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_io_desc));
 
 	printk(KERN_INFO "SRAM: Mapped pa 0x%08lx to va 0x%08lx size:
0x%lx\n",
-	       omap_sram_io_desc[0].pfn, omap_sram_io_desc[0].virtual,
+	       __pfn_to_phys(omap_sram_io_desc[0].pfn),
+	       omap_sram_io_desc[0].virtual,
 	       omap_sram_io_desc[0].length);
 
 	/*
