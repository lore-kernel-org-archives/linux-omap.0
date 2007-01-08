From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH] lcd_mipid: workqueue fixes
Date: Mon, 08 Jan 2007 11:14:25 +0100
Message-ID: <85mz4tesfy.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--=-=-=


This patch fixes the build of the lcd_mipid in current omap -git.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
---

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=mipid_workqueue.patch

---
 drivers/video/omap/lcd_mipid.c |   10 	5 +	5 -	0 !
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-omap-2.6/drivers/video/omap/lcd_mipid.c
===================================================================
--- linux-omap-2.6.orig/drivers/video/omap/lcd_mipid.c	2007-01-07 20:13:21.000000000 +0100
+++ linux-omap-2.6/drivers/video/omap/lcd_mipid.c	2007-01-07 20:53:37.000000000 +0100
@@ -67,7 +67,7 @@ struct mipid_device {
 	struct lcd_panel	panel;
 
 	struct workqueue_struct	*esd_wq;
-	struct work_struct	esd_work;
+	struct delayed_work	esd_work;
 	void			(*esd_check)(struct mipid_device *m);
 };
 
@@ -390,9 +390,9 @@ static void mipid_esd_stop_check(struct 
 		cancel_rearming_delayed_workqueue(md->esd_wq, &md->esd_work);
 }
 
-static void mipid_esd_work(void *data)
+static void mipid_esd_work(struct work_struct *work)
 {
-	struct mipid_device *md = data;
+	struct mipid_device *md = container_of(work, struct mipid_device, esd_work.work);
 
 	mutex_lock(&md->mutex);
 	md->esd_check(md);
@@ -468,7 +468,7 @@ static int mipid_init(struct lcd_panel *
 		dev_err(&md->spi->dev, "can't create ESD workqueue\n");
 		return -ENOMEM;
 	}
-	INIT_WORK(&md->esd_work, mipid_esd_work, md);
+	INIT_DELAYED_WORK(&md->esd_work, mipid_esd_work);
 	mutex_init(&md->mutex);
 
 	md->enabled = panel_enabled(md);
@@ -558,7 +558,7 @@ static int mipid_spi_probe(struct spi_de
 	struct mipid_device *md;
 	int r;
 
-	md = kzalloc(sizeof(*md), SLAB_KERNEL);
+	md = kzalloc(sizeof(*md), GFP_KERNEL);
 	if (md == NULL) {
 		dev_err(&md->spi->dev, "out of memory\n");
 		return -ENOMEM;

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-=-=--
