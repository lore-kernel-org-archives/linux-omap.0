From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] OMAP: FB: Use blocking notifier apis
Date: Tue, 28 Mar 2006 01:03:40 -0800 (PST)
Message-ID: <20060328090340.98259.qmail@web32910.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-232006039-1143536620=:97970"
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

--0-232006039-1143536620=:97970
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Imre/Tony,

Attached patch should be applied only after omap git tree is synched
with linus mainline tree as of today.

I have use blocking notifiers.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-232006039-1143536620=:97970
Content-Type: text/plain; name="0001-OMAP-FB-Move-to-new-notifier-apis.txt"
Content-Description: 451432436-0001-OMAP-FB-Move-to-new-notifier-apis.txt
Content-Disposition: inline;
	filename="0001-OMAP-FB-Move-to-new-notifier-apis.txt"

>From nobody Mon Sep 17 00:00:00 2001
From: Komal Shah <komal_shah802003@yahoo.com>
Date: Tue Mar 28 11:57:53 2006 +0300
Subject: [PATCH] OMAP: FB: Move to new notifier apis.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 drivers/video/omap/omapfb_main.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

a64117837ac59721e3bb62827e1b4742b17aa7c1
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index d32ba58..546e60d 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -687,7 +687,7 @@
 	return r;
 }
 
-static struct notifier_block *omapfb_client_list;
+static BLOCKING_NOTIFIER_HEAD(omapfb_client_list);
 
 int omapfb_register_client(struct omapfb_notifier_block *omapfb_nb,
 			    omapfb_notifier_callback_t callback,
@@ -700,7 +700,7 @@
 	omapfb_nb->nb.notifier_call = (int (*)(struct notifier_block *,
 					unsigned long, void *))callback;
 	omapfb_nb->data = callback_data;
-	r = notifier_chain_register(&omapfb_client_list, &omapfb_nb->nb);
+	r = blocking_notifier_chain_register(&omapfb_client_list, &omapfb_nb->nb);
 	if (r)
 		return r;
 	if (omapfb_dev != NULL &&
@@ -714,7 +714,7 @@
 
 int omapfb_unregister_client(struct omapfb_notifier_block *omapfb_nb)
 {
-	return notifier_chain_unregister(&omapfb_client_list,
+	return blocking_notifier_chain_unregister(&omapfb_client_list,
 					 &omapfb_nb->nb);
 }
 EXPORT_SYMBOL(omapfb_unregister_client);
@@ -722,7 +722,7 @@
 void omapfb_notify_clients(struct omapfb_device *fbdev, unsigned long event)
 {
 	DBGENTER(1);
-	notifier_call_chain(&omapfb_client_list, event, fbdev);
+	blocking_notifier_call_chain(&omapfb_client_list, event, fbdev);
 }
 EXPORT_SYMBOL(omapfb_notify_clients);
 
-- 
1.3-rc1.GIT


--0-232006039-1143536620=:97970
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-232006039-1143536620=:97970--
