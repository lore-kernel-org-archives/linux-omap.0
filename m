From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] usb: musb: wake the device before ulpi transfers
Date: Wed, 21 Mar 2012 12:10:31 +0200
Message-ID: <20120321101030.GO3092@arwen.pp.htv.fi>
References: <1328377432-13563-1-git-send-email-notasas@gmail.com>
 <1328377432-13563-3-git-send-email-notasas@gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xiprIVX1FSGBv8kC"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1328377432-13563-3-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--xiprIVX1FSGBv8kC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 04, 2012 at 07:43:52PM +0200, Grazvydas Ignotas wrote:
> musb can be suspended at the time some other driver wants to do ulpi
> transfers using otg_io_* functions, and that can cause data abort,
> as it happened with isp1704_charger:
> http://article.gmane.org/gmane.linux.kernel/1226122
>=20
> Add pm_runtime to ulpi functions to rectify this. This also adds io_dev
> to otg_transceiver so that pm_runtime can be used.
>=20
> Cc: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

doesn't apply, please refresh.

--=20
balbi

--xiprIVX1FSGBv8kC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaakVAAoJEIaOsuA1yqREhQ4P+gNqyuxakVfCfHbKenzjv5QB
C1m0SUBM9p7qKct7wYELqeLus5YYV5uPzwrpoPz5ZgXvOfrLkiWuemu/Z9RwxUin
07qGusL5pk56sL8wbFbVZvswA0wXOhkUrRVIVqq7vo9e5k7KSMQAHxX+2rf4Q1Ym
VK5qZkHqETqrk8ZE9Unh5r/KtuOaOcbHqT/QlcNS/DzxrD961VKHmYVExR1BFxVR
ftIiEo4NnMTzC1lO/gCdhT8eEcIUnMWmbqL6Qhf5b3HhSGXeVotOIlKT+bsiH+4B
CHs9aGeRgbeu4+F4jd/Eg48Lv9IFXRBZE5lRFUwVYHCpH1IEMCo0HPyAj/4/FQ7H
azMCS7wEXh66JINrgzgp+MLngR+z2xe6l1pfXPsXmDy0iXzRcBbR4tZrT6Y4Dc9+
65rwHW7eiRiPmO4EQIM+jG+Z6snw+ciIJIKX4QZrm7qV+hJTWi88RHs1r6Tes3FW
4xhwIFlywoFrwnzxGTLyi5K7rIaei2TeUzCZ0CaJSbhzK6RyfEn/mj2SphWjrSj5
b4p8NoygbOReFOk77X+6H8IgC2lFyKNLwQei8gcl+o/EB7dqpr703NfUv+gM55s8
ZnYFFVHqcQSEwke7lYfV/u2sIvxrKvgPa7S69P13aXAZH9hEF26NAKZIOSt0kaw2
jXS6AFWrdV0D/iFbmK4Q
=1hxj
-----END PGP SIGNATURE-----

--xiprIVX1FSGBv8kC--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
