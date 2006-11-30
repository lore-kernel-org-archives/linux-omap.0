From: <Toshihiro.Kobayashi@nokia.com>
Subject: [PATCH] ARM: OMAP: mailbox module stability fix
Date: Thu, 30 Nov 2006 20:06:13 +0900
Message-ID: <7AF192DA69C59243838FF62851F64F55033BEEBF@toebe101.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com, hiroshi.doyu@nokia.com
List-Id: linux-omap@vger.kernel.org

mbox objects must be initialized before request_irq().

Signed-off-by: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>

---

 arch/arm/plat-omap/mailbox.c |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

efafc71d75f2dd9572be38f052171dc1b083bd4e
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 1d3761f..723c92f 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -238,30 +238,32 @@ static int omap_mbox_init(struct omap_mb
 		goto fail1;
 	}
=20
+	spin_lock_init(&mbox->lock);
+	INIT_WORK(&mbox->msg_receive, mbox_msg_receiver, mbox);
+	init_waitqueue_head(&mbox->tx_waitq);
+
+	ret =3D mbq_init(&mbox->mbq);
+	if (unlikely(ret))
+		goto fail2;
+
 	ret =3D request_irq(mbox->irq, mbox_interrupt, SA_INTERRUPT,
 			  mbox->name, mbox);
 	if (unlikely(ret)) {
 		printk(KERN_ERR
 		       "failed to register mailbox interrupt:%d\n",
ret);
-		goto fail1;
+		goto fail3;
 	}
 	disable_mbox_irq(mbox, IRQ_RX);
 	enable_mbox_irq(mbox, IRQ_RX);
=20
-	spin_lock_init(&mbox->lock);
-	INIT_WORK(&mbox->msg_receive, mbox_msg_receiver, mbox);
-	init_waitqueue_head(&mbox->tx_waitq);
-
-	ret =3D mbq_init(&mbox->mbq);
-	if (unlikely(ret))
-		goto fail2;
-
 	return 0;
+
+ fail3:
+	kfree(mbox->mbq);
  fail2:
-	free_irq(mbox->irq, mbox);
 	class_remove_file(&omap_mbox_class, &class_attr_mbox);
-	class_unregister(&omap_mbox_class);
  fail1:
+	class_unregister(&omap_mbox_class);
 	if (unlikely(mbox->ops->shutdown))
 		mbox->ops->shutdown(mbox);
=20
@@ -271,6 +273,7 @@ static int omap_mbox_init(struct omap_mb
 static void omap_mbox_shutdown(struct omap_mbox *mbox)
 {
 	free_irq(mbox->irq, mbox);
+	kfree(mbox->mbq);
 	class_remove_file(&omap_mbox_class, &class_attr_mbox);
 	class_unregister(&omap_mbox_class);
=20
--=20
1.3.3
