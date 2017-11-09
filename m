From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 1/7] clocksource: dmtimer: Remove all the exports
Date: Thu, 9 Nov 2017 17:13:42 +0100
Message-ID: <20171109161342.j35xhlmeyftpqnrd@earth>
References: <1510144108-29563-1-git-send-email-j-keerthy@ti.com>
 <1510144108-29563-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lerwfg2m56bnkpya"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1510144108-29563-2-git-send-email-j-keerthy@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com, khilman@kernel.org, daniel.lezcano@linaro.org, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--lerwfg2m56bnkpya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 08, 2017 at 05:58:22PM +0530, Keerthy wrote:
> Remove all the unwanted exports from the driver
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> No code changes in this v2 version. Only enhanced patch
> statistics for renames.
>=20
>  arch/arm/plat-omap/dmtimer.c | 27 ---------------------------
>  1 file changed, 27 deletions(-)
>=20
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index d443e48..72565fc 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -302,7 +302,6 @@ struct omap_dm_timer *omap_dm_timer_request(void)
>  {
>  	return _omap_dm_timer_request(REQUEST_ANY, NULL);
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_request);
> =20
>  struct omap_dm_timer *omap_dm_timer_request_specific(int id)
>  {
> @@ -315,7 +314,6 @@ struct omap_dm_timer *omap_dm_timer_request_specific(=
int id)
> =20
>  	return _omap_dm_timer_request(REQUEST_BY_ID, &id);
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_request_specific);
> =20
>  /**
>   * omap_dm_timer_request_by_cap - Request a timer by capability
> @@ -330,7 +328,6 @@ struct omap_dm_timer *omap_dm_timer_request_by_cap(u3=
2 cap)
>  {
>  	return _omap_dm_timer_request(REQUEST_BY_CAP, &cap);
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_request_by_cap);
> =20
>  /**
>   * omap_dm_timer_request_by_node - Request a timer by device-tree node
> @@ -346,7 +343,6 @@ struct omap_dm_timer *omap_dm_timer_request_by_node(s=
truct device_node *np)
> =20
>  	return _omap_dm_timer_request(REQUEST_BY_NODE, np);
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_request_by_node);
> =20
>  int omap_dm_timer_free(struct omap_dm_timer *timer)
>  {
> @@ -359,7 +355,6 @@ int omap_dm_timer_free(struct omap_dm_timer *timer)
>  	timer->reserved =3D 0;
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_free);
> =20
>  void omap_dm_timer_enable(struct omap_dm_timer *timer)
>  {
> @@ -379,13 +374,11 @@ void omap_dm_timer_enable(struct omap_dm_timer *tim=
er)
>  		}
>  	}
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
> =20
>  void omap_dm_timer_disable(struct omap_dm_timer *timer)
>  {
>  	pm_runtime_put_sync(&timer->pdev->dev);
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_disable);
> =20
>  int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
>  {
> @@ -393,7 +386,6 @@ int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
>  		return timer->irq;
>  	return -EINVAL;
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_get_irq);
> =20
>  #if defined(CONFIG_ARCH_OMAP1)
>  #include <mach/hardware.h>
> @@ -429,7 +421,6 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmas=
k)
> =20
>  	return inputmask;
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
> =20
>  #else
> =20
> @@ -439,7 +430,6 @@ struct clk *omap_dm_timer_get_fclk(struct omap_dm_tim=
er *timer)
>  		return timer->fclk;
>  	return NULL;
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_get_fclk);
> =20
>  __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
>  {
> @@ -447,7 +437,6 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmas=
k)
> =20
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
> =20
>  #endif
> =20
> @@ -461,7 +450,6 @@ int omap_dm_timer_trigger(struct omap_dm_timer *timer)
>  	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_trigger);
> =20
>  int omap_dm_timer_start(struct omap_dm_timer *timer)
>  {
> @@ -482,7 +470,6 @@ int omap_dm_timer_start(struct omap_dm_timer *timer)
>  	timer->context.tclr =3D l;
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_start);
> =20
>  int omap_dm_timer_stop(struct omap_dm_timer *timer)
>  {
> @@ -506,7 +493,6 @@ int omap_dm_timer_stop(struct omap_dm_timer *timer)
>  	omap_dm_timer_disable(timer);
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
> =20
>  int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
>  {
> @@ -569,7 +555,6 @@ int omap_dm_timer_set_source(struct omap_dm_timer *ti=
mer, int source)
> =20
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
> =20
>  int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
>  			    unsigned int load)
> @@ -595,7 +580,6 @@ int omap_dm_timer_set_load(struct omap_dm_timer *time=
r, int autoreload,
>  	omap_dm_timer_disable(timer);
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_set_load);
> =20
>  /* Optimized set_load which removes costly spin wait in timer_start */
>  int omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autore=
load,
> @@ -625,7 +609,6 @@ int omap_dm_timer_set_load_start(struct omap_dm_timer=
 *timer, int autoreload,
>  	timer->context.tcrr =3D load;
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_set_load_start);
> =20
>  int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
>  			     unsigned int match)
> @@ -650,7 +633,6 @@ int omap_dm_timer_set_match(struct omap_dm_timer *tim=
er, int enable,
>  	omap_dm_timer_disable(timer);
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_set_match);
> =20
>  int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
>  			   int toggle, int trigger)
> @@ -676,7 +658,6 @@ int omap_dm_timer_set_pwm(struct omap_dm_timer *timer=
, int def_on,
>  	omap_dm_timer_disable(timer);
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_set_pwm);
> =20
>  int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescal=
er)
>  {
> @@ -699,7 +680,6 @@ int omap_dm_timer_set_prescaler(struct omap_dm_timer =
*timer, int prescaler)
>  	omap_dm_timer_disable(timer);
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_set_prescaler);
> =20
>  int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
>  				  unsigned int value)
> @@ -716,7 +696,6 @@ int omap_dm_timer_set_int_enable(struct omap_dm_timer=
 *timer,
>  	omap_dm_timer_disable(timer);
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_enable);
> =20
>  /**
>   * omap_dm_timer_set_int_disable - disable timer interrupts
> @@ -747,7 +726,6 @@ int omap_dm_timer_set_int_disable(struct omap_dm_time=
r *timer, u32 mask)
>  	omap_dm_timer_disable(timer);
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_disable);
> =20
>  unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
>  {
> @@ -762,7 +740,6 @@ unsigned int omap_dm_timer_read_status(struct omap_dm=
_timer *timer)
> =20
>  	return l;
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_read_status);
> =20
>  int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int=
 value)
>  {
> @@ -773,7 +750,6 @@ int omap_dm_timer_write_status(struct omap_dm_timer *=
timer, unsigned int value)
> =20
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_write_status);
> =20
>  unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
>  {
> @@ -784,7 +760,6 @@ unsigned int omap_dm_timer_read_counter(struct omap_d=
m_timer *timer)
> =20
>  	return __omap_dm_timer_read_counter(timer, timer->posted);
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_read_counter);
> =20
>  int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned in=
t value)
>  {
> @@ -799,7 +774,6 @@ int omap_dm_timer_write_counter(struct omap_dm_timer =
*timer, unsigned int value)
>  	timer->context.tcrr =3D value;
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timer_write_counter);
> =20
>  int omap_dm_timers_active(void)
>  {
> @@ -816,7 +790,6 @@ int omap_dm_timers_active(void)
>  	}
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(omap_dm_timers_active);
> =20
>  static const struct of_device_id omap_timer_match[];
> =20
> --=20
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--lerwfg2m56bnkpya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloEfrMACgkQ2O7X88g7
+pqR7g/9F5PNav6kZYCJxfdmlsYKJP1C8tRR8I/Fu1tLNJAZtp+BcK0+J51qPSic
C7HSm8u9uXn+WDHVNjniNsKu0SuKEdETReJTiDvbgNacin97jlbICgCg9/RWBUEU
//fJoLQU70gdltFN5iTYfglnxvj7q3jG0jlI5B9l2aJs1VCi4qCOKsc60A2TkqXp
kEvCEXi4MxY+oVWgccb4kTKYOtjVXlnYW/PKDYLaoj+4yPiTZlGPzulvVsHdqkG/
WC4xlTd0nIhzbeHxkkWO7wm8FbgHq08WifqNNgcXZ7JS2xo1PUJ9vLbnI7uF/uIt
ze/UuyoPEwgRHH7D8uCw3/5Bu+d+0NMc0cQTwP6hP5H8okTrrMSh7ZT1CRLLeZH0
nNncCAYb3CSuyaU4ZfYSAdYjuEklo5qyJEJXoZQUmoaD0AM7pXCHLJ3NsF4i16+3
MsK5UNVBHLScURK6uULthmJiV8QOAaXMY7yRYh2gOr+QPr6jWuYnmsp4lFIL7k32
Bhoeq4MZjmHIPLBh6AHps7hrYX9hbtFN1luQlzWFQSbcwxheQqLkOoLPIBEAGZfL
0UqFqnrXbRFtBb6CLU8KHYKdytONiYOCFNvC6FsqHlAgGlDqRfePxrBC2M65yYCB
UKGSQZJKmgEm84BWafVQJXqDEtpbEHe+rvfRS4Ru+hLmln1omd0=
=xzYC
-----END PGP SIGNATURE-----

--lerwfg2m56bnkpya--
