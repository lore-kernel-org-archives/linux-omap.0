From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [alsa-devel] [PATCH RFC v3 0/8] Beaglebone-Black HDMI audio
Date: Thu, 30 Jan 2014 19:00:11 +0100
Message-ID: <20140130190011.3849cf37@armhf>
References: <y>
	<cover.1390836773.git.jsarha@ti.com>
	<52E6806A.2090109@metafoo.de>
	<52E686B2.9060806@ti.com>
	<20140127190641.273890c6@armhf>
	<52E6B42F.4050901@ti.com>
	<20140128102353.48e8fb51@armhf>
	<52EA43A8.9050909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:38930 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbaA3SAJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jan 2014 13:00:09 -0500
In-Reply-To: <52EA43A8.9050909@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Lars-Peter Clausen <lars@metafoo.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, broonie@kernel.org, peter.ujfalusi@ti.com, detheridge@ti.com

On Thu, 30 Jan 2014 14:20:56 +0200
Jyri Sarha <jsarha@ti.com> wrote:

> I am having trouble getting the tda998x-codec working on BBB. The=20
> problem is I do not have a DT node for the tda998x driver. Instead I=20
> have tilcdc-slave node that provides pdata for the tda-driver.
>=20
> I am thinking of solving the problem by adding a reference to the=20
> i2c-adapter hosting tda998x as an optional DT property to the codec=20
> node. I could then dig the driver instance from the i2c adapter's=20
> children. Any better ideas?

I better think about a 'normal' DT definition:

- in the DT, define the tda998x in a i2c subnode:

  &i2c0 {
	tda998x: hdmi-encoder {
		compatible =3D "nxp,tda998x";
		reg =3D <0x70>;
		/* the video ports are OK by default */
		/* define the interrupt if you want to use it */
	};
  };

- in tilcdc_slave.c, in the function slave_encoder_create(), instead of
  using drm_i2c_encoder_init(), do quite the same, but without calling
  request_module() nor i2c_new_device().

  This can be done as follows (the code is not compiled):

--------------------8<---------------------
static struct drm_encoder *slave_encoder_create(struct drm_device *dev,
		struct slave_module *mod)
{
	struct slave_encoder *slave_encoder;
	struct drm_encoder *encoder;
	int ret;
/* ------ added ------ */
	struct device_node *np;
	static const struct of_device_id tda_dt[] =3D {
		{ .compatible =3D "nxp,tda998x" },
		{ },
	};
/* ------ end added ------ */

	... no change ...

	 drm_encoder_helper_add(encoder, &slave_encoder_helper_funcs);

/* ------ added ------ */

	/* search the tda998x device */
	np =3D of_find_matching_node_and_match(NULL, tda_dt, NULL);
	if (np && of_device_is_available(np)) {
		struct i2c_client *i2c_client;
		struct drm_i2c_encoder_driver *encoder_drv;
		struct module *module;

					/* the tda998x is in the DT */

		i2c_client =3D of_find_i2c_device_by_node(np);
		of_node_put(np);
		if (!i2c_client) {
			dev_err(dev->dev, "no tda998x i2c client\n");
			goto fail;
		}

		to_encoder_slave(encoder)->bus_priv =3D i2c_client;

		encoder_drv =3D to_drm_i2c_encoder_driver(
				to_i2c_driver(i2c_client->dev.driver));

		/* lock the tda998x module in memory */
		module =3D to_i2c_driver(i2c_client->dev.driver)->driver.owner;
		if (!module || !try_module_get(module)) {
			dev_err(dev->dev, "cannot get module %s\n", module->name);
			goto fail;
		}

		ret =3D encoder_drv->encoder_init(i2c_client, dev, encoder_slave);
		if (ret < 0) {
			dev_err(dev->dev, "slave encoder init failed\n");
			module_put(module);
			goto fail;
		}
					/* set_config is useless */
		return encoder;
	}

/* ------ end added ------ */

	ret =3D drm_i2c_encoder_init(dev, to_encoder_slave(encoder), mod->i2c,=
 &info);
	if (ret)
		goto fail;

	return encoder;

fail:
	slave_encoder_destroy(encoder);
	return NULL;
}
--------------------8<---------------------

When the tda998x is in the DT, the i2c_client is already created.
It must not be freed, and so, the function drm_i2c_encoder_destroy()
must not be called. But, the module must be explicitly unlocked in
slave_encoder_destroy(), and then, there must be some flag in the
structures for this job to be done...

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
