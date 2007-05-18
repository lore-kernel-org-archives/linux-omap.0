From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix section mismatch warning in dsp_common.c
Date: Fri, 18 May 2007 09:14:25 +0200
Message-ID: <464D5251.7060503@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090507070107080809070002"
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
--------------090507070107080809070002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix

WARNING: arch/arm/plat-omap/built-in.o - Section mismatch: reference
to .init.text: from .text between 'dsp_cpustat_update' (at offset
0x7c40) and 'do_release_mem'

If init_dsp isn't set, dsp_cpustat_update() calls omap_dsp_init(). So
don't declare omap_dsp_init() as __init.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------090507070107080809070002
Content-Type: text/plain;
 name="fix_section_mismatch_dsp_common.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_section_mismatch_dsp_common.txt"

Index: linux-osk/arch/arm/plat-omap/dsp/dsp_common.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/dsp/dsp_common.c
+++ linux-osk/arch/arm/plat-omap/dsp/dsp_common.c
@@ -268,7 +268,7 @@ void dsp_reset_idle_boot_base(void) { }
 
 static int init_done;
 
-static int __init omap_dsp_init(void)
+static int omap_dsp_init(void)
 {
 	mutex_init(&cpustat.lock);
 



--------------090507070107080809070002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090507070107080809070002--
