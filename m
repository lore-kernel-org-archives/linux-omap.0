From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH 8/9] drm/tilcdc: remove submodule destroy calls
Date: Sat,  7 Jun 2014 00:02:07 -0300
Message-ID: <1402110128-30471-9-git-send-email-guido@vanguardiasur.com.ar>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:61688 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbaFGDCF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2014 23:02:05 -0400
Received: by mail-vc0-f172.google.com with SMTP id lf12so4104790vcb.17
        for <linux-omap@vger.kernel.org>; Fri, 06 Jun 2014 20:02:04 -0700 (PDT)
In-Reply-To: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, David Airlie <airlied@linux.ie>, Russell King <linux@arm.linux.org.uk>, Rob Clark <robdclark@gmail.com>, Tony Lindgren <tony@atomide.com>, Daniel Mack <zonque@gmail.com>, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>

The TI tilcdc driver is designed with a notion of submodules. Currently=
,
at unload time, these submodules are iterated and destroyed.

Now that the tilcdc remove order is fixed, this can be handled perfectl=
y
by the kernel using the device infrastructure, since each submodule
is a kernel driver itself, and they are only destroy()'ed at unload
time. Therefore we move the destroy() functionality to each submodule's
remove().

Also, remove some checks in the unloading process since the new code
guarantees the resources are allocated and need a release.

Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
---
 drivers/gpu/drm/tilcdc/Module.symvers  |  0
 drivers/gpu/drm/tilcdc/tilcdc_drv.c    |  6 ------
 drivers/gpu/drm/tilcdc/tilcdc_drv.h    |  1 -
 drivers/gpu/drm/tilcdc/tilcdc_panel.c  | 36 +++++++++++++++++---------=
--------
 drivers/gpu/drm/tilcdc/tilcdc_slave.c  | 26 +++++++++++++-----------
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c | 34 ++++++++++++++++----------=
------
 6 files changed, 50 insertions(+), 53 deletions(-)
 create mode 100644 drivers/gpu/drm/tilcdc/Module.symvers

diff --git a/drivers/gpu/drm/tilcdc/Module.symvers b/drivers/gpu/drm/ti=
lcdc/Module.symvers
new file mode 100644
index 0000000..e69de29
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilc=
dc/tilcdc_drv.c
index 0644429..702315f 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -120,7 +120,6 @@ static int cpufreq_transition(struct notifier_block=
 *nb,
 static int tilcdc_unload(struct drm_device *dev)
 {
 	struct tilcdc_drm_private *priv =3D dev->dev_private;
-	struct tilcdc_module *mod, *cur;
=20
 	drm_fbdev_cma_fini(priv->fbdev);
 	drm_kms_helper_poll_fini(dev);
@@ -149,11 +148,6 @@ static int tilcdc_unload(struct drm_device *dev)
=20
 	pm_runtime_disable(dev->dev);
=20
-	list_for_each_entry_safe(mod, cur, &module_list, list) {
-		DBG("destroying module: %s", mod->name);
-		mod->funcs->destroy(mod);
-	}
-
 	kfree(priv);
=20
 	return 0;
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.h b/drivers/gpu/drm/tilc=
dc/tilcdc_drv.h
index 0938036..7596c14 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.h
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
@@ -98,7 +98,6 @@ struct tilcdc_module;
 struct tilcdc_module_ops {
 	/* create appropriate encoders/connectors: */
 	int (*modeset_init)(struct tilcdc_module *mod, struct drm_device *dev=
);
-	void (*destroy)(struct tilcdc_module *mod);
 #ifdef CONFIG_DEBUG_FS
 	/* create debugfs nodes (can be NULL): */
 	int (*debugfs_init)(struct tilcdc_module *mod, struct drm_minor *mino=
r);
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/ti=
lcdc/tilcdc_panel.c
index b085dcc..2f6efae 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
@@ -282,21 +282,8 @@ static int panel_modeset_init(struct tilcdc_module=
 *mod, struct drm_device *dev)
 	return 0;
 }
=20
-static void panel_destroy(struct tilcdc_module *mod)
-{
-	struct panel_module *panel_mod =3D to_panel_module(mod);
-
-	if (panel_mod->timings)
-		display_timings_release(panel_mod->timings);
-
-	tilcdc_module_cleanup(mod);
-	kfree(panel_mod->info);
-	kfree(panel_mod);
-}
-
 static const struct tilcdc_module_ops panel_module_ops =3D {
 		.modeset_init =3D panel_modeset_init,
-		.destroy =3D panel_destroy,
 };
=20
 /*
@@ -372,6 +359,7 @@ static int panel_probe(struct platform_device *pdev=
)
 		return -ENOMEM;
=20
 	mod =3D &panel_mod->base;
+	pdev->dev.platform_data =3D mod;
=20
 	tilcdc_module_init(mod, "panel", &panel_module_ops);
=20
@@ -379,17 +367,16 @@ static int panel_probe(struct platform_device *pd=
ev)
 	if (IS_ERR(pinctrl))
 		dev_warn(&pdev->dev, "pins are not configured\n");
=20
-
 	panel_mod->timings =3D of_get_display_timings(node);
 	if (!panel_mod->timings) {
 		dev_err(&pdev->dev, "could not get panel timings\n");
-		goto fail;
+		goto fail_free;
 	}
=20
 	panel_mod->info =3D of_get_panel_info(node);
 	if (!panel_mod->info) {
 		dev_err(&pdev->dev, "could not get panel info\n");
-		goto fail;
+		goto fail_timings;
 	}
=20
 	mod->preferred_bpp =3D panel_mod->info->bpp;
@@ -400,13 +387,26 @@ static int panel_probe(struct platform_device *pd=
ev)
=20
 	return 0;
=20
-fail:
-	panel_destroy(mod);
+fail_timings:
+	display_timings_release(panel_mod->timings);
+
+fail_free:
+	kfree(panel_mod);
+	tilcdc_module_cleanup(mod);
 	return ret;
 }
=20
 static int panel_remove(struct platform_device *pdev)
 {
+	struct tilcdc_module *mod =3D dev_get_platdata(&pdev->dev);
+	struct panel_module *panel_mod =3D to_panel_module(mod);
+
+	display_timings_release(panel_mod->timings);
+
+	tilcdc_module_cleanup(mod);
+	kfree(panel_mod->info);
+	kfree(panel_mod);
+
 	return 0;
 }
=20
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_slave.c b/drivers/gpu/drm/ti=
lcdc/tilcdc_slave.c
index 28c8478..9e4b0b2 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_slave.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_slave.c
@@ -306,17 +306,8 @@ static int slave_modeset_init(struct tilcdc_module=
 *mod, struct drm_device *dev)
 	return 0;
 }
=20
-static void slave_destroy(struct tilcdc_module *mod)
-{
-	struct slave_module *slave_mod =3D to_slave_module(mod);
-
-	tilcdc_module_cleanup(mod);
-	kfree(slave_mod);
-}
-
 static const struct tilcdc_module_ops slave_module_ops =3D {
 		.modeset_init =3D slave_modeset_init,
-		.destroy =3D slave_destroy,
 };
=20
 /*
@@ -366,10 +357,13 @@ static int slave_probe(struct platform_device *pd=
ev)
 	}
=20
 	slave_mod =3D kzalloc(sizeof(*slave_mod), GFP_KERNEL);
-	if (!slave_mod)
-		return -ENOMEM;
+	if (!slave_mod) {
+		ret =3D -ENOMEM;
+		goto fail_adapter;
+	}
=20
 	mod =3D &slave_mod->base;
+	pdev->dev.platform_data =3D mod;
=20
 	mod->preferred_bpp =3D slave_info.bpp;
=20
@@ -384,10 +378,20 @@ static int slave_probe(struct platform_device *pd=
ev)
 	tilcdc_slave_probedefer(false);
=20
 	return 0;
+
+fail_adapter:
+	i2c_put_adapter(slavei2c);
+	return ret;
 }
=20
 static int slave_remove(struct platform_device *pdev)
 {
+	struct tilcdc_module *mod =3D dev_get_platdata(&pdev->dev);
+	struct slave_module *slave_mod =3D to_slave_module(mod);
+
+	tilcdc_module_cleanup(mod);
+	kfree(slave_mod);
+
 	return 0;
 }
=20
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c b/drivers/gpu/drm/t=
ilcdc/tilcdc_tfp410.c
index ce75ac8..32a0d2d 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
@@ -296,23 +296,8 @@ static int tfp410_modeset_init(struct tilcdc_modul=
e *mod, struct drm_device *dev
 	return 0;
 }
=20
-static void tfp410_destroy(struct tilcdc_module *mod)
-{
-	struct tfp410_module *tfp410_mod =3D to_tfp410_module(mod);
-
-	if (tfp410_mod->i2c)
-		i2c_put_adapter(tfp410_mod->i2c);
-
-	if (!IS_ERR_VALUE(tfp410_mod->gpio))
-		gpio_free(tfp410_mod->gpio);
-
-	tilcdc_module_cleanup(mod);
-	kfree(tfp410_mod);
-}
-
 static const struct tilcdc_module_ops tfp410_module_ops =3D {
 		.modeset_init =3D tfp410_modeset_init,
-		.destroy =3D tfp410_destroy,
 };
=20
 /*
@@ -342,6 +327,7 @@ static int tfp410_probe(struct platform_device *pde=
v)
 		return -ENOMEM;
=20
 	mod =3D &tfp410_mod->base;
+	pdev->dev.platform_data =3D mod;
=20
 	tilcdc_module_init(mod, "tfp410", &tfp410_module_ops);
=20
@@ -365,6 +351,7 @@ static int tfp410_probe(struct platform_device *pde=
v)
 	tfp410_mod->i2c =3D of_find_i2c_adapter_by_node(i2c_node);
 	if (!tfp410_mod->i2c) {
 		dev_err(&pdev->dev, "could not get i2c\n");
+		of_node_put(i2c_node);
 		goto fail;
 	}
=20
@@ -378,19 +365,32 @@ static int tfp410_probe(struct platform_device *p=
dev)
 		ret =3D gpio_request(tfp410_mod->gpio, "DVI_PDn");
 		if (ret) {
 			dev_err(&pdev->dev, "could not get DVI_PDn gpio\n");
-			goto fail;
+			goto fail_adapter;
 		}
 	}
=20
 	return 0;
=20
+fail_adapter:
+	i2c_put_adapter(tfp410_mod->i2c);
+
 fail:
-	tfp410_destroy(mod);
+	kfree(tfp410_mod);
+	tilcdc_module_cleanup(mod);
 	return ret;
 }
=20
 static int tfp410_remove(struct platform_device *pdev)
 {
+	struct tilcdc_module *mod =3D dev_get_platdata(&pdev->dev);
+	struct tfp410_module *tfp410_mod =3D to_tfp410_module(mod);
+
+	i2c_put_adapter(tfp410_mod->i2c);
+	gpio_free(tfp410_mod->gpio);
+
+	tilcdc_module_cleanup(mod);
+	kfree(tfp410_mod);
+
 	return 0;
 }
=20
--=20
2.0.0.rc2

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
