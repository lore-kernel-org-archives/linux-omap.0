From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH 2/4] drm/i2c: nxp-tda998x (v2)
Date: Wed, 23 Jan 2013 10:42:30 +0100
Message-ID: <20130123104230.38cfc515@armhf>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
	<1358894185-21617-3-git-send-email-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:39919 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439Ab3AWJmo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jan 2013 04:42:44 -0500
In-Reply-To: <1358894185-21617-3-git-send-email-robdclark@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Tue, 22 Jan 2013 16:36:23 -0600
Rob Clark <robdclark@gmail.com> wrote:

> Driver for the NXP TDA998X i2c hdmi encoder slave.
>=20
> v1: original
> v2: fix npix/nline programming
>=20
> Signed-off-by: Rob Clark <robdclark@gmail.com>
> ---
>  drivers/gpu/drm/i2c/Makefile      |   3 +
>  drivers/gpu/drm/i2c/tda998x_drv.c | 908 ++++++++++++++++++++++++++++=
++++++++++
>  2 files changed, 911 insertions(+)
>  create mode 100644 drivers/gpu/drm/i2c/tda998x_drv.c
	[snip]
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/=
tda998x_drv.c
> new file mode 100644
> index 0000000..02054e8
> --- /dev/null
> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> @@ -0,0 +1,908 @@
	[snip]
> +static void __exit
> +tda998x_exit(void)
> +{
> +	DBG("");
> +	drm_i2c_encoder_unregister(&tda998x_driver);
> +}
> +
> +MODULE_DESCRIPTION("NXP Semiconductors TDA998X TMDS transmitter driv=
er");
> +
> +MODULE_AUTHOR("Rob Clark <robdclark@gmail.com");
> +MODULE_DESCRIPTION("NXP Semiconductors TDA998X HDMI Encoder");
> +MODULE_LICENSE("GPL");
> +
> +module_init(tda998x_init);
> +module_exit(tda998x_exit);

There are 2 MODULE_DESCRIPTION().

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
