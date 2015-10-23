From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: MUSB peripheral DMA regression caused by driver core runtime PM change
Date: Fri, 23 Oct 2015 11:48:33 -0500
Message-ID: <877fmdcyzi.fsf@saruman.tx.rr.com>
References: <20151021234134.GQ3078@atomide.com> <20151022180216.GT3078@atomide.com> <20151022230133.GV3078@atomide.com> <562A2D0D.3060104@ti.com> <20151023163957.GW3078@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151023163957.GW3078-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
> From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Date: Fri, 23 Oct 2015 09:03:22 -0700
> Subject: [PATCH] usb: musb: omap2430: Fix regression caused by driver core
>  change
>
> Commit ddef08dd00f5 ("Driver core: wakeup the parent device before trying
> probe") started automatically ensuring the parent device is enabled when
> the child gets probed.
>
> This however caused a regression for MUSB omap2430 interface as the
> runtime PM for the parent device needs the child initialized to access
> the MUSB hardware registers.
>
> Let's delay the enabling of PM runtime for the parent until the child
> has been properly initialized as suggested in an earlier patch by
> Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>.
>
> In addition to delaying pm_runtime_enable, we now also need to make sure
> the parent is enabled during omap2430_musb_init. We also want to propagate
> an error from omap2430_runtime_resume if struct musb is not initialized.
>
> Note that we use pm_runtime_put_noidle here for both the child and parent
> to prevent an extra runtime_suspend/resume cycle.
>
> Let's also add some comments to avoid confusion between the
> two different devices.
>
> Fixes: ddef08dd00f5 ("Driver core: wakeup the parent device before
> trying probe")
> Suggested-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

I'm fine with this patch to fix this v4.3 regression. Greg, do you want
a pull request or can you take this in as a patch ? In any case:

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -391,9 +391,20 @@ static int omap2430_musb_init(struct musb *musb)
>  	}
>  	musb->isr =3D omap2430_musb_interrupt;
>=20=20
> +	/*
> +	 * Enable runtime PM for musb parent (this driver). We can't
> +	 * do it earlier as struct musb is not yet allocated and we
> +	 * need to touch the musb registers for runtime PM.
> +	 */
> +	pm_runtime_enable(glue->dev);
> +	status =3D pm_runtime_get_sync(glue->dev);
> +	if (status < 0)
> +		goto err1;
> +
>  	status =3D pm_runtime_get_sync(dev);
>  	if (status < 0) {
>  		dev_err(dev, "pm_runtime_get_sync FAILED %d\n", status);
> +		pm_runtime_put_sync(glue->dev);
>  		goto err1;
>  	}
>=20=20
> @@ -426,6 +437,7 @@ static int omap2430_musb_init(struct musb *musb)
>  	phy_power_on(musb->phy);
>=20=20
>  	pm_runtime_put_noidle(musb->controller);
> +	pm_runtime_put_noidle(glue->dev);
>  	return 0;
>=20=20
>  err1:
> @@ -626,7 +638,11 @@ static int omap2430_probe(struct platform_device *pd=
ev)
>  		goto err2;
>  	}
>=20=20
> -	pm_runtime_enable(&pdev->dev);
> +	/*
> +	 * Note that we cannot enable PM runtime yet for this
> +	 * driver as we need struct musb initialized first.
> +	 * See omap2430_musb_init above.
> +	 */
>=20=20
>  	ret =3D platform_device_add(musb);
>  	if (ret) {
> @@ -675,11 +691,12 @@ static int omap2430_runtime_resume(struct device *d=
ev)
>  	struct omap2430_glue		*glue =3D dev_get_drvdata(dev);
>  	struct musb			*musb =3D glue_to_musb(glue);
>=20=20
> -	if (musb) {
> -		omap2430_low_level_init(musb);
> -		musb_writel(musb->mregs, OTG_INTERFSEL,
> -				musb->context.otg_interfsel);
> -	}
> +	if (!musb)
> +		return -EPROBE_DEFER;
> +
> +	omap2430_low_level_init(musb);
> +	musb_writel(musb->mregs, OTG_INTERFSEL,
> +		    musb->context.otg_interfsel);
>=20=20
>  	return 0;
>  }

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKmTiAAoJEIaOsuA1yqRECP0P/24JT7tHI4IMxesevnzEGgQu
xa92QhS1rsmENlEpBT9Y56UCPEQ5oiiMMCSDVWzIDrt+HOlt6+fqsJnqcUmirCK5
Pd9pH4mLJkkKAiRZ7L7uiT2MjURaVGqvZqb4obD9ERC/jOhE2OMj+lS+NuxZ4rS4
KzBTVsrPASa7jBrN8AcTPjKr4yuQjawBGR9xGEBEbPzlgGf46MYLYZXxFdcfLEJp
EenZSOX5EsgsByWaJqap6/XQyLQv1Qu8EotAmffjdd+FSSdY5krgAsYNZ3Z+hs/N
07hu6r9IggN33IgE6T1h0IHLsR/xgH6E12dPHzF3LL7oY6RTBNPB6X1A+AQ9QPWo
QyIV/ndXqRaEnnI97qtONSHv4ZazAIszFo2UzPPB5Hw7TfKVphB2ZqfSl3f2bPqz
9QgteiGGCk/5A2wuPEN6BNegswsNNwmeVjw+NDoPrZ0OmATv9ahrndXPMLmyFWDR
I1LXCOmp32yiJU4aHrfxV2EV7g1qRl7gD7eBNA1GewOy0g0TIGTxZaQZbc2K9gS3
EqAvL5TjZXZ7fXlpLC2fLPxz0/bbWuZpFeVwoWpvHOAZr/ocKfakP9bLjGBLX1Nk
19CU/lfkcN/lmPFyF018FN3/Tlk/8J+sxp9XCcGenLn+Nc1Ohl8hbVbPJWvqRuxi
p2pGk4h2nVmCbvjjjLzF
=1HMa
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
