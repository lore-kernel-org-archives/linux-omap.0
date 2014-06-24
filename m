From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH/RESEND 1/9] drm/i2c: tda998x: move
	drm_i2c_encoder_destroy call
Date: Tue, 24 Jun 2014 17:38:13 +0100
Message-ID: <20140624163813.GJ3705@n2100.arm.linux.org.uk>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar> <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar> <1403014631-18072-2-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40853 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755872AbaFXQiT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 12:38:19 -0400
Content-Disposition: inline
In-Reply-To: <1403014631-18072-2-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, robdclark@gmail.com, Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>, airlied@linux.ie, Daniel Mack <zonque@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, stable@vger.kernel.org

On Tue, Jun 17, 2014 at 11:17:03AM -0300, Guido Mart=EDnez wrote:
> Currently tda998x_encoder_destroy() calls cec_write() and reg_clear()=
,
> as part of the release procedure. Such calls need to access the I2C b=
us
> and therefore, we need to call them before drm_i2c_encoder_destroy()
> which unregisters the I2C device.
>=20
> This commit moves the latter so it's done afterwards.
>=20
> Signed-off-by: Guido Mart=EDnez <guido@vanguardiasur.com.ar>
> Signed-off-by: Ezequiel Garc=EDa <ezequiel@vanguardiasur.com.ar>
> Cc: <stable@vger.kernel.org> #v3.9+

You really should have sent this with me in the To: header as I'm now t=
he
maintainer of this driver.  Yes, this is a valid fix, and I'll apply it
shortly.  Thanks.

> ---
>  drivers/gpu/drm/i2c/tda998x_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/=
tda998x_drv.c
> index 240c331..db9515f 100644
> --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> @@ -1183,7 +1183,6 @@ static void
>  tda998x_encoder_destroy(struct drm_encoder *encoder)
>  {
>  	struct tda998x_priv *priv =3D to_tda998x_priv(encoder);
> -	drm_i2c_encoder_destroy(encoder);
> =20
>  	/* disable all IRQs and free the IRQ handler */
>  	cec_write(priv, REG_CEC_RXSHPDINTENA, 0);
> @@ -1193,6 +1192,7 @@ tda998x_encoder_destroy(struct drm_encoder *enc=
oder)
> =20
>  	if (priv->cec)
>  		i2c_unregister_device(priv->cec);
> +	drm_i2c_encoder_destroy(encoder);
>  	kfree(priv);
>  }
> =20
> --=20
> 2.0.0
>=20

--=20
=46TTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... sl=
owly
improving, and getting towards what was expected from it.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
