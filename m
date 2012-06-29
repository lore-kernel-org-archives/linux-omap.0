From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 07/12] OMAPDSS: APPLY: Remove DISPC writes to manager's
 lcd parameters in interface drivers
Date: Fri, 29 Jun 2012 13:12:25 +0300
Message-ID: <1340964745.1866.26.camel@lappyti>
References: <1340893842-10626-1-git-send-email-archit@ti.com>
	 <1340893842-10626-9-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-IuubvQT4sOKDL0lSxa4u"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:47258 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753217Ab2F2KMd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jun 2012 06:12:33 -0400
Received: by lbgc1 with SMTP id c1so5005187lbg.29
        for <linux-omap@vger.kernel.org>; Fri, 29 Jun 2012 03:12:28 -0700 (PDT)
In-Reply-To: <1340893842-10626-9-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-IuubvQT4sOKDL0lSxa4u
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-06-28 at 20:00 +0530, Archit Taneja wrote:
> Replace the DISPC fuctions used to configure LCD channel related manager
> parameters with dss_mgr_set_lcd_config() in APPLY. This function ensures =
that
> the DISPC registers are written at the right time by using the shadow reg=
ister
> programming model.
>=20
> The LCD manager configurations is stored as a private data of manager in =
APPLY.
> It is treated as an extra info as it's the panel drivers which trigger th=
is
> apply via interface drivers, and not a DSS2 user like omapfb or omapdrm.
>=20
> Storing LCD manager related properties in APPLY also prevents the need to=
 refer
> to the panel connected to the manager for information. This helps in maki=
ng the
> DSS driver less dependent on panel.
>=20
> A helper function is added to check whether the manager is LCD or TV. The=
 direct
> DISPC register writes are removed from the interface drivers.


=20
> +static void dss_apply_mgr_lcd_config(struct omap_overlay_manager *mgr,
> +		struct dss_lcd_mgr_config config)
> +{

This one should take a pointer to the config, not a copy (and const).

> +	struct mgr_priv_data *mp =3D get_mgr_priv(mgr);
> +
> +	mp->lcd_config =3D config;
> +	mp->extra_info_dirty =3D true;
> +}
> +
> +void dss_mgr_set_lcd_config(struct omap_overlay_manager *mgr,
> +		struct dss_lcd_mgr_config config)

And this.

> +{
> +	unsigned long flags;
> +	struct mgr_priv_data *mp =3D get_mgr_priv(mgr);
> +
> +	mutex_lock(&apply_lock);
> +
> +	if (mp->enabled)
> +		goto out;

Hmm. Should we print a warning or such here? Isn't it a bug in the
interface driver, if it tries to set the lcd config when the output is
enabled?

 Tomi


--=-IuubvQT4sOKDL0lSxa4u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP7X+JAAoJEPo9qoy8lh71cxIP/1lUH9kwY9X88vO7USYefDHd
lmIXMqXUVts11Ioiqk1TiyLCwKwhq8XnHuio5zbNS9VWmKfg07cPxldpvQKpvLok
Ctu0UHhbu7JrKPZMNsdhrixpOsLtE1yzHlFSNAxyH7nrzetTg/6SCaKlmNgENk5N
27s7gY8axWmXoCCmR4FkAjWE8ZksTEeedKBrlqxM5KbzaTpZNMQYHdWASNdIRR0y
0T5WpofbGpioK0mjFILoXugQLctNheKN9EDCP1cmOh0iiNbFmWeca0Kqq4sMCW0O
QJr/hajJSRTxKh4wzY1qj/0/Xs+JUeZnVyB/ZDWJrvFfe2vlhdYtM9tLoE52SMOw
xgbccTZmFYhg1D2IMBo1G5VQvYFDvFoOOaG04OwSj1S3nUnQ7oeYCp4O+FaxyjUw
vIVpb6SSFElCoUN1Y1QxOzkJill3a2BtodpvdZHeGrm1kTcuK6luCS3lcP+tadz0
gKnAh77BDRQBRlcWWI2bGSmqWfwPQ2fyQcCsA54o7WMFCdycerzmUJU5QaP4XFA2
pXIgxfEtAy1y2N1+KBjAndVVePXsAmlWcoy833imgmRBhs5voeW3z5Ck1KFdmRm8
H5xU7kLIYCFnWKs6RhAO+UZY7wVUmQjOjophULbRQIwVluz7yfUrDNsGqVf849q3
7pb9ge3hz0cb/6HWjasO
=dfs/
-----END PGP SIGNATURE-----

--=-IuubvQT4sOKDL0lSxa4u--

