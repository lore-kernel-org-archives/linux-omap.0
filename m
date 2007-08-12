From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix section mismatch warning
Date: Sun, 12 Aug 2007 09:14:08 +0200
Message-ID: <46BEB340.90900@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090003090508000701070606"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

This is a multi-part message in MIME format.
--------------090003090508000701070606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix

WARNING: vmlinux.o(.text+0x1554c): Section mismatch: reference to
.init.text:reserve_bootmem (between 'omapfb_reserve_sdram' and
'omap_32k_timer_set_mode')

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

--------------090003090508000701070606
Content-Type: text/plain;
 name="02_section_mismatch_warning_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="02_section_mismatch_warning_patch.txt"

Index: linux-osk/arch/arm/plat-omap/fb.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/fb.c
+++ linux-osk/arch/arm/plat-omap/fb.c
@@ -171,7 +171,7 @@ static int check_fbmem_region(int region
  * Called from map_io. We need to call to this early enough so that we
  * can reserve the fixed SDRAM regions before VM could get hold of them.
  */
-void omapfb_reserve_sdram(void)
+void __init omapfb_reserve_sdram(void)
 {
 	struct bootmem_data	*bdata;
 	unsigned long		sdram_start, sdram_size;


--------------090003090508000701070606
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090003090508000701070606--
