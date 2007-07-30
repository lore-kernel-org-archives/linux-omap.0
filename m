From: Hiroshi.DOYU@nokia.com
Subject: [PATCH 6/8] DSPGW: Use ALIGN macro instead of homemade one
Date: Mon, 30 Jul 2007 14:04:03 +0300
Message-ID: <11857934584117-git-send-email-Hiroshi.DOYU@nokia.com>
References: <11857934452717-git-send-email-Hiroshi.DOYU@nokia.com>
	<11857934482616-git-send-email-Hiroshi.DOYU@nokia.com>
	<11857934501598-git-send-email-Hiroshi.DOYU@nokia.com>
	<11857934533223-git-send-email-Hiroshi.DOYU@nokia.com>
	<11857934552591-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11857934552591-git-send-email-Hiroshi.DOYU@nokia.com>
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
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/dsp/task.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/dsp/task.c b/arch/arm/plat-omap/dsp/task.c
index 0e2b5c7..2b2ab76 100644
--- a/arch/arm/plat-omap/dsp/task.c
+++ b/arch/arm/plat-omap/dsp/task.c
@@ -44,8 +44,6 @@
 #include "ipbuf.h"
 #include "proclist.h"
 
-#define is_aligned(adr,align)	(!((adr)&((align)-1)))
-
 /*
  * devstate: task device state machine
  * NOTASK:	task is not attached.
@@ -493,8 +491,8 @@ static int dsp_task_config(struct dsptask *task, u8 tid)
 
 	/* mmap buffer configuration check */
 	if ((task->map_length > 0) &&
-	    ((!is_aligned((unsigned long)task->map_base, PAGE_SIZE)) ||
-	     (!is_aligned(task->map_length, PAGE_SIZE)) ||
+	    ((!ALIGN((unsigned long)task->map_base, PAGE_SIZE)) ||
+	     (!ALIGN(task->map_length, PAGE_SIZE)) ||
 	     (dsp_mem_type(task->map_base, task->map_length) != MEM_TYPE_EXTERN))) {
 		printk(KERN_ERR
 		       "omapdsp: illegal mmap buffer address(0x%p) or "
-- 
1.5.3.rc3.24.g83b3d
