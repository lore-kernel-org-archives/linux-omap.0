From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] OMAP: FB: sem2mutex conversion
Date: Fri, 24 Mar 2006 05:38:46 -0800 (PST)
Message-ID: <20060324133846.74035.qmail@web32911.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1017677672-1143207526=:73005"
Content-Transfer-Encoding: 8bit
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

--0-1017677672-1143207526=:73005
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

 
 

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1017677672-1143207526=:73005
Content-Type: text/plain; name="0003-OMAP-FB-sem2mutex-conversion.txt"
Content-Description: 2362136449-0003-OMAP-FB-sem2mutex-conversion.txt
Content-Disposition: inline; filename="0003-OMAP-FB-sem2mutex-conversion.txt"

Subject: [PATCH] OMAP: FB: sem2mutex conversion

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 drivers/video/omap/omapfb_main.c   |    6 +++---
 include/asm-arm/arch-omap/omapfb.h |    3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

e0d16c9260eadb18d6fc9aabbdf2fa87e8b80264
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index d32ba58..7e78379 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -111,12 +111,12 @@ extern struct lcd_ctrl_extif rfbi_extif;
 
 static void omapfb_rqueue_lock(struct omapfb_device *fbdev)
 {
-	down(&fbdev->rqueue_sema);
+	mutex_lock(&fbdev->rqueue_mutex);
 }
 
 static void omapfb_rqueue_unlock(struct omapfb_device *fbdev)
 {
-	up(&fbdev->rqueue_sema);
+	mutex_unlock(&fbdev->rqueue_mutex);
 }
 
 /*
@@ -1273,7 +1273,7 @@ static int omapfb_do_probe(struct platfo
 	fbdev->panel = panel;
 	platform_set_drvdata(pdev, fbdev);
 
-	init_MUTEX(&fbdev->rqueue_sema);
+	mutex_init(&fbdev->rqueue_mutex);
 
 #ifdef CONFIG_ARCH_OMAP1
 	fbdev->int_ctrl = &omap1_int_ctrl;
diff --git a/include/asm-arm/arch-omap/omapfb.h b/include/asm-arm/arch-omap/omapfb.h
index 7eade7b..fccdb3d 100644
--- a/include/asm-arm/arch-omap/omapfb.h
+++ b/include/asm-arm/arch-omap/omapfb.h
@@ -126,6 +126,7 @@ enum omapfb_update_mode {
 #include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/fb.h>
+#include <linux/mutex.h>
 
 #include <asm/arch/board.h>
 
@@ -269,7 +270,7 @@ struct omapfb_device {
 	int			state;
 	int                     ext_lcdc;               /* Using external
                                                            LCD controller */
-	struct semaphore	rqueue_sema;
+	struct mutex		rqueue_mutex;
 
 	void			*vram_virt_base;
 	dma_addr_t		vram_phys_base;
-- 
1.1.6

--0-1017677672-1143207526=:73005
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1017677672-1143207526=:73005--
