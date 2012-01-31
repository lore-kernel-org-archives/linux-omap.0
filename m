From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/2] staging: tidspbridge: fix incorrect free to drv_datap
Date: Tue, 31 Jan 2012 21:43:39 +0300
Message-ID: <20120131184338.GO3356@mwanda>
References: <1327972818-30993-1-git-send-email-omar.ramirez@ti.com>
 <1327972818-30993-3-git-send-email-omar.ramirez@ti.com>
 <20120131082136.GC3294@mwanda>
 <CAB-zwWg9iudV7o5opYHOMHo8HN9EGB+n0f=mAHQCNWZovHrdvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="apqMg07LpBOyFFAR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:58522 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423Ab2AaSmR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 13:42:17 -0500
Content-Disposition: inline
In-Reply-To: <CAB-zwWg9iudV7o5opYHOMHo8HN9EGB+n0f=mAHQCNWZovHrdvQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org


--apqMg07LpBOyFFAR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2012 at 12:19:00PM -0600, Ramirez Luna, Omar wrote:
> On Tue, Jan 31, 2012 at 2:21 AM, Dan Carpenter <dan.carpenter@oracle.com>=
 wrote:
> > On Mon, Jan 30, 2012 at 07:20:18PM -0600, Omar Ramirez Luna wrote:
> >> This structure is still used after it has been freed, since it
> >> is being allocated in probe, calls to free it have been moved to
> >> module's remove routine.
> >>
> >> This should fix the follwoing messages when attempting to remove the
> >> module:
> >> =A0drv_get_first_dev_extension: Failed to retrieve the object handle
> >> =A0drv_get_first_dev_extension: Failed to retrieve the object handle
> >> =A0drv_destroy: Failed to store DRV object
> >> =A0mgr_destroy: Failed to store MGR object
> >>
> >
> > So this is only triggered when you do an rmmod to remove the module?
>=20
> Yes.
>=20

How often do people rmmod things on a production system?  Hopefully,
never right?

regards,
dan carpenter


--apqMg07LpBOyFFAR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKDZaAAoJEOnZkXI/YHqRMPsP/2sEK9DZshnHJJJfzsuAE6Lp
OyP4mziHLsOy25TaoiHoDByqwVWxGZFZiRKE8ZvVGsOnF8rAE7BvKkjuxnd3KD3g
ypkxwNupS7230s+46rornn7vN3FA9t9w3eg0XGjeHR67q0/+4/yy83Pa+eJ2Arfl
C1AUnupQ15r+XIMyyQf5CxI12WhyPDD7d23YUVEjfYgEtfuywRQnTS8MJ8XDMctX
AQVELmknIyaqM9UbX94M2Rw8Rncz4BAJ0SByeo01xmlbgeBBoV6QeNo64hbZyZO3
Qy3PxCtLgFFmuIY5Qx5MCy1Hp7xrTtgKQfgG1Rm8VNz1JeVI3bjBPYIkpnJBsI3I
SNbqwG9BItolO6PlOIb9/csh7NnL5IWU5JhcnOTk/k0gkxoFBmEGfqnSIf2pbaOj
u+Zi9hnxeZwv4zhWfLqFAaMl1BGAGwXiVG4K6LPBikgbvdq6gAPWDMA4aEql02Sn
bFgestTgVwxQr/yTQvXErDeiSMx+EQwCmvuahqlZ9BZwbrLyBsILjdy8bE8P4Akp
lUNItp3N7k0qPkJ0Ms2IS6Et7xRtcvR0luLecaeLBRKuzYCh4d/n4EYRs6F23vRo
duVhg3UcdSJ8rB+osCMbIFx+eRz3KwwJbz04sIzeSLt64+0WzZIJtKmgOsF+M0Pl
isOV/RDyYAp5B5o0mWB7
=FtlU
-----END PGP SIGNATURE-----

--apqMg07LpBOyFFAR--
