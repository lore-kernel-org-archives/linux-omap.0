From: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>
Subject: Re: [PATCH/RESEND 8/9] drm/tilcdc: remove submodule destroy calls
Date: Wed, 25 Jun 2014 00:53:39 -0300
Message-ID: <20140625035339.GA9466@fox>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-9-git-send-email-guido@vanguardiasur.com.ar>
 <53A9F660.8060703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f53.google.com ([209.85.213.53]:48840 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbaFYDvb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2014 23:51:31 -0400
Received: by mail-yh0-f53.google.com with SMTP id b6so818787yha.40
        for <linux-omap@vger.kernel.org>; Tue, 24 Jun 2014 20:51:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53A9F660.8060703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Darren Etheridge <detheridge@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Daniel Vetter <daniel.vetter@ffwll.ch>, Daniel Mack <zonque@gmail.com>, Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>

On Tue, Jun 24, 2014 at 05:06:24PM -0500, Darren Etheridge wrote:
> Guido,
>=20
> On 06/17/2014 09:17 AM, Guido Mart=EDnez wrote:
> >The TI tilcdc driver is designed with a notion of submodules. Curren=
tly,
> >at unload time, these submodules are iterated and destroyed.
> >
> >Now that the tilcdc remove order is fixed, this can be handled perfe=
ctly
>=20
> I am not sure I understand the first part of the above sentence - did
> something change with tilcdc ordering?  I think you a referring to pr=
evious
> patches in your series which really mean tilcdc can actually unload n=
ow.
Right, I guess I got a bit dizzy while writing that commit log :). If w=
e
find the patch reasonable I'll send a better explanation.

> So really the method this patch uses could always have been used, it
> just wasn't for some reason?
Yes, I think so.

> I have tested all of the other patches in your series and all looks g=
ood on
> BeagleBone Black and AM335xEVM, I tested as both built-ins and module=
s and
> can load/unload on BeagleBone Black with HDMI enabled correctly.
Nice to hear that :)

> I want to play around a bit more with this particular patch, to try a=
nd
> understand how it differs from Rob's original intent with his module
> registration/deregistration scheme.  I prefer your method, but do we =
loose
> anything that Rob's originally had in mind?
Nothing really comes to mind, but I may be wrong on this...

Thanks a lot for your review!

> Darren
>=20
> >by the kernel using the device infrastructure, since each submodule
> >is a kernel driver itself, and they are only destroy()'ed at unload
> >time. Therefore we move the destroy() functionality to each submodul=
e's
> >remove().
> >
> >Also, remove some checks in the unloading process since the new code
> >guarantees the resources are allocated and need a release.
> >
> >Signed-off-by: Guido Mart=EDnez <guido@vanguardiasur.com.ar>
> >---
> >  drivers/gpu/drm/tilcdc/Module.symvers  |  0
> >  drivers/gpu/drm/tilcdc/tilcdc_drv.c    |  6 ------
> >  drivers/gpu/drm/tilcdc/tilcdc_drv.h    |  1 -
> >  drivers/gpu/drm/tilcdc/tilcdc_panel.c  | 36 +++++++++++++++++-----=
------------
> >  drivers/gpu/drm/tilcdc/tilcdc_slave.c  | 26 +++++++++++++---------=
--
> >  drivers/gpu/drm/tilcdc/tilcdc_tfp410.c | 34 ++++++++++++++++------=
----------
> >  6 files changed, 50 insertions(+), 53 deletions(-)
> >  create mode 100644 drivers/gpu/drm/tilcdc/Module.symvers
> >
> >diff --git a/drivers/gpu/drm/tilcdc/Module.symvers b/drivers/gpu/drm=
/tilcdc/Module.symvers
> >new file mode 100644
> >index 0000000..e69de29
> >diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/t=
ilcdc/tilcdc_drv.c
> >index 006a30e..2c860c4 100644
> >--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> >+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> >@@ -120,7 +120,6 @@ static int cpufreq_transition(struct notifier_bl=
ock *nb,
> >  static int tilcdc_unload(struct drm_device *dev)
> >  {
> >  	struct tilcdc_drm_private *priv =3D dev->dev_private;
> >-	struct tilcdc_module *mod, *cur;
> >
> >  	drm_fbdev_cma_fini(priv->fbdev);
> >  	drm_kms_helper_poll_fini(dev);
> >@@ -149,11 +148,6 @@ static int tilcdc_unload(struct drm_device *dev=
)
> >
> >  	pm_runtime_disable(dev->dev);
> >
> >-	list_for_each_entry_safe(mod, cur, &module_list, list) {
> >-		DBG("destroying module: %s", mod->name);
> >-		mod->funcs->destroy(mod);
> >-	}
> >-
> >  	kfree(priv);
> >
> >  	return 0;
> >diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.h b/drivers/gpu/drm/t=
ilcdc/tilcdc_drv.h
> >index 0938036..7596c14 100644
> >--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.h
> >+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
> >@@ -98,7 +98,6 @@ struct tilcdc_module;
> >  struct tilcdc_module_ops {
> >  	/* create appropriate encoders/connectors: */
> >  	int (*modeset_init)(struct tilcdc_module *mod, struct drm_device =
*dev);
> >-	void (*destroy)(struct tilcdc_module *mod);
> >  #ifdef CONFIG_DEBUG_FS
> >  	/* create debugfs nodes (can be NULL): */
> >  	int (*debugfs_init)(struct tilcdc_module *mod, struct drm_minor *=
minor);
> >diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm=
/tilcdc/tilcdc_panel.c
> >index b085dcc..2f6efae 100644
> >--- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
> >+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
> >@@ -282,21 +282,8 @@ static int panel_modeset_init(struct tilcdc_mod=
ule *mod, struct drm_device *dev)
> >  	return 0;
> >  }
> >
> >-static void panel_destroy(struct tilcdc_module *mod)
> >-{
> >-	struct panel_module *panel_mod =3D to_panel_module(mod);
> >-
> >-	if (panel_mod->timings)
> >-		display_timings_release(panel_mod->timings);
> >-
> >-	tilcdc_module_cleanup(mod);
> >-	kfree(panel_mod->info);
> >-	kfree(panel_mod);
> >-}
> >-
> >  static const struct tilcdc_module_ops panel_module_ops =3D {
> >  		.modeset_init =3D panel_modeset_init,
> >-		.destroy =3D panel_destroy,
> >  };
> >
> >  /*
> >@@ -372,6 +359,7 @@ static int panel_probe(struct platform_device *p=
dev)
> >  		return -ENOMEM;
> >
> >  	mod =3D &panel_mod->base;
> >+	pdev->dev.platform_data =3D mod;
> >
> >  	tilcdc_module_init(mod, "panel", &panel_module_ops);
> >
> >@@ -379,17 +367,16 @@ static int panel_probe(struct platform_device =
*pdev)
> >  	if (IS_ERR(pinctrl))
> >  		dev_warn(&pdev->dev, "pins are not configured\n");
> >
> >-
> >  	panel_mod->timings =3D of_get_display_timings(node);
> >  	if (!panel_mod->timings) {
> >  		dev_err(&pdev->dev, "could not get panel timings\n");
> >-		goto fail;
> >+		goto fail_free;
> >  	}
> >
> >  	panel_mod->info =3D of_get_panel_info(node);
> >  	if (!panel_mod->info) {
> >  		dev_err(&pdev->dev, "could not get panel info\n");
> >-		goto fail;
> >+		goto fail_timings;
> >  	}
> >
> >  	mod->preferred_bpp =3D panel_mod->info->bpp;
> >@@ -400,13 +387,26 @@ static int panel_probe(struct platform_device =
*pdev)
> >
> >  	return 0;
> >
> >-fail:
> >-	panel_destroy(mod);
> >+fail_timings:
> >+	display_timings_release(panel_mod->timings);
> >+
> >+fail_free:
> >+	kfree(panel_mod);
> >+	tilcdc_module_cleanup(mod);
> >  	return ret;
> >  }
> >
> >  static int panel_remove(struct platform_device *pdev)
> >  {
> >+	struct tilcdc_module *mod =3D dev_get_platdata(&pdev->dev);
> >+	struct panel_module *panel_mod =3D to_panel_module(mod);
> >+
> >+	display_timings_release(panel_mod->timings);
> >+
> >+	tilcdc_module_cleanup(mod);
> >+	kfree(panel_mod->info);
> >+	kfree(panel_mod);
> >+
> >  	return 0;
> >  }
> >
> >diff --git a/drivers/gpu/drm/tilcdc/tilcdc_slave.c b/drivers/gpu/drm=
/tilcdc/tilcdc_slave.c
> >index 2f83ffb..1e568ca 100644
> >--- a/drivers/gpu/drm/tilcdc/tilcdc_slave.c
> >+++ b/drivers/gpu/drm/tilcdc/tilcdc_slave.c
> >@@ -296,17 +296,8 @@ static int slave_modeset_init(struct tilcdc_mod=
ule *mod, struct drm_device *dev)
> >  	return 0;
> >  }
> >
> >-static void slave_destroy(struct tilcdc_module *mod)
> >-{
> >-	struct slave_module *slave_mod =3D to_slave_module(mod);
> >-
> >-	tilcdc_module_cleanup(mod);
> >-	kfree(slave_mod);
> >-}
> >-
> >  static const struct tilcdc_module_ops slave_module_ops =3D {
> >  		.modeset_init =3D slave_modeset_init,
> >-		.destroy =3D slave_destroy,
> >  };
> >
> >  /*
> >@@ -356,10 +347,13 @@ static int slave_probe(struct platform_device =
*pdev)
> >  	}
> >
> >  	slave_mod =3D kzalloc(sizeof(*slave_mod), GFP_KERNEL);
> >-	if (!slave_mod)
> >-		return -ENOMEM;
> >+	if (!slave_mod) {
> >+		ret =3D -ENOMEM;
> >+		goto fail_adapter;
> >+	}
> >
> >  	mod =3D &slave_mod->base;
> >+	pdev->dev.platform_data =3D mod;
> >
> >  	mod->preferred_bpp =3D slave_info.bpp;
> >
> >@@ -374,10 +368,20 @@ static int slave_probe(struct platform_device =
*pdev)
> >  	tilcdc_slave_probedefer(false);
> >
> >  	return 0;
> >+
> >+fail_adapter:
> >+	i2c_put_adapter(slavei2c);
> >+	return ret;
> >  }
> >
> >  static int slave_remove(struct platform_device *pdev)
> >  {
> >+	struct tilcdc_module *mod =3D dev_get_platdata(&pdev->dev);
> >+	struct slave_module *slave_mod =3D to_slave_module(mod);
> >+
> >+	tilcdc_module_cleanup(mod);
> >+	kfree(slave_mod);
> >+
> >  	return 0;
> >  }
> >
> >diff --git a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c b/drivers/gpu/dr=
m/tilcdc/tilcdc_tfp410.c
> >index ce75ac8..32a0d2d 100644
> >--- a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
> >+++ b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
> >@@ -296,23 +296,8 @@ static int tfp410_modeset_init(struct tilcdc_mo=
dule *mod, struct drm_device *dev
> >  	return 0;
> >  }
> >
> >-static void tfp410_destroy(struct tilcdc_module *mod)
> >-{
> >-	struct tfp410_module *tfp410_mod =3D to_tfp410_module(mod);
> >-
> >-	if (tfp410_mod->i2c)
> >-		i2c_put_adapter(tfp410_mod->i2c);
> >-
> >-	if (!IS_ERR_VALUE(tfp410_mod->gpio))
> >-		gpio_free(tfp410_mod->gpio);
> >-
> >-	tilcdc_module_cleanup(mod);
> >-	kfree(tfp410_mod);
> >-}
> >-
> >  static const struct tilcdc_module_ops tfp410_module_ops =3D {
> >  		.modeset_init =3D tfp410_modeset_init,
> >-		.destroy =3D tfp410_destroy,
> >  };
> >
> >  /*
> >@@ -342,6 +327,7 @@ static int tfp410_probe(struct platform_device *=
pdev)
> >  		return -ENOMEM;
> >
> >  	mod =3D &tfp410_mod->base;
> >+	pdev->dev.platform_data =3D mod;
> >
> >  	tilcdc_module_init(mod, "tfp410", &tfp410_module_ops);
> >
> >@@ -365,6 +351,7 @@ static int tfp410_probe(struct platform_device *=
pdev)
> >  	tfp410_mod->i2c =3D of_find_i2c_adapter_by_node(i2c_node);
> >  	if (!tfp410_mod->i2c) {
> >  		dev_err(&pdev->dev, "could not get i2c\n");
> >+		of_node_put(i2c_node);
> >  		goto fail;
> >  	}
> >
> >@@ -378,19 +365,32 @@ static int tfp410_probe(struct platform_device=
 *pdev)
> >  		ret =3D gpio_request(tfp410_mod->gpio, "DVI_PDn");
> >  		if (ret) {
> >  			dev_err(&pdev->dev, "could not get DVI_PDn gpio\n");
> >-			goto fail;
> >+			goto fail_adapter;
> >  		}
> >  	}
> >
> >  	return 0;
> >
> >+fail_adapter:
> >+	i2c_put_adapter(tfp410_mod->i2c);
> >+
> >  fail:
> >-	tfp410_destroy(mod);
> >+	kfree(tfp410_mod);
> >+	tilcdc_module_cleanup(mod);
> >  	return ret;
> >  }
> >
> >  static int tfp410_remove(struct platform_device *pdev)
> >  {
> >+	struct tilcdc_module *mod =3D dev_get_platdata(&pdev->dev);
> >+	struct tfp410_module *tfp410_mod =3D to_tfp410_module(mod);
> >+
> >+	i2c_put_adapter(tfp410_mod->i2c);
> >+	gpio_free(tfp410_mod->gpio);
> >+
> >+	tilcdc_module_cleanup(mod);
> >+	kfree(tfp410_mod);
> >+
> >  	return 0;
> >  }
> >
> >

--=20
Guido Mart=EDnez, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
