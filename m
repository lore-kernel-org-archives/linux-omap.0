From: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>
Subject: Re: [PATCH/RESEND 1/9] drm/i2c: tda998x: move
 drm_i2c_encoder_destroy call
Date: Wed, 25 Jun 2014 00:55:22 -0300
Message-ID: <20140625035522.GB9466@fox>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-2-git-send-email-guido@vanguardiasur.com.ar>
 <20140624163813.GJ3705@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140624163813.GJ3705@n2100.arm.linux.org.uk>
Sender: stable-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, robdclark@gmail.com, Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>, airlied@linux.ie, Daniel Mack <zonque@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Russell,

On Tue, Jun 24, 2014 at 05:38:13PM +0100, Russell King - ARM Linux wrot=
e:
> On Tue, Jun 17, 2014 at 11:17:03AM -0300, Guido Mart=EDnez wrote:
> > Currently tda998x_encoder_destroy() calls cec_write() and reg_clear=
(),
> > as part of the release procedure. Such calls need to access the I2C=
 bus
> > and therefore, we need to call them before drm_i2c_encoder_destroy(=
)
> > which unregisters the I2C device.
> >=20
> > This commit moves the latter so it's done afterwards.
> >=20
> > Signed-off-by: Guido Mart=EDnez <guido@vanguardiasur.com.ar>
> > Signed-off-by: Ezequiel Garc=EDa <ezequiel@vanguardiasur.com.ar>
> > Cc: <stable@vger.kernel.org> #v3.9+
>=20
> You really should have sent this with me in the To: header as I'm now=
 the
> maintainer of this driver.  Yes, this is a valid fix, and I'll apply =
it
> shortly.  Thanks.
Sorry about that, I'm still kind of new to this whole deal. I'll keep i=
t
mind for future patches.

Thanks,
Guido


> > ---
> >  drivers/gpu/drm/i2c/tda998x_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2=
c/tda998x_drv.c
> > index 240c331..db9515f 100644
> > --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> > +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> > @@ -1183,7 +1183,6 @@ static void
> >  tda998x_encoder_destroy(struct drm_encoder *encoder)
> >  {
> >  	struct tda998x_priv *priv =3D to_tda998x_priv(encoder);
> > -	drm_i2c_encoder_destroy(encoder);
> > =20
> >  	/* disable all IRQs and free the IRQ handler */
> >  	cec_write(priv, REG_CEC_RXSHPDINTENA, 0);
> > @@ -1193,6 +1192,7 @@ tda998x_encoder_destroy(struct drm_encoder *e=
ncoder)
> > =20
> >  	if (priv->cec)
> >  		i2c_unregister_device(priv->cec);
> > +	drm_i2c_encoder_destroy(encoder);
> >  	kfree(priv);
> >  }
> > =20
> > --=20
> > 2.0.0
> >=20
>=20
> --=20
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... sl=
owly
> improving, and getting towards what was expected from it.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Guido Mart=EDnez, VanguardiaSur
www.vanguardiasur.com.ar
