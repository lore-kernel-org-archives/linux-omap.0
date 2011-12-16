From: NeilBrown <neilb@suse.de>
Subject: Re: problem with twl4030 GPIO irqs
Date: Fri, 16 Dec 2011 11:50:32 +1100
Message-ID: <20111216115032.4c4dfbb5@notabene.brown>
References: <CANOLnON1-vg45KWZ7Rp+jL1n-jwBiTA2Qmkr_z1XnDKQ0XBPJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/8CKfIBD=JFSWT3Pf.zsKonA"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44523 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752620Ab1LPAur (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Dec 2011 19:50:47 -0500
In-Reply-To: <CANOLnON1-vg45KWZ7Rp+jL1n-jwBiTA2Qmkr_z1XnDKQ0XBPJw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

--Sig_/8CKfIBD=JFSWT3Pf.zsKonA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Dec 2011 02:03:51 +0200 Grazvydas Ignotas <notasas@gmail.com>
wrote:

> Hi,
>=20
> I'm running 3.2-rc5 on pandora with Neil's twl patches on top, and
> omap_hsmmc driver fails to probe:
> [    3.491394] omap_hsmmc omap_hsmmc.0: context was not lost
> [    3.497161] omap_hsmmc omap_hsmmc.0: enabled
> [    3.715270] omap_hsmmc omap_hsmmc.0: Unable to grab MMC CD IRQ
>=20
> Pandora is using twl4030 GPIOs for card detect. From what I tried to
> debug, omap_hsmmc is failing after call to request_irq() on card
> detect irq with -EINVAL, irq number is 384 which is in range of other
> twl4030 irqs. It looks like request_irq() is calling
> request_threaded_irq() on ARM with NULL thread_fn, which in turn calls
> __setup_irq() that calls irq_settings_is_nested_thread() that results
> with true. As this nested flag is set it checks thread_fn, but that is
> NULL causing -EINVAL final result.
>=20
> Could someone who knows irq code better look at this? I think this
> should reproduce on beagle too.
>=20
>=20

Try this.

I wrote it for a slightly different reason, but I think it applies here.

NeilBrown

=46rom f7f05b87364d0316f1f6ddad0d7387b25f5d21b9 Mon Sep 17 00:00:00 2001
From: NeilBrown <neilb@suse.de>
Date: Fri, 2 Dec 2011 15:35:16 +1100
Subject: [PATCH] omap_hsmmc - use threaded irq handler for card-detect.

The the card-detect irq handler just schedules work to be done by
a thread, we can use request_threaded_irq to do much of the work for
us.

Signed-off-by: NeilBrown <neilb@suse.de>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 101cd31..d72c181 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -24,7 +24,6 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
-#include <linux/workqueue.h>
 #include <linux/timer.h>
 #include <linux/clk.h>
 #include <linux/mmc/host.h>
@@ -163,7 +162,6 @@ struct omap_hsmmc_host {
 	 */
 	struct	regulator	*vcc;
 	struct	regulator	*vcc_aux;
-	struct	work_struct	mmc_carddetect_work;
 	void	__iomem		*base;
 	resource_size_t		mapbase;
 	spinlock_t		irq_lock; /* Prevent races with irq handler */
@@ -1279,17 +1277,16 @@ static void omap_hsmmc_protect_card(struct omap_hsm=
mc_host *host)
 }
=20
 /*
- * Work Item to notify the core about card insertion/removal
+ * irq handler to notify the core about card insertion/removal
  */
-static void omap_hsmmc_detect(struct work_struct *work)
+static irqreturn_t omap_hsmmc_detect(int irq, void *dev_id)
 {
-	struct omap_hsmmc_host *host =3D
-		container_of(work, struct omap_hsmmc_host, mmc_carddetect_work);
+	struct omap_hsmmc_host *host =3D dev_id;
 	struct omap_mmc_slot_data *slot =3D &mmc_slot(host);
 	int carddetect;
=20
 	if (host->suspended)
-		return;
+		return IRQ_HANDLED;
=20
 	sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
=20
@@ -1304,19 +1301,6 @@ static void omap_hsmmc_detect(struct work_struct *wo=
rk)
 		mmc_detect_change(host->mmc, (HZ * 200) / 1000);
 	else
 		mmc_detect_change(host->mmc, (HZ * 50) / 1000);
-}
-
-/*
- * ISR for handling card insertion and removal
- */
-static irqreturn_t omap_hsmmc_cd_handler(int irq, void *dev_id)
-{
-	struct omap_hsmmc_host *host =3D (struct omap_hsmmc_host *)dev_id;
-
-	if (host->suspended)
-		return IRQ_HANDLED;
-	schedule_work(&host->mmc_carddetect_work);
-
 	return IRQ_HANDLED;
 }
=20
@@ -1916,7 +1900,6 @@ static int __init omap_hsmmc_probe(struct platform_de=
vice *pdev)
 	host->next_data.cookie =3D 1;
=20
 	platform_set_drvdata(pdev, host);
-	INIT_WORK(&host->mmc_carddetect_work, omap_hsmmc_detect);
=20
 	mmc->ops	=3D &omap_hsmmc_ops;
=20
@@ -2044,10 +2027,11 @@ static int __init omap_hsmmc_probe(struct platform_=
device *pdev)
=20
 	/* Request IRQ for card detect */
 	if ((mmc_slot(host).card_detect_irq)) {
-		ret =3D request_irq(mmc_slot(host).card_detect_irq,
-				  omap_hsmmc_cd_handler,
-				  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				  mmc_hostname(mmc), host);
+		ret =3D request_threaded_irq(mmc_slot(host).card_detect_irq,
+					   NULL,
+					   omap_hsmmc_detect,
+					   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+					   mmc_hostname(mmc), host);
 		if (ret) {
 			dev_dbg(mmc_dev(host->mmc),
 				"Unable to grab MMC CD IRQ\n");
@@ -2126,7 +2110,6 @@ static int omap_hsmmc_remove(struct platform_device *=
pdev)
 		free_irq(host->irq, host);
 		if (mmc_slot(host).card_detect_irq)
 			free_irq(mmc_slot(host).card_detect_irq, host);
-		flush_work_sync(&host->mmc_carddetect_work);
=20
 		pm_runtime_put_sync(host->dev);
 		pm_runtime_disable(host->dev);
@@ -2173,7 +2156,6 @@ static int omap_hsmmc_suspend(struct device *dev)
 				return ret;
 			}
 		}
-		cancel_work_sync(&host->mmc_carddetect_work);
 		ret =3D mmc_suspend_host(host->mmc);
=20
 		if (ret =3D=3D 0) {

--Sig_/8CKfIBD=JFSWT3Pf.zsKonA
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTuqV2Tnsnt1WYoG5AQIr8RAAhL8tFhZ95Y2WQesXoWZP6+gpEUWaM5Dt
d34FT/Orss27rhB+IaIDjgyw0mUU/VAm9KWqutpTplHB0ciQeyk7/pdaaeaj2bVx
XiNW5GOGdbUxmMPovN+EAvC6chk2i3GJ6Re31Fyq5jm8OW33p5IOG8LcEISFgf3L
FRXBKVgwTYC7XxD07SHXM2Gpk0PrzC8ERyxrhS9BGqy1yaTEMu60srHsZdoEH3E7
S5hLitJ/bBjVObGySyXljnQa/eN1ZTDfP0EZSeF9I090KpFEirozjKAC3/8vcpA4
bx/4FIlM0mo/07/gtROaReKZJvIKyx01kyrkNxJXTO6nZzwVU0sTPGGaKWrWo55p
DyEVU/mIzyOtS0fe/gruMdw7fIG3qIRQjPLSF2Ok0qsvoYV298gYMdIwbScHi+ZK
jhjrgGJYccyPzFrQ//TMv+LW6+A82U514z8PRLyWdqR7tiVxqSLsBHjlscXnJqqf
tkF4j2B2TbNtOih9t5gdy7vg0B3nxx6TCq2YxbmuMMeJZ4nzdhMcA0Xv8WoCLJlo
A9jVI+5qsvTBrsTSc6SRhDoPvSKbIy7tnfLore4G2GmzxWp/LmLv8NfGojj3kzzX
POlikVShjJ25NDEro0DQ8loXEw6fDKdnuZMw6ULpTDbIaFBLgUpH8w85004kelz3
ye89v3RKi/g=
=jfsK
-----END PGP SIGNATURE-----

--Sig_/8CKfIBD=JFSWT3Pf.zsKonA--
