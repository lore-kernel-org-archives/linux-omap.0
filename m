From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 58/65] OMAPDSS: APPLY: add
 wait_pending_extra_info_updates()
Date: Wed, 07 Dec 2011 15:15:10 +0200
Message-ID: <1323263710.1915.24.camel@deskari>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
	 <1321953724-6350-59-git-send-email-tomi.valkeinen@ti.com>
	 <4EDF651E.3060703@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-tpwuKkWQoxurDlP1F1Q4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:56262 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755708Ab1LGNPP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Dec 2011 08:15:15 -0500
In-Reply-To: <4EDF651E.3060703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-tpwuKkWQoxurDlP1F1Q4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-12-07 at 18:37 +0530, Archit Taneja wrote:
> On Tuesday 22 November 2011 02:51 PM, Tomi Valkeinen wrote:

> > +/* wait until no extra_info updates are pending */
> > +static void wait_pending_extra_info_updates(void)
> > +{
> > +	bool updating;
> > +	unsigned long flags;
> > +	unsigned long t;
> > +
> > +	spin_lock_irqsave(&data_lock, flags);
> > +
> > +	updating =3D extra_info_update_ongoing();
> > +
> > +	if (!updating) {
> > +		spin_unlock_irqrestore(&data_lock, flags);
> > +		return;
> > +	}
> > +
> > +	init_completion(&extra_updated_completion);
> > +
> > +	spin_unlock_irqrestore(&data_lock, flags);
> > +
> > +	t =3D msecs_to_jiffies(500);
> > +	wait_for_completion_timeout(&extra_updated_completion, t);
> > +
> > +	updating =3D extra_info_update_ongoing();
> > +
> > +	WARN_ON(updating);
> > +}
>=20
> This function isn't used, are you planning to use it later?

Yes, it's used with the fifo-merge stuff. It could be added later, but
as it's related to the extra_info stuff, I think it fits better here
than with the fifo merge series.

 Tomi


--=-tpwuKkWQoxurDlP1F1Q4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO32beAAoJEPo9qoy8lh71occP/jHnVK7r7GL6QUQWszLm6CIM
E8KoZ6z7ykp/Zd1BvmZ82ZrFgSks2znZRqF8wCKhJ0ZDufoiPNEIGqzVxd2McG5A
DhpjuC4Cm/AfSBdy666J3bDeRtUjKuURfqAP/iVjK7ErxwTqkSwax/A5QFk6iIgj
z5aQxtke5gWPLSDE32VyPVZfq1dp/2LN6kPHodqWeXk3iOluZUsndB8axqPHDvnR
TOIYXnvOLzzMy/OKqoIQDUKx7T92+Y+vpWEnvjOJZwfeMqWmgRu70/GwaEglKW7X
DnFtT+7OwqKywqW1i7sgQ+pyofq/+Z10DFYIQmQ6alhUuU1R0C/PvN820TPkvqEb
KEKQKnbTX6cb6rmkR8jtF1LSM65iHxSDbHLGMdj2knmCnvj13ZQziek0r2k57IGB
o7geooXfF031gKoc6IO4VjS3WBp1i6sOJebSyH/QiwwpFX5BupopClgeD5vbJ7W0
9d/hUgEygRO1Nragl7Wk2bDeKCdP3m/2dO1dcX2g463MKeeHYy6u3TnNh4LILBYu
57sdQBCGXAN9qKIJOblX329D1sHDHEi6zvjFv86WdI02pdOkQ1NLVoLV0b3cWIQb
zdkGJhkEL0nwVeNSnCaJJltF/dDXCx6CaG8zcRqRYo+zrPoxg8U+kz4By08HNjlb
ecUUwbmHJOBKQ6gDebUr
=fK7W
-----END PGP SIGNATURE-----

--=-tpwuKkWQoxurDlP1F1Q4--

