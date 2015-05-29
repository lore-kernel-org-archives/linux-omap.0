From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] PM / Wakeirq: Fix typo in prototype for
 dev_pm_set_dedicated_wake_irq
Date: Fri, 29 May 2015 12:18:37 -0500
Message-ID: <20150529171837.GI2026@saruman.tx.rr.com>
References: <1432918442-2043-1-git-send-email-tony@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fjX3cMESU3XgGmZ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45684 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184AbbE2RVN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 May 2015 13:21:13 -0400
Content-Disposition: inline
In-Reply-To: <1432918442-2043-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>

--2fjX3cMESU3XgGmZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 09:54:02AM -0700, Tony Lindgren wrote:
> Looks like I only built test the dev_pm_set_wake_irq and not the
> dev_pm_set_dedicated_wake_irq case on x86.
>=20
> Turns out there's a typo for the dev_pm_set_dedicated_wake_irq
> prototype that causes a build error if CONFIG_COMPILE_TEST
> and CONFIG_MMC_OMAP_HS are selected.
>=20
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Reported-by: Jim Davis <jim.epost@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

cool:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  include/linux/pm_wakeirq.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/include/linux/pm_wakeirq.h b/include/linux/pm_wakeirq.h
> index 4046fa1..cd5b62d 100644
> --- a/include/linux/pm_wakeirq.h
> +++ b/include/linux/pm_wakeirq.h
> @@ -30,8 +30,7 @@ static inline int dev_pm_set_wake_irq(struct device *de=
v, int irq)
>  	return 0;
>  }
> =20
> -static inline int dev_pm_set_dedicated__wake_irq(struct device *dev,
> -						 int irq)
> +static inline int dev_pm_set_dedicated_wake_irq(struct device *dev, int =
irq)
>  {
>  	return 0;
>  }
> --=20
> 2.1.4
>=20

--=20
balbi

--2fjX3cMESU3XgGmZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVaJ9tAAoJEIaOsuA1yqREGCMP/RL7Qb4EUi1zla9479KWrPCd
5lN3S1yZlR2+sYVZRZIHScLvSh0RcQUZQCoD0F5GktNfpxNqAYcho7gqUoSK+1Ct
67hQAujcSRMw0rSTqpS2C5AzVCsbvpNkoBob31mn75BRwFi9N93nuBJ6tNCkXaHk
uK4lvrAznldRuoZdQmnA+127KKbSpIuHV8XXo+rV4WZNVnA1PsT2PgLKt/4UwVe5
MS6Yx8vGf2rir6/ngSAJftC/fKw+YV8COxiNRGHNb7iHczCPog3st9G9OUocxQgM
54kTs2YP4XkaSRebG2GRpRHdF0s+09zEK0TjXnHZzDMqxZUSeMK5P+A/q4cy3IZd
xT2OIJQkhcn8FBR4aXcERhhH27m93pxQUR3aom18OLlSJK4BjMdDjjy2whgq7wDJ
v4LIYgyDhIgpjWw8UAOihkn9lCzCeWjxdFJBVwvNZ2dwEg1Le764n8LLgQCgJwLX
EQGoASZGXM0mtjdyPGFcMFzdxWkc/7itHfuv0OAIUQovOTF6aVkmQq5KfCOgl3eD
+SOug91UGE4khbp62Gj0oG5/h42Q2yXmpTDIGPdEbI1aNNDC+YqAHeDHnmDUrEAn
2pGqSIHZWFUnqyytpqXnPqgbNLADlBbNNLE988UujEki92HHIFq7K2B4kphB8BjS
FgiQibMVwxK5XKSmvdy1
=8qyh
-----END PGP SIGNATURE-----

--2fjX3cMESU3XgGmZ--
