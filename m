From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/5] usb: musb: am335x support
Date: Wed, 3 Apr 2013 16:09:14 +0300
Message-ID: <20130403130807.GB14680@arwen.pp.htv.fi>
References: <51312430.6060306@gmail.com>
 <87sj4cunp6.fsf@dell.be.48ers.dk>
 <5133E268.5010604@gmail.com>
 <51388D64.9000005@gmail.com>
 <513A1580.90303@gmail.com>
 <514863BD.5010503@gmail.com>
 <87620nwmd2.fsf@dell.be.48ers.dk>
 <515C19D7.6080702@gmail.com>
 <20130403120454.GX25837@arwen.pp.htv.fi>
 <515C23D4.3010206@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <515C23D4.3010206-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "Santhapuri, Damodar" <damodar.santhapuri-l0cyMroinI0@public.gmane.org>, "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 03, 2013 at 02:43:00PM +0200, Daniel Mack wrote:
> On 03.04.2013 14:04, Felipe Balbi wrote:
> > On Wed, Apr 03, 2013 at 02:00:23PM +0200, Daniel Mack wrote:
>=20
> >> Felipe, could you explain the background on how the dsps driver is
> >> supposed to work in host mode at boot time with the rework of the driv=
er
> >> you did for 3.7? It might just be me not understanding the rationale
> >> behind all these changes, but appearantly, I'm not the only one who's
> >> affected by that.
> >=20
> > right, so the idea with that was to drop the huge amount of ifdeferry
> > hack from the MUSB driver. It would be great if someone would send
> > *CLEAN* patches adding Kconfig-based role choices again.
>=20
> Are Kconfig-based rules really what we want here after all? Wouldn't
> run-time configured settings make much more sense, considering that

we need both. Say that you want to build a product with MUSB hardwired
as host, why would you enable gadget framework ?

I can think of at least am335x where this would be perfectly plausible
(no EHCI available, only MUSB).

> people might want to run a single kernel image on multiple platforms? I
> believe it should be up to the DT to define the actual hardware wiring.

Right, for runtime decision Ravi pointed me to a patch implementing that
(Ravi, could you post it by any chance as RFC ?) which we could start a
discussion and hopefully merge for v3.11

--=20
balbi

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRXCn5AAoJEIaOsuA1yqREdqMP/RDU+5VOVM+70y1roTzXJCmP
2fk9OtK7/0mqIYMTEIOVCCTJVaYvuqp/2Fqa0WHPrrRDoZGylwcIXR8lv/eZzvqq
anO9z+NJ394PryDXwfyeiUUjarOrBwZvkMrMtIp4ZkSfbpMh/qbRiPMmjUBYS0q9
Q2qtaANz2jFUKd9zCbuxeaylK+NtYMIwoTQyC0vU6VY8Wr6ulVcKMXhExBOx1mO3
ZGvjPQDWNfLCMiZYf3s4jg/Rtc4B+qn278u/eMP2nXMhLPuIjlnvr1xdmKTRIb49
00fyStEjVQpngJ8fdqlIlCkTTttKBJIZ2VmAhf/iOaG1gqyr3YSfnAEXH5Tu7GWN
8wmlOo9cG0A7H+sPkN5xTYUQkRrkwUkSBDIgJ+k0DWqX9og+4dpaDOMWuRR6xlpJ
rxosi6In5Ldsz4tM8fMp7BT6WkMvZVrqo3R4CXzRAup28+7Sxh7jjBNgwV94KWbt
uJLvuVZ8AmwqGiiazg3c3O5P1ERzCSqNp1X3aRkKwL8oYWkECIfjuYzVl8dPBaNx
Qmwm5UczrMnXNLTdFMZ7uzkjxeH/BByhEuM62yAIcbJZyYYAHb1fUl97nAYGWpo8
ajG9z0w7rJxdeo5dMff2FWek+LXSCRbPDQWowsrgkrK9425XQO92Aw65oHa/fxVT
pm90OvHSjrlosYikbP7+
=2DzP
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
