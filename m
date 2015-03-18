From: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v7 4/6] wlcore: add device-tree support
Date: Wed, 18 Mar 2015 18:38:28 +0200
Message-ID: <1426696710-6891-5-git-send-email-eliad@wizery.com>
References: <1426696710-6891-1-git-send-email-eliad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426696710-6891-1-git-send-email-eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

When running with device-tree, we no longer have a board file
that can set up the platform data for wlcore.
Allow this data to be passed from DT.

Signed-off-by: Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Tested-by: S=C3=A9bastien Szymanski <sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org>
---
 drivers/net/wireless/ti/wlcore/sdio.c | 93 +++++++++++++++++++++++++++=
+++++---
 1 file changed, 87 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wirele=
ss/ti/wlcore/sdio.c
index 2bce00a..b55dc0e 100644
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -34,6 +34,8 @@
 #include <linux/wl12xx.h>
 #include <linux/pm_runtime.h>
 #include <linux/printk.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
=20
 #include "wlcore.h"
 #include "wl12xx_80211.h"
@@ -214,6 +216,82 @@ static struct wl1271_if_operations sdio_ops =3D {
 	.set_block_size =3D wl1271_sdio_set_block_size,
 };
=20
+#ifdef CONFIG_OF
+static const struct of_device_id wlcore_sdio_of_match_table[] =3D {
+	{ .compatible =3D "ti,wl1271" },
+	{ .compatible =3D "ti,wl1273" },
+	{ .compatible =3D "ti,wl1281" },
+	{ .compatible =3D "ti,wl1283" },
+	{ .compatible =3D "ti,wl1801" },
+	{ .compatible =3D "ti,wl1805" },
+	{ .compatible =3D "ti,wl1807" },
+	{ .compatible =3D "ti,wl1831" },
+	{ .compatible =3D "ti,wl1835" },
+	{ .compatible =3D "ti,wl1837" },
+	{ }
+};
+
+static struct wl12xx_platform_data *wlcore_probe_of(struct device *dev=
)
+{
+	struct device_node *np =3D dev->of_node;
+	struct wl12xx_platform_data *pdata;
+
+	if (!np || !of_match_node(wlcore_sdio_of_match_table, np))
+		return NULL;
+
+	pdata =3D kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL;
+
+	pdata->irq =3D irq_of_parse_and_map(np, 0);
+	if (!pdata->irq) {
+		dev_err(dev, "No irq in platform data\n");
+		kfree(pdata);
+		return NULL;
+	}
+
+	pdata->irq_trigger =3D
+		irqd_get_trigger_type(irq_get_irq_data(pdata->irq));
+
+	/* optional clock frequency params */
+	of_property_read_u32(np, "ref-clock-frequency",
+			     &pdata->ref_clock_freq);
+	of_property_read_u32(np, "tcxo-clock-frequency",
+			     &pdata->tcxo_clock_freq);
+
+	return pdata;
+}
+#else
+static struct wl12xx_platform_data *wlcore_probe_of(struct device *dev=
)
+{
+	return NULL;
+}
+#endif
+
+static struct wl12xx_platform_data *
+wlcore_get_platform_data(struct device *dev)
+{
+	struct wl12xx_platform_data *pdata;
+
+	/* first, look for DT data */
+	pdata =3D wlcore_probe_of(dev);
+	if (pdata)
+		return pdata;
+
+	/* if not found - fallback to static platform data */
+	pdata =3D wl12xx_get_platform_data();
+	if (!IS_ERR(pdata))
+		return kmemdup(pdata, sizeof(*pdata), GFP_KERNEL);
+
+	dev_err(dev, "No platform data set\n");
+	return NULL;
+}
+
+static void wlcore_del_platform_data(struct wl12xx_platform_data *pdat=
a)
+{
+	kfree(pdata);
+}
+
 static int wl1271_probe(struct sdio_func *func,
 				  const struct sdio_device_id *id)
 {
@@ -245,12 +323,9 @@ static int wl1271_probe(struct sdio_func *func,
 	/* Use block mode for transferring over one block size of data */
 	func->card->quirks |=3D MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
=20
-	pdev_data.pdata =3D wl12xx_get_platform_data();
-	if (IS_ERR(pdev_data.pdata)) {
-		ret =3D PTR_ERR(pdev_data.pdata);
-		dev_err(glue->dev, "missing wlan platform data: %d\n", ret);
+	pdev_data.pdata =3D wlcore_get_platform_data(&func->dev);
+	if (!pdev_data.pdata)
 		goto out_free_glue;
-	}
=20
 	/* if sdio can keep power while host is suspended, enable wow */
 	mmcflags =3D sdio_get_host_pm_caps(func);
@@ -279,7 +354,7 @@ static int wl1271_probe(struct sdio_func *func,
 	if (!glue->core) {
 		dev_err(glue->dev, "can't allocate platform_device");
 		ret =3D -ENOMEM;
-		goto out_free_glue;
+		goto out_free_pdata;
 	}
=20
 	glue->core->dev.parent =3D &func->dev;
@@ -313,6 +388,9 @@ static int wl1271_probe(struct sdio_func *func,
 out_dev_put:
 	platform_device_put(glue->core);
=20
+out_free_pdata:
+	wlcore_del_platform_data(pdev_data.pdata);
+
 out_free_glue:
 	kfree(glue);
=20
@@ -323,11 +401,14 @@ out:
 static void wl1271_remove(struct sdio_func *func)
 {
 	struct wl12xx_sdio_glue *glue =3D sdio_get_drvdata(func);
+	struct wlcore_platdev_data *pdev_data =3D glue->core->dev.platform_da=
ta;
+	struct wl12xx_platform_data *pdata =3D pdev_data->pdata;
=20
 	/* Undo decrement done above in wl1271_probe */
 	pm_runtime_get_noresume(&func->dev);
=20
 	platform_device_unregister(glue->core);
+	wlcore_del_platform_data(pdata);
 	kfree(glue);
 }
=20
--=20
1.8.5.2.229.g4448466.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-wireles=
s" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
