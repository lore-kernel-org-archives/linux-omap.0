Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC0952F294;
	Tue, 22 Sep 2026 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072347; cv=none; b=HYFcXxE6Kuevuat6+iinNLxkl+y4V9axBMckzRUkxvTr95fpShmtaeMhykjhz5KOlsmtP2qSqMxlL15ZYOVkRRPSEQZAUu+8VR4Yv7iuhZL2MXgmWOVlfBiey1au35TTzY54kxYmhsPltfZywMH/VZLLv8YepPIz04aXuPn/ouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072347; c=relaxed/simple;
	bh=U6nEAncarF04gBX0K2yID3ID7i4onnj70LFz7Tqwzf8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=diDeoIgtIWRVHGa5RjtqkueWAdlQ0jgmLXOaz0/j9J4+jLhIb7nLmE2B+8F5mp8KB5HnIIC8UTgclbNjbd2/s2DSOV15aiSYDWMModEbdWUR7Q0svqjajgyA0VmcvWUV+lKZiBtX8nYiiPV0QF6fhJVl1IBmcuyoVB3gvaJQGag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=YpydLbbd; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="YpydLbbd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=7+4D1ZWujrVYGEarDtTZ0KiIPF0wvGcfoxM/2VYhpL8=; t=1790072345; x=1791281945; 
	b=YpydLbbdnm8MfiPXsii0WKc36ch03P1Kz4G2oC014Th4JcCE7i166bkZ50CTakp7UBJzZhyORGV
	QI2g0fpHVorcwLKIQmeq6Qfm3rtqiJaJTJHI3ew7CWCgDey1Y97L9Y4dzFicJE86VgNJ+V5d7Xx4M
	p4RvDWiUSbFbXjIdEnHFy+TJz+bDRvT3pOHQVh5ExqjT+VwdpLmf5tX9JOmjvlOLK9ZEgjiZBHHXN
	qwMNauZsMTe1jbA0R3gJGDOYow7FHaf7SnmKBTIiBQRqf/rdXVk93Y/Cwd/mvgd4WGMm225M42fos
	oFdiDV7kINSZ+xj+9MHK2P0gcZAPDcZipIBw==;
Date: Tue, 22 Sep 2026 12:18:45 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Marek Vasut <marex@denx.de>, Aaro Koskinen
 <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, hns@goldelico.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH RFC 2/9] drm: panel: Add panel for Epson Moverio BT200
Message-ID: <20260922121845.1cb6cca0@kemnade.info>
In-Reply-To: <arJDcpvQlIMIGJaP@monoceros>
References: <20260922-b2-panel-via-bridge-v1-0-45ff36b364cf@kemnade.info>
	<20260922-b2-panel-via-bridge-v1-2-45ff36b364cf@kemnade.info>
	<arJDcpvQlIMIGJaP@monoceros>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Sep 2026 11:13:36 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hallo Andreas,
>=20
> On Tue, Sep 22, 2026 at 08:16:59AM +0200, Andreas Kemnade wrote:
> > diff --git a/drivers/gpu/drm/panel/panel-epson-bt200.c b/drivers/gpu/dr=
m/panel/panel-epson-bt200.c
> > new file mode 100644
> > index 000000000000..c26a4f8ae15e
> > --- /dev/null
> > +++ b/drivers/gpu/drm/panel/panel-epson-bt200.c
> > @@ -0,0 +1,251 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +#include <linux/backlight.h>
> > +#include <linux/errno.h>
> > +#include <linux/delay.h>
> > +#include <linux/module.h>
> > +#include <linux/mod_devicetable.h> =20
>=20
> Please don't include <linux/mod_devicetable.h>. You can rely on
> <linux/spi/spi.h> to provide of_device_id and spi_device_id; or if you
> prefer full iwyu include <linux/device-id/of.h> and <.../spi.h>.
>=20
> > +#include <linux/spi/spi.h>
> > +
> > +#include <drm/drm_connector.h>
> > +#include <drm/drm_modes.h>
> > +#include <drm/drm_panel.h>
> > +#include <drm/drm_print.h>
> > +#include <drm/drm_probe_helper.h>
> > +
> > +static const struct drm_display_mode default_mode =3D {
> > +	.clock			=3D 41600,	/* kHz */
> > +#if 0 =20
>=20
> huh, upstream code isn't supposed to have #if 0 blocks.
>=20
correct, this will go away latest in the first non-rfc series.

> > +	/* values matching struct omap_video_timings in vendor kernel */
> > +	.hdisplay		=3D 960,
> > +	.hsync_start		=3D 960 + 176,
> > +	.hsync_end		=3D 960 + 176 + 20,
> > +	.htotal			=3D 960 + 176 + 20 + 86,
> > +#else
> > +	/* values from what is writted to LCDCTRL on vendor kernel */
> > +	.hdisplay		=3D 960,
> > +	.hsync_start		=3D 960 + 33,
> > +	.hsync_end		=3D 960 + 33 + 20,
> > +	.htotal			=3D 960 + 33 + 20 + 86,
> > +#endif
> > +	.vdisplay		=3D 540,
> > +	.vsync_start		=3D 540 + 9,
> > +	.vsync_end		=3D 540 + 9 + 3,
> > +	.vtotal			=3D 540 + 9 + 3 + 12,
> > +	.flags			=3D 0,
> > +};
> > +
> > +struct bt200_panel {
> > +	struct drm_panel panel;
> > +	struct spi_device *spi;
> > +};
> > +
> > +static int bt200_panel_write(struct bt200_panel *ctx, u8 addr, u8 data)
> > +{
> > +	u8 val[2];
> > +
> > +	val[0] =3D addr;
> > +	val[1] =3D data;
> > +
> > +	return spi_write(ctx->spi, val, sizeof(val));
> > +}
> > +
> > +static inline struct bt200_panel *panel_to_bt200(struct drm_panel *pan=
el)
> > +{
> > +	return container_of(panel, struct bt200_panel, panel);
> > +}
> > +
> > +static int bt200_disable(struct drm_panel *panel)
> > +{
> > +	struct bt200_panel *ctx =3D panel_to_bt200(panel);
> > +
> > +	bt200_panel_write(ctx, 0x0A, 0);
> > +	return 0;
> > +}
> > +
> > +static int bt200_unprepare(struct drm_panel *panel)
> > +{
> > +	return 0;
> > +}
> > +
> > +/* found this table in vendor kernel */
> > +static struct {
> > +	u8 addr;
> > +	u8 data;
> > +} lcddr_init[] =3D {
> > +	{0x01, 0x00}, {0x02, 0x00}, {0x03, 0x00}, {0x05, 0x01},
> > +	{0x07, 0x00}, {0x0A, 0x00}, {0x10, 0x03}, {0x11, 0x44},
> > +	{0x12, 0x44}, {0x13, 0x55}, {0x14, 0x03}, {0x15, 0x00},
> > +	{0x16, 0x2A}, {0x17, 0x20}, {0x18, 0x00}, {0x19, 0x10},
> > +	{0x1A, 0x12}, {0x1B, 0x0E}, {0x1C, 0x0F}, {0x1D, 0x10},
> > +	{0x1E, 0x0F}, {0x1F, 0x1B}, {0x20, 0x0F}, {0x21, 0x00},
> > +	{0x22, 0x00}, {0x23, 0x00}, {0x24, 0x00}, {0x28, 0x14},
> > +	{0x29, 0x19}, {0x2A, 0x17}, {0x2B, 0x2B}, {0x2C, 0x99},
> > +	{0x2D, 0x13}, {0x2E, 0x2A}, {0x30, 0x0B}, {0x31, 0x00},
> > +	{0x32, 0x00}, {0x33, 0x01}, {0x34, 0x00}, {0x35, 0x0B},
> > +	{0x36, 0x04}, {0x37, 0x21}, {0x38, 0x00}, {0x39, 0x46},
> > +	{0x3A, 0x01}, {0x3B, 0x06}, {0x3C, 0x03}, {0x3D, 0x00},
> > +	{0x3E, 0x06}, {0x3F, 0x04}, {0x40, 0x00}, {0x41, 0x0D},
> > +	{0x42, 0x00}, {0x43, 0x2E}, {0x45, 0x08}, {0x46, 0x00},
> > +	{0x47, 0x01}, {0x48, 0x00}, {0x49, 0x00}, {0x4A, 0x0B},
> > +	{0x4B, 0x38}, {0x4C, 0x03}, {0x4D, 0x04}, {0x50, 0x0F},
> > +	{0x51, 0x04}, {0x52, 0x01}, {0x53, 0x0E}, {0x54, 0x11},
> > +	{0x55, 0x9F}, {0x56, 0x36}, {0x57, 0x00}, {0x58, 0x68},
> > +	{0x59, 0x01}, {0x5A, 0xE0}, {0x5B, 0x00}, {0x5C, 0x00},
> > +	{0x5D, 0x10}, {0x5E, 0x36}, {0x5F, 0x36}, {0x60, 0x00},
> > +	{0x61, 0x04}, {0x62, 0x12}, {0x63, 0x00}, {0x64, 0x80},
> > +	{0x65, 0x00}, {0x66, 0x80}, {0x67, 0x1C}, {0x68, 0x00},
> > +	{0x69, 0x00}, {0x6A, 0x00}, {0x6B, 0x00}, {0x6C, 0x00},
> > +	{0x70, 0x00}, {0x71, 0x55}, {0x72, 0x44}, {0x73, 0x33},
> > +	{0x74, 0x22}, {0x75, 0x33}, {0x76, 0x22}, {0x77, 0x22},
> > +	{0x78, 0x33}, {0x79, 0x22}, {0x7A, 0x44}, {0x7B, 0x55},
> > +	{0x7C, 0x00}, {0x80, 0x00}, {0x81, 0x66}, {0x82, 0x22},
> > +	{0x83, 0x33}, {0x84, 0x22}, {0x85, 0x33}, {0x86, 0x22},
> > +	{0x87, 0x22}, {0x88, 0x33}, {0x89, 0x44}, {0x8A, 0x44},
> > +	{0x8B, 0x44}, {0x8C, 0x00}, {0x90, 0x00}, {0x91, 0x77},
> > +	{0x92, 0x66}, {0x93, 0x33}, {0x94, 0x11}, {0x95, 0x33},
> > +	{0x96, 0x22}, {0x97, 0x22}, {0x98, 0x44}, {0x99, 0x44},
> > +	{0x9A, 0x33}, {0x9B, 0x44}, {0x9C, 0x00}, {0xA0, 0x88},
> > +	{0xA1, 0x88}, {0xA2, 0x88}, {0xA3, 0x88}, {0xA4, 0x88},
> > +	{0xA5, 0x88}, {0xA6, 0x88}, {0xA7, 0x88}, {0xA8, 0x88},
> > +	{0xA9, 0x88}, {0xAA, 0x88}, {0xAB, 0x88}, {0xAC, 0x88},
> > +	{0xAD, 0x88}, {0xAE, 0x88}, {0xAF, 0x88}, {0xB0, 0x88},
> > +	{0xB1, 0x88}, {0xB2, 0x88}, {0xB3, 0x88}, {0xB4, 0x88},
> > +	{0xB5, 0x88}, {0xB6, 0x88}, {0xB7, 0x88}, {0xB8, 0x88},
> > +	{0xB9, 0x88}, {0xBA, 0x88}, {0xBB, 0xA6}, {0xBC, 0x88},
> > +	{0xBD, 0x88}, {0xBE, 0x88}, {0xBF, 0x88}, {0xC0, 0x88},
> > +	{0xC1, 0x88}, {0xC2, 0x88}, {0xC3, 0x88}, {0xC4, 0x88},
> > +	{0xC5, 0x88}, {0xC6, 0x88}, {0xC7, 0x88}, {0xC8, 0x88},
> > +	{0xC9, 0x88}, {0xD0, 0x36}, {0xD1, 0x26}, {0xD2, 0x21},
> > +	{0xD3, 0x1F}, {0xD4, 0x17}, {0xD5, 0x15}, {0xD6, 0x13},
> > +	{0xD7, 0x10}, {0xD8, 0x08}, {0xD9, 0x08}, {0xDA, 0x18},
> > +	{0xDB, 0x1D}, {0xDC, 0x1F}, {0xDD, 0x27}, {0xDE, 0x29},
> > +	{0xDF, 0x2B}, {0xE0, 0x2E}, {0xE1, 0x36}, {0xE6, 0x00},
> > +	{0xF1, 0x00}, {0xF2, 0x00}, {0xF3, 0x00} =20
>=20
> Smells non-GPLly. Maybe ask the provider of the vendor kernel for "the
> preferred form of the work for making modifications to it".
>=20
Well, this are address / data pairs. so probably the more
preferred form would be symbolic names. I did not manage to get u-boot sour=
ces
from Epson either. So I think it would be even harder to get anything here.
And since these things are very old, maybe more information
does not even exist anymore.
So how to progress here?

> I guess {0x0A, 0x00} disables the display, so taking over an enabled
> display setup by the bootloader doesn't work as is.
>=20
The factory bootloader seems only to reset things. It seems not
to initialize anything regarding display.

Until just a few months my preferred way of booting this device
was to boot vendor kernel, reprogram boot order temporarily,
go through more recent u-boot and boot linux. During this procedure,
the bridge setup was left intact. I just read things back to check
if values are already set and happlily reinitialized display itself.
No issue found doing it that way.

[...]
> > +MODULE_DEVICE_TABLE(spi, bt200_ids);
> > +
> > +static struct spi_driver bt200_driver =3D {
> > +	.probe =3D bt200_probe,
> > +	.remove =3D bt200_remove,
> > +	.id_table =3D bt200_ids,
> > +	.driver =3D {
> > +		.name =3D "panel-bt200",
> > +		.of_match_table =3D bt200_of_match,
> > +		.suppress_bind_attrs =3D true, =20
>=20
> Why suppress bind attrs?
>=20
That was not intentional, maybe I had something in mind that
it is common practice is certain areas, but not for panels.

Regards,
Andreas
