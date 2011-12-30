From: NeilBrown <neilb@suse.de>
Subject: [PATCH] omap2430 musb: Make musb_otg_notification non-blocking
Date: Fri, 30 Dec 2011 12:36:28 +1100
Message-ID: <20111230123628.76720567@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/PshiCbE=HVVz52oDXJSsI0T"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49433 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754171Ab1L3Bgi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Dec 2011 20:36:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

--Sig_/PshiCbE=HVVz52oDXJSsI0T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable



This callback is on an 'atomic notificaitons' queue but is written
as a blocking notifier.

Convert to use a work-queue to run from non-atomic context.

Signed-off-by: NeilBrown <neilb@suse.de>

diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index b3c065a..fb90d94 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -352,6 +352,8 @@ struct musb {
=20
 	struct timer_list	otg_timer;
 	struct notifier_block	nb;
+	struct work_struct	notify_work;
+	unsigned long		event;
=20
 	struct dma_controller	*dma_controller;
=20
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index ba85f27..a0fe317 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -223,11 +223,11 @@ static inline void omap2430_low_level_init(struct mus=
b *musb)
 	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
 }
=20
-/* blocking notifier support */
-static int musb_otg_notifications(struct notifier_block *nb,
-		unsigned long event, void *unused)
+/* work function for atomic notifier  */
+static void musb_otg_notify_work(struct work_struct *ws)
 {
-	struct musb	*musb =3D container_of(nb, struct musb, nb);
+	struct musb	*musb =3D container_of(ws, struct musb, notify_work);
+	unsigned long event =3D musb->event;
 	struct device *dev =3D musb->controller;
 	struct musb_hdrc_platform_data *pdata =3D dev->platform_data;
 	struct omap_musb_board_data *data =3D pdata->board_data;
@@ -274,8 +274,18 @@ static int musb_otg_notifications(struct notifier_bloc=
k *nb,
 		break;
 	default:
 		dev_dbg(musb->controller, "ID float\n");
-		return NOTIFY_DONE;
+		break;
 	}
+}
+
+static int musb_otg_notifications(struct notifier_block *nb,
+				  unsigned long event,
+				  void *unused)
+{
+	struct musb *musb =3D container_of(nb, struct musb, nb);
+
+	musb->event =3D event;
+	schedule_work(&musb->notify_work);
=20
 	return NOTIFY_OK;
 }
@@ -323,6 +333,7 @@ static int omap2430_musb_init(struct musb *musb)
 			musb_readl(musb->mregs, OTG_INTERFSEL),
 			musb_readl(musb->mregs, OTG_SIMENABLE));
=20
+	INIT_WORK(&musb->notify_work, musb_otg_notify_work);
 	musb->nb.notifier_call =3D musb_otg_notifications;
 	status =3D otg_register_notifier(musb->xceiv, &musb->nb);
=20
@@ -386,6 +397,7 @@ static void omap2430_musb_disable(struct musb *musb)
 static int omap2430_musb_exit(struct musb *musb)
 {
 	del_timer_sync(&musb_idle_timer);
+	cancel_work_sync(&musb->notify_work);
=20
 	omap2430_low_level_exit(musb);
 	otg_put_transceiver(musb->xceiv);

--Sig_/PshiCbE=HVVz52oDXJSsI0T
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTv0VnTnsnt1WYoG5AQJdAQ//UIb6TTcdh0J1sYo7hAOc7v7//ruPGpXX
5p2vIbQFy2NiS1khNjudxuTwSYttZIDsGSGR+0NJjtjvE1wkt4QJrCHBEAwn4Xcr
CEebu3djBUJp9meSt/vmkmEmBO1pbPmBus4U72v4KdT0ucvLVFJPgajKF3zIjt7l
iMm5mrF42YzgYILM9m9r3v3AAjC7mtJ2vSqMZpt8L7/+LtS+cDTJiWkNK2eIrpWI
CbRz4jqEM7n+mz45Vk19WEczU7GQWojc1ENzjbwba9g+RLmtJd0cT+g7YWPxQJA/
/zOmL617Y52MKdPULY2i8fWRhAtpjWa7zcXd9hdw/c5MkSiKHlJEQ93vCz5A0a/1
ti6cyTEFik1o/NSJhWV9acU+RsoCP1GJNIGeGCL0W+PJTNEo9CzToEgmGgnHpK4B
XyDIPam+EHi7/vSrrRS6rfAYq1E5QdMlRQ5rsYhJKJbV+0vcXOKSiBPH7LwL+ukU
cm4lBW+YQxaDA0h6/rRHE+SV4EhhoYvzAkI5aIXac+MfN/E7LGWCv6TrrLkuisop
2JVs4wi3XqWfXqEIz2egknS95skUm1bfcLxAE15uFZLvFLOQBRt5EqX189XDD6wR
/5hJj7yMvkf1R8M83OBON72MIP0DKKTpuJogmvkT3yb4ExRtc3jtTsI5HuFS95f9
KuFC9nvwEwQ=
=zMw5
-----END PGP SIGNATURE-----

--Sig_/PshiCbE=HVVz52oDXJSsI0T--
