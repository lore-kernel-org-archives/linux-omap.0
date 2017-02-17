From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3 0/3] Adding DT support for TI HECC module
Date: Fri, 17 Feb 2017 09:51:46 +0100
Message-ID: <b6c8bfbe-1748-ee2c-2129-96e1bce9b324@pengutronix.de>
References: <1487170125-10815-1-git-send-email-yegorslists@googlemail.com>
 <7c8fb14d-835b-d1d0-ca4f-4d184b711ae0@pengutronix.de>
 <CAGm1_kuQ1skHayOKu16JdZ3Bah+=CqzZJ5e6j2VDj3WW5No2vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="KJE84MgWkEnPIPp71bkee9qCqe0c0lu7x"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGm1_kuQ1skHayOKu16JdZ3Bah+=CqzZJ5e6j2VDj3WW5No2vw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Andrey Skvortsov <andrej.skvortzov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, hs-ynQEQJNshbs@public.gmane.org, Anton Glukhov <anton.a.glukhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KJE84MgWkEnPIPp71bkee9qCqe0c0lu7x
Content-Type: multipart/mixed; boundary="BnV1JKMs08aKXdDITR3QWqxVTVOlAbUir";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
 Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>,
 Andrey Skvortsov <andrej.skvortzov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, hs-ynQEQJNshbs@public.gmane.org,
 Anton Glukhov <anton.a.glukhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Message-ID: <b6c8bfbe-1748-ee2c-2129-96e1bce9b324-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3 0/3] Adding DT support for TI HECC module
References: <1487170125-10815-1-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
 <7c8fb14d-835b-d1d0-ca4f-4d184b711ae0-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
 <CAGm1_kuQ1skHayOKu16JdZ3Bah+=CqzZJ5e6j2VDj3WW5No2vw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
In-Reply-To: <CAGm1_kuQ1skHayOKu16JdZ3Bah+=CqzZJ5e6j2VDj3WW5No2vw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>

--BnV1JKMs08aKXdDITR3QWqxVTVOlAbUir
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 09:50 AM, Yegor Yefremov wrote:
> On Fri, Feb 17, 2017 at 9:46 AM, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>=
 wrote:
>> On 02/15/2017 03:48 PM, yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org wrote:
>>> From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>>>
>>> This is an attempt to revive DT support for TI HECC that was started =
in 2015 [1].
>>>
>>> Changes v2 -> v3:
>>>   - rename compatible property to "ti,am3517-hecc" (though there is a=
 stipped
>>>     device named 3505, EMAC driver already uses am3517-emac name, so =
keep this
>>>     property consistent)
>>>   - use reg-names to specify different HECC I/O mapping (suggested by=
 Tony Lindgren)
>>>   - provide fallback offsets and sizes for board files
>>
>> Are there any board files using te_hecc intree? I don't see any on the=

>> first glance. What about making the driver DT only?
>=20
> Good idea. I aslo wanted to ask this. So this means we could
> completely get rid of include/linux/can/platform/ti_hecc.h?

If there isn't any in-tree user, thes yes.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--BnV1JKMs08aKXdDITR3QWqxVTVOlAbUir--

--KJE84MgWkEnPIPp71bkee9qCqe0c0lu7x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlimuaIACgkQHv7KIOw4
HPbiUAgAoY6O6B9OhVr7jTtIXm6EhBgBv63UUOzqAbk58LTCoBMwUZaZOit6trMu
cg4WSPVpnFPg3/HqgY5zAP+MGMTzdR7vn0Ph1xP1iLkSxsaIFAbwwyfKJk2afO//
alcua84NfCS4Fzeg//f808Nhsygixwnumz3b3Xe4X1M9Vng2ymMqlvEGchgAq6K/
jY5ZHeTKlvM2LUk3pC46v0lp3mf9fWvxIotUcpAxjs0hYqHxsKr7HYLZw0yueOhV
zdbvSlg54fyin1FeSL89TX88EuoowwMKNMj0IO1PTXE5UAHKcwQ/tMXZzqHhI4Tn
zi08in+wqfSYmuFZPoYCDxeanE0j/A==
=eJI8
-----END PGP SIGNATURE-----

--KJE84MgWkEnPIPp71bkee9qCqe0c0lu7x--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
