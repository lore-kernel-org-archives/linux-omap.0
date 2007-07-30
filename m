From: Hiroshi.DOYU@nokia.com
Subject: [PATCH 3/8] DSPGW: Remove CONFIG_OMAP_DSP_TASK_MULTIOPEN
Date: Mon, 30 Jul 2007 14:04:00 +0300
Message-ID: <11857934501598-git-send-email-Hiroshi.DOYU@nokia.com>
References: <11857934452717-git-send-email-Hiroshi.DOYU@nokia.com>
	<11857934482616-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11857934482616-git-send-email-Hiroshi.DOYU@nokia.com>
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

This MULTIOPEN feature should always be enabled.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/dsp/Kconfig |    7 -------
 arch/arm/plat-omap/dsp/task.c  |    7 -------
 2 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/arm/plat-omap/dsp/Kconfig b/arch/arm/plat-omap/dsp/Kconfig
index 0d62bee..122164a 100644
--- a/arch/arm/plat-omap/dsp/Kconfig
+++ b/arch/arm/plat-omap/dsp/Kconfig
@@ -14,13 +14,6 @@ config OMAP_DSP_MBCMD_VERBOSE
           This enables kernel log output in the Mailbox command exchanges
 	  in the DSP Gateway driver.
 
-config OMAP_DSP_TASK_MULTIOPEN
-	bool "DSP Task Multiopen Capability"
-	depends on OMAP_DSP
-	help
-          This enables DSP tasks to be opened by multiple times at a time.
-	  Otherwise, they can be opened only once at a time.
-
 config OMAP_DSP_FBEXPORT
 	bool "Framebuffer export to DSP"
 	depends on OMAP_DSP && FB
diff --git a/arch/arm/plat-omap/dsp/task.c b/arch/arm/plat-omap/dsp/task.c
index f2ccbdf..b43f704 100644
--- a/arch/arm/plat-omap/dsp/task.c
+++ b/arch/arm/plat-omap/dsp/task.c
@@ -1453,13 +1453,6 @@ static int dsp_task_open(struct inode *inode, struct file *file)
 	}
 
  attached:
-	/* ATTACHED */
-#ifndef CONFIG_OMAP_DSP_TASK_MULTIOPEN
-	if (dev->usecount > 0) {
-		up_write(&dev->state_sem);
-		return -EBUSY;
-	}
-#endif
 	ret = proc_list_add(&dev->proc_list_lock,
 			    &dev->proc_list, current, file);
 	if (ret)
-- 
1.5.3.rc3.24.g83b3d
