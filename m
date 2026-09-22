Received: from mail-wr2-f21.google.com (mail-wr2-f21.google.com [74.125.225.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B282524B1C
	for <linux-omap@vger.kernel.org>; Tue, 22 Sep 2026 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068423; cv=none; b=IZ2gHW44jnlVsh8+NGCE2lbUjK9YrHzGo8I7fWnAlRYGKUTZvIoOLEmUDYty+mGetCXBUL1SAx0jBAlTjUIA88W7FmxCFPei8umUv5f6kXMSiUPv4dZ5u+PBa7E0PPZhvqc0tO1x29JlyifCcAHPlbDW7+FDjmRFIjt/ftxZVKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068423; c=relaxed/simple;
	bh=cLgEqV8G7T1LHvzxhaWm7LYOJH064WufTlQKYv0xCgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGe6S+xAX7M2Cezk5cLOJxUtN6+AcJYMZdIs8MngLXtuVBMDum/Lij9kHp1yCCkLNFCWm9jrjgK7ukv8pRevg+oES0LhiDZjp7yuiHCaPu3L4fSieGlid9eggB5QPczlpWvHG+e6/M9U820y82/loJ1uV1rcE61cKHfFuSR3BPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=GWTNJAlq; arc=none smtp.client-ip=74.125.225.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="GWTNJAlq"
Received: by mail-wr2-f21.google.com with SMTP id ffacd0b85a97d-482f633cd80so1853049f8f.2
        for <linux-omap@vger.kernel.org>; Tue, 22 Sep 2026 02:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790068418; x=1790673218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PiHqI0ujYGr3xhtf8amSgF0WvqBckTwIt2C80WEMX5c=;
        b=GWTNJAlqxkNN2MOsWqvzzbBrGX6dMUVpV/rbwcNtF8DpVKCKaI469INwT7W3Bc4UlU
         B3fWXCETVgdNTuU4FtsNy7zMjIm9sWW5MzKfZkl+2G0DaDUCuhntDi6SZmN/2JNEF7dB
         tIy3VI4EN5m7Nw/2kEmRaYyA5a/pevqaxQEQkSzFhj4QJwpSK+GmQQzzRAbrAnpgNoc0
         2g9kXMXADvIvJo/vgIKNslSa5v8Ca4jI95b21vkXTg3wPeOTgz0aMt3ZIh8oJ4uxsgTb
         YaMIu/GK15XXx8DH6eMEToKjsn8ChQk84ZhNw94VlznhWNjY6lNqjyyB9SKPonhCs8iy
         3zIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790068418; x=1790673218;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PiHqI0ujYGr3xhtf8amSgF0WvqBckTwIt2C80WEMX5c=;
        b=YMDnZMAincGFd0d3QaRutE4crwJ6c/0YgSp8kJpbqt5UyyvyMeX2xScqnVP+/VO/wb
         cYAKY6k4tUZSS8D0fCVYcliBW6f37QpjDqF/MJrDedc/kkqXOof/G33rOpO2kMNsS43k
         zbJVnsnJb7000+V6XUNSVnz/bEhLyLnG4AKHRq1jZdSEMNeOw7CqzNlo+qIxQrQtu28+
         yTE9x41asX8kSq2J+Yd1a3rn3zAJlAmG8tAyj/Mw4KXqJzSCN8D+zQuYNDZFsh72szxJ
         Tlb9va0hAKZiDEBCg2HH7PbZ+shH5th7opcCWkV6Xg9WmUjsSC/wxbxplYLfozC8P1XE
         R3RQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQxorc5GU/imMK9NwtAYl41SFRufMjiMY2cOt/XE2cNe3X9WE1bGDKnAacz/6pqTBBrfdGpH1yT3GV@vger.kernel.org
X-Gm-Message-State: AFuF++n/yuw0KRLY6Nc4+TzlYZkTFo6OskNAkBA1ZkLKGPqawWK4ORd6
	6Ispbd/VGjU3ZMeO42rSbqVZofGlj9DIjsYIDYGA3VTsQEk/Vx/b5QvA4y1qcZjkEyY=
X-Gm-Gg: AYBFou20LlDM3/luFZVwGINoMbsBdV/XyhHGFy+f4M/R3+xmtZLoPPDiZvS7USKbl2g
	M0DMd+54gx0OGkOVoKDxwNSLpXpaEYfKiFx1XLj5+Sc0Ob8pF0XlXbUOswGGjK5y5ywryNH9pYX
	19l52eCm/6eRG+snEKRbkyIlk2RMXxIgiJpdct5on6T+uJ7rjUpavvstfPLJMiryf03YCjwRMUF
	Mf8b5ZKMIoC54dekRIQe23ATKg6hfusomvd4NTYkFma17hU3SNYugVkZFbAs5oPiCVMTAHQljzN
	BJYzHMhKVXCBr3mwfOgaLdq4cht5NNhxSHYd9MYSVSqw5Q+dyK7M3PSn7LRpGHGRhZcSJRmpsFc
	U1+A0ZYJCNmwK4Z5uk+6j52Iwnwhi0Zzk18GS8KtM90coNiCUV4T9spZrp2ZDLqJTk81tbs/XTa
	2KOogaUrTUiMOPT9sFoMXd/23EafAqEuiBaJY6b8r321xCCgkLH4HrgB/JXiNRmJ1tgz45dCoxt
	WfOqWSV/N/vF0B3Q8R7g+YRiVc075cgAK84nr70E05bnSsIzLyodX2qzE/CAw==
X-Received: by 2002:adf:e012:0:10b0:487:231a:fe8a with SMTP id ffacd0b85a97d-487231b01abmr11618972f8f.2.1790068418207;
        Tue, 22 Sep 2026 02:13:38 -0700 (PDT)
Received: from localhost (p200300f65f19a9041d0e57515b2ea4c8.dip0.t-ipconnect.de. [2003:f6:5f19:a904:1d0e:5751:5b2e:a4c8])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4886277df51sm3563045f8f.15.2026.09.22.02.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:13:37 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:13:36 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Marek Vasut <marex@denx.de>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, hns@goldelico.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org
Subject: Re: [PATCH RFC 2/9] drm: panel: Add panel for Epson Moverio BT200
Message-ID: <arJDcpvQlIMIGJaP@monoceros>
References: <20260922-b2-panel-via-bridge-v1-0-45ff36b364cf@kemnade.info>
 <20260922-b2-panel-via-bridge-v1-2-45ff36b364cf@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jqvd4moyr64selk7"
Content-Disposition: inline
In-Reply-To: <20260922-b2-panel-via-bridge-v1-2-45ff36b364cf@kemnade.info>


--jqvd4moyr64selk7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 2/9] drm: panel: Add panel for Epson Moverio BT200
MIME-Version: 1.0

Hallo Andreas,

On Tue, Sep 22, 2026 at 08:16:59AM +0200, Andreas Kemnade wrote:
> diff --git a/drivers/gpu/drm/panel/panel-epson-bt200.c b/drivers/gpu/drm/=
panel/panel-epson-bt200.c
> new file mode 100644
> index 000000000000..c26a4f8ae15e
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-epson-bt200.c
> @@ -0,0 +1,251 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/backlight.h>
> +#include <linux/errno.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>

Please don't include <linux/mod_devicetable.h>. You can rely on
<linux/spi/spi.h> to provide of_device_id and spi_device_id; or if you
prefer full iwyu include <linux/device-id/of.h> and <.../spi.h>.

> +#include <linux/spi/spi.h>
> +
> +#include <drm/drm_connector.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_print.h>
> +#include <drm/drm_probe_helper.h>
> +
> +static const struct drm_display_mode default_mode =3D {
> +	.clock			=3D 41600,	/* kHz */
> +#if 0

huh, upstream code isn't supposed to have #if 0 blocks.

> +	/* values matching struct omap_video_timings in vendor kernel */
> +	.hdisplay		=3D 960,
> +	.hsync_start		=3D 960 + 176,
> +	.hsync_end		=3D 960 + 176 + 20,
> +	.htotal			=3D 960 + 176 + 20 + 86,
> +#else
> +	/* values from what is writted to LCDCTRL on vendor kernel */
> +	.hdisplay		=3D 960,
> +	.hsync_start		=3D 960 + 33,
> +	.hsync_end		=3D 960 + 33 + 20,
> +	.htotal			=3D 960 + 33 + 20 + 86,
> +#endif
> +	.vdisplay		=3D 540,
> +	.vsync_start		=3D 540 + 9,
> +	.vsync_end		=3D 540 + 9 + 3,
> +	.vtotal			=3D 540 + 9 + 3 + 12,
> +	.flags			=3D 0,
> +};
> +
> +struct bt200_panel {
> +	struct drm_panel panel;
> +	struct spi_device *spi;
> +};
> +
> +static int bt200_panel_write(struct bt200_panel *ctx, u8 addr, u8 data)
> +{
> +	u8 val[2];
> +
> +	val[0] =3D addr;
> +	val[1] =3D data;
> +
> +	return spi_write(ctx->spi, val, sizeof(val));
> +}
> +
> +static inline struct bt200_panel *panel_to_bt200(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct bt200_panel, panel);
> +}
> +
> +static int bt200_disable(struct drm_panel *panel)
> +{
> +	struct bt200_panel *ctx =3D panel_to_bt200(panel);
> +
> +	bt200_panel_write(ctx, 0x0A, 0);
> +	return 0;
> +}
> +
> +static int bt200_unprepare(struct drm_panel *panel)
> +{
> +	return 0;
> +}
> +
> +/* found this table in vendor kernel */
> +static struct {
> +	u8 addr;
> +	u8 data;
> +} lcddr_init[] =3D {
> +	{0x01, 0x00}, {0x02, 0x00}, {0x03, 0x00}, {0x05, 0x01},
> +	{0x07, 0x00}, {0x0A, 0x00}, {0x10, 0x03}, {0x11, 0x44},
> +	{0x12, 0x44}, {0x13, 0x55}, {0x14, 0x03}, {0x15, 0x00},
> +	{0x16, 0x2A}, {0x17, 0x20}, {0x18, 0x00}, {0x19, 0x10},
> +	{0x1A, 0x12}, {0x1B, 0x0E}, {0x1C, 0x0F}, {0x1D, 0x10},
> +	{0x1E, 0x0F}, {0x1F, 0x1B}, {0x20, 0x0F}, {0x21, 0x00},
> +	{0x22, 0x00}, {0x23, 0x00}, {0x24, 0x00}, {0x28, 0x14},
> +	{0x29, 0x19}, {0x2A, 0x17}, {0x2B, 0x2B}, {0x2C, 0x99},
> +	{0x2D, 0x13}, {0x2E, 0x2A}, {0x30, 0x0B}, {0x31, 0x00},
> +	{0x32, 0x00}, {0x33, 0x01}, {0x34, 0x00}, {0x35, 0x0B},
> +	{0x36, 0x04}, {0x37, 0x21}, {0x38, 0x00}, {0x39, 0x46},
> +	{0x3A, 0x01}, {0x3B, 0x06}, {0x3C, 0x03}, {0x3D, 0x00},
> +	{0x3E, 0x06}, {0x3F, 0x04}, {0x40, 0x00}, {0x41, 0x0D},
> +	{0x42, 0x00}, {0x43, 0x2E}, {0x45, 0x08}, {0x46, 0x00},
> +	{0x47, 0x01}, {0x48, 0x00}, {0x49, 0x00}, {0x4A, 0x0B},
> +	{0x4B, 0x38}, {0x4C, 0x03}, {0x4D, 0x04}, {0x50, 0x0F},
> +	{0x51, 0x04}, {0x52, 0x01}, {0x53, 0x0E}, {0x54, 0x11},
> +	{0x55, 0x9F}, {0x56, 0x36}, {0x57, 0x00}, {0x58, 0x68},
> +	{0x59, 0x01}, {0x5A, 0xE0}, {0x5B, 0x00}, {0x5C, 0x00},
> +	{0x5D, 0x10}, {0x5E, 0x36}, {0x5F, 0x36}, {0x60, 0x00},
> +	{0x61, 0x04}, {0x62, 0x12}, {0x63, 0x00}, {0x64, 0x80},
> +	{0x65, 0x00}, {0x66, 0x80}, {0x67, 0x1C}, {0x68, 0x00},
> +	{0x69, 0x00}, {0x6A, 0x00}, {0x6B, 0x00}, {0x6C, 0x00},
> +	{0x70, 0x00}, {0x71, 0x55}, {0x72, 0x44}, {0x73, 0x33},
> +	{0x74, 0x22}, {0x75, 0x33}, {0x76, 0x22}, {0x77, 0x22},
> +	{0x78, 0x33}, {0x79, 0x22}, {0x7A, 0x44}, {0x7B, 0x55},
> +	{0x7C, 0x00}, {0x80, 0x00}, {0x81, 0x66}, {0x82, 0x22},
> +	{0x83, 0x33}, {0x84, 0x22}, {0x85, 0x33}, {0x86, 0x22},
> +	{0x87, 0x22}, {0x88, 0x33}, {0x89, 0x44}, {0x8A, 0x44},
> +	{0x8B, 0x44}, {0x8C, 0x00}, {0x90, 0x00}, {0x91, 0x77},
> +	{0x92, 0x66}, {0x93, 0x33}, {0x94, 0x11}, {0x95, 0x33},
> +	{0x96, 0x22}, {0x97, 0x22}, {0x98, 0x44}, {0x99, 0x44},
> +	{0x9A, 0x33}, {0x9B, 0x44}, {0x9C, 0x00}, {0xA0, 0x88},
> +	{0xA1, 0x88}, {0xA2, 0x88}, {0xA3, 0x88}, {0xA4, 0x88},
> +	{0xA5, 0x88}, {0xA6, 0x88}, {0xA7, 0x88}, {0xA8, 0x88},
> +	{0xA9, 0x88}, {0xAA, 0x88}, {0xAB, 0x88}, {0xAC, 0x88},
> +	{0xAD, 0x88}, {0xAE, 0x88}, {0xAF, 0x88}, {0xB0, 0x88},
> +	{0xB1, 0x88}, {0xB2, 0x88}, {0xB3, 0x88}, {0xB4, 0x88},
> +	{0xB5, 0x88}, {0xB6, 0x88}, {0xB7, 0x88}, {0xB8, 0x88},
> +	{0xB9, 0x88}, {0xBA, 0x88}, {0xBB, 0xA6}, {0xBC, 0x88},
> +	{0xBD, 0x88}, {0xBE, 0x88}, {0xBF, 0x88}, {0xC0, 0x88},
> +	{0xC1, 0x88}, {0xC2, 0x88}, {0xC3, 0x88}, {0xC4, 0x88},
> +	{0xC5, 0x88}, {0xC6, 0x88}, {0xC7, 0x88}, {0xC8, 0x88},
> +	{0xC9, 0x88}, {0xD0, 0x36}, {0xD1, 0x26}, {0xD2, 0x21},
> +	{0xD3, 0x1F}, {0xD4, 0x17}, {0xD5, 0x15}, {0xD6, 0x13},
> +	{0xD7, 0x10}, {0xD8, 0x08}, {0xD9, 0x08}, {0xDA, 0x18},
> +	{0xDB, 0x1D}, {0xDC, 0x1F}, {0xDD, 0x27}, {0xDE, 0x29},
> +	{0xDF, 0x2B}, {0xE0, 0x2E}, {0xE1, 0x36}, {0xE6, 0x00},
> +	{0xF1, 0x00}, {0xF2, 0x00}, {0xF3, 0x00}

Smells non-GPLly. Maybe ask the provider of the vendor kernel for "the
preferred form of the work for making modifications to it".

I guess {0x0A, 0x00} disables the display, so taking over an enabled
display setup by the bootloader doesn't work as is.

> +};
> +
> +static int init_lcd(struct bt200_panel *ctx)
> +{
> +	int i;
> +	int r;
> +
> +	r =3D spi_setup(ctx->spi);
> +	if (r < 0)
> +		return r;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(lcddr_init); ++i) {
> +		r =3D bt200_panel_write(ctx, (u16)lcddr_init[i].addr,
> +				      lcddr_init[i].data);
> +		if (r) {
> +			dev_err(ctx->panel.dev, "failed to write initial config (write) %d\n"=
, i);

I claim that `i` isn't very interesting here, but maybe mention
lcddr_init[i].addr and/or `r` (using %pe).

> +			return r;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int bt200_prepare(struct drm_panel *panel)
> +{
> +	int r;
> +	struct bt200_panel *ctx =3D panel_to_bt200(panel);
> +
> +	r =3D init_lcd(ctx);
> +	if (r)
> +		return r;
> +
> +	msleep(50);
> +	return 0;
> +}
> +
> +static int bt200_enable(struct drm_panel *panel)
> +{
> +	struct bt200_panel *ctx =3D panel_to_bt200(panel);
> +
> +	return bt200_panel_write(ctx, 0x0A, 1);
> +}
> +
> +static int bt200_get_modes(struct drm_panel *panel, struct drm_connector=
 *connector)
> +{
> +	struct drm_display_mode *mode;
> +
> +	mode =3D drm_mode_duplicate(connector->dev, &default_mode);
> +	if (!mode)
> +		return -ENOMEM;
> +
> +	drm_mode_set_name(mode);
> +	mode->type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +	drm_mode_probed_add(connector, mode);
> +
> +	return 1;
> +}
> +
> +static const struct drm_panel_funcs bt200_panel_funcs =3D {
> +	.disable =3D bt200_disable,
> +	.unprepare =3D bt200_unprepare,
> +	.prepare =3D bt200_prepare,
> +	.enable =3D bt200_enable,
> +	.get_modes =3D bt200_get_modes,
> +};
> +
> +static int bt200_probe(struct spi_device *spi)
> +{
> +	struct bt200_panel *ctx;
> +	int ret;
> +
> +	ctx =3D devm_drm_panel_alloc(&spi->dev, struct bt200_panel, panel,
> +				   &bt200_panel_funcs, DRM_MODE_CONNECTOR_DPI);
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	spi_set_drvdata(spi, ctx);
> +	ctx->spi =3D spi;
> +	ctx->panel.prepare_prev_first =3D true;
> +
> +	spi->bits_per_word =3D 8;
> +
> +	ret =3D drm_panel_of_backlight(&ctx->panel);
> +	if (ret)

Error message here? (Use dev_err_probe().)

> +		return ret;
> +
> +	drm_panel_add(&ctx->panel);
> +	return 0;
> +}
> +
> +static void bt200_remove(struct spi_device *dsi)
> +{
> +	struct bt200_panel *ctx =3D spi_get_drvdata(dsi);
> +
> +	drm_panel_remove(&ctx->panel);
> +}
> +
> +static const struct of_device_id bt200_of_match[] =3D {
> +	{ .compatible =3D "epson,panel-bt200", },
> +	{},

Please use { } here (space between curlys and no trailing comma).

> +};
> +
> +MODULE_DEVICE_TABLE(of, bt200_of_match);
> +
> +static const struct spi_device_id bt200_ids[] =3D {
> +	{ "panel-bt200", 0 },

Drop the unused 0.

> +	{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(spi, bt200_ids);
> +
> +static struct spi_driver bt200_driver =3D {
> +	.probe =3D bt200_probe,
> +	.remove =3D bt200_remove,
> +	.id_table =3D bt200_ids,
> +	.driver =3D {
> +		.name =3D "panel-bt200",
> +		.of_match_table =3D bt200_of_match,
> +		.suppress_bind_attrs =3D true,

Why suppress bind attrs?

> +	},
> +};
> +
> +module_spi_driver(bt200_driver);
> +
> +MODULE_AUTHOR("Andreas Kemnade <andreas@kemnade.info>");
> +MODULE_DESCRIPTION("bt200 panel driver");
> +MODULE_LICENSE("GPL");
>=20
> --=20
> 2.47.3
>=20

--jqvd4moyr64selk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqyRr0ACgkQj4D7WH0S
/k7j9wf/drFjkoSYkDRRwFeWVlLaePMX2uQRlfXo7bRanY/j2jstfKtkYC93sZHO
x+QUz0iQEV9UIj/cadU7riyXfgkqF+GzorMGpKRq4NiIKAZbAJb7ZcR0/AQxCIlI
amIJc0HIna/7St++Rvy1BLGVLt20UqxyW4xTAWn7xu/H3Kg+qH1EfPRko1Tm+4lZ
sfDKBe8Cr5nyLx0xL4qJzz/UmAKvwBEf8aCd/zh7kGb85vDz1dQqlSYNgvgjLpSt
D+rp04O1VMsPVP6wV5j9+5/PypooTns3vn/PMiufyRJWXrO6P6sgd+opsnaU3XcL
Y+ljWS1Cqsd903WtMzpzVA1c4ZrEXw==
=jK23
-----END PGP SIGNATURE-----

--jqvd4moyr64selk7--
