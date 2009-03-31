From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: Fix module build warnings
Date: Tue, 31 Mar 2009 19:26:51 +0300
Message-ID: <1238516811-11401-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:30782 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761247AbZCaQ1A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Mar 2009 12:27:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: linux-omap@vger.kernel.org

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    6 ----
 drivers/dsp/bridge/rmgr/node.c          |    1 -
 drivers/dsp/bridge/wmd/tiomap3430.c     |   39 ++++++++++++++++---------------
 3 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 350e1b5..981354a 100755
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -685,12 +685,6 @@ static int bridge_release(struct inode *ip, struct file *filp)
 	return status;
 }
 
-static void bridge_free(struct device *dev)
-{
-	/* nothing to Free */
-}
-
-
 /* This function provides IO interface to the bridge driver. */
 static int bridge_ioctl(struct inode *ip, struct file *filp, unsigned int code,
 		unsigned long args)
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 51b4b12..66a6284 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -3471,7 +3471,6 @@ static DSP_STATUS GetRMSFxns(struct NODE_MGR *hNodeMgr)
 			}
 		}
 	}
-func_end:
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 1fca3e5..b489da1 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -2034,26 +2034,27 @@ static DSP_STATUS PteSet(struct PgTableAttrs *pt, u32 pa, u32 va,
 			if (pfn_valid(__phys_to_pfn(patemp))) {
 				pg = phys_to_page(patemp);
 				get_page(pg);
+				if (page_count(pg) <= 1) {
+					printk(KERN_EMERG "DSPBRIDGE:MAP  "
+						"function: COUNT 0 FOR PA "
+						"0x%x\n", patemp);
+					printk(KERN_EMERG "Bad page state"
+						"in process '%s'\n"
+						"page:%p flags:0x%0*lx "
+						"mapping:%p mapcount:%d "
+						"count:%d\n"
+						"Trying to fix it up, but "
+						"a reboot is needed\n"
+						"Backtrace:\n",
+						current->comm, pg,
+						(int)(2*sizeof(unsigned long)),
+						(unsigned long)pg->flags,
+						pg->mapping, page_mapcount(pg),
+						page_count(pg));
+					dump_stack();
+					BUG_ON(1);
+				}
 			}
-			if (page_count(pg) <= 1) {
-				printk(KERN_EMERG "DSPBRIDGE:MAP  function: "
-					"COUNT 0 FOR PA 0x%x\n", patemp);
-				printk(KERN_EMERG "Bad page state"
-					KERN_EMERG "in process '%s'\n"
-					KERN_EMERG "page:%p flags:0x%0*lx "
-					KERN_EMERG "mapping:%p mapcount:%d "
-					KERN_EMERG "count:%d\n"
-					KERN_EMERG "Trying to fix it up, but "
-					KERN_EMERG "a reboot is needed\n"
-					KERN_EMERG "Backtrace:\n",
-					current->comm, pg,
-					(int)(2*sizeof(unsigned long)),
-					(unsigned long)pg->flags, pg->mapping,
-					page_mapcount(pg), page_count(pg));
-				dump_stack();
-				BUG_ON(1);
-			}
-
 			patemp += HW_PAGE_SIZE_4KB;
 		}
 	}
-- 
1.6.2.1

