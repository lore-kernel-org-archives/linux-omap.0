From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 08/15] twl4030_charger: distinguish between USB current
 and 'AC' current
Date: Wed, 4 Mar 2015 17:53:02 +1100
Message-ID: <20150304175302.02fa96d5@notabene.brown>
References: <20150224043341.4243.23291.stgit@notabene.brown>
	<20150224043351.4243.50342.stgit@notabene.brown>
	<20150302210509.GK13270@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/QDCV.JVArNhK93UDuLQZfZg"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150302210509.GK13270@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Sig_/QDCV.JVArNhK93UDuLQZfZg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Mar 2015 22:05:10 +0100 Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
>=20
> > The twl4030 charger has two current sources, 'USB' and 'AC' (which is
> > really DC of course...).
> >=20
> > If 'AC' is providing current, we should set the current limit
> > differently to when it isn't (and so USB is used).
> > So split 'cur' into 'usb_cur' and 'ac_cur' and use accordingly.
> >=20
> > Now we must review the current setting on any interrupt or USB
> > event which might indicate that the charger-source has changed.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
>=20
> > @@ -103,7 +104,9 @@ struct twl4030_bci {
> >  	/* ichg values in uA. If any are 'large', we set CGAIN to
>=20
> ichg/_cur values
>=20
> >  	 * '1' which doubles the range for half the precision.
> >  	 */
> > -	int			ichg_eoc, ichg_lo, ichg_hi, cur;
> > +	int			ichg_eoc, ichg_lo, ichg_hi;
> > +	int			usb_cur, ac_cur;
>=20
> > +	/* If VAC exceeds 4.5V (MADC 11) and ac is enabled, set current
> > +	 * for 'ac'
>=20
> 	/*
> 	 * If AC voltage exceeds 4.5V (MADC 11) and AC is enabled, set current
> 	 * for 'ac'.
>=20
>=20
> Acked-by: Pavel Machek <pavel@ucw.cz>
>=20

Thanks - I made those changes, or something much like them.

NeilBrown

--Sig_/QDCV.JVArNhK93UDuLQZfZg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVParzjnsnt1WYoG5AQJyDxAAg6Vm2b8yoX+jeCyvweO0J3dp7FM7F9HD
RyTCdFXkgOJP2XXUqUqGJ6MB1gSyqcS27Y36S2wR2iIiweLAJFZ4VKy0BcQPjF4U
G6rMy398Q4ivKLl373D90LRBheNU4g8rJNkF+5ASpEEJMQImamxZEI1ww/sU45fF
Xl1m3YZcTwSbvfJ/K1rwakD05LPfLwHYwgqhQUbld8kjMoJZCz1uJvWVtjqK1HDn
CbKvYplEOuupO9tclxis48sndtRp3YpSunG05tugLp7CEKvfo7loIXM0WDf+pQsC
Wo6rdE8uUnFkFCQ1ij9r6z9zdRMbk2olMOH7FFo7h07SnFkwVO0GCSvWfmd9lSf0
53T6qR+tc6M36I9sIj0r09wxsrYLXouF0xPCcfJCSlb89QrsGfgBdiJiV7Wi78L+
Zn9vaqk7PoKonAyU3tG12cXiibnSk0FASEk9kQOG5/InIOWHu7rprd2eR3nv8G84
HA9kpGD+ooml1wywABU/ocvydgPeehYmS1OCFDEkFeVwKZmg+iHKq6QxxNI6UDNH
ew9Yr4fsiL2RNVYY8E3hFYQuhjWg4BH5yrXkJ2dskMsez12+BLklxmREOIfkfihW
mGTZP5ySgHSTHSrxeMNlps89qCQkVDvWGMu9yWdUp+deUObaku7Erxl+41s1pvP0
O++kyflZBuM=
=UGHb
-----END PGP SIGNATURE-----

--Sig_/QDCV.JVArNhK93UDuLQZfZg--
