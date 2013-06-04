From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 0/2] USB: PHY: Improve PHY selection logic
Date: Tue, 4 Jun 2013 23:26:32 +0300
Message-ID: <20130604202632.GF28302@arwen.pp.htv.fi>
References: <1369999743-11758-1-git-send-email-rogerq@ti.com>
 <20130603174709.GA11059@kroah.com>
 <51AD9462.4020300@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ExXT7PjY8AI4Hyfa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51AD9462.4020300@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, Greg KH <gregkh@linuxfoundation.org>, stern@rowland.harvard.edu, arnd@arndb.de, adrienverge@gmail.com, kishon@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 04, 2013 at 10:16:50AM +0300, Roger Quadros wrote:
> On 06/03/2013 08:47 PM, Greg KH wrote:
> > On Fri, May 31, 2013 at 02:29:01PM +0300, Roger Quadros wrote:
> >> Hi,
> >>
> >> Improve Kconfig so that the relevant PHY driver can be explicitely
> >> selected by the controller driver instead of relying on the user
> >> to do so.
> >>
> >> Detailed description in patch 1.
> >=20
> > Felipe needs to take these, not I.
> >=20
>=20
> Felipe,
>=20
> Could you please take these if appropriate? Thanks.

it's for v3.11 merge window, right ? I think I'll enjoy the rest of my
vacations before taking these patches ;-)

I'll be back on office next monday, cheers

--=20
balbi

--ExXT7PjY8AI4Hyfa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRrk14AAoJEIaOsuA1yqREfE0QAJrSD5F1pIRggSxJPV3NyZMl
hfWJkNI2V7r2CMIsnCaesqmxfQijGTnhZSM7fYL8Vd44v+hmB9V1FuJO0xHiD/Z9
4OXGhIMUa3cC/FMTqn7Mtp9XqLSUHYcakMq0tc0XbZH63dQrRYOrwZvQCoqlTqX2
z3Xkll+gmrxBS4o7xDsYq8TQK2nFy+Ybg8CFTkYcPiAgKV9Mb8mMAWtlbPvHXfJI
tBD5QHSSsx0bfhnl+qcxPAzqA/maRSZVkOx1AHZTzjYX/dgK/3cdYLSE+mzojejU
41XwB6hMNu1oBToLAgg14Ow8RYZL9b64VcykBTp3nFPBM+JE/x8iTDVlGl+u5VD3
sSwmJi936jaAr2vIgNp/JUVeLGXN6OIOt238xUlLNHdWhQBHRJUt5Q0NmPMOnFtz
VzG08Ben/DM7pecZbhG/ZJy1bE4hl2WiX+Fn65U65M8sGbjyqs7xgIvK57o6KnAi
hCFS8vWcSyaETZ1joQQtZI9g79oK6e/zfbyU5h+IyRzxehagLHZaSeXpLXeKETKo
yPoAm3Z1AcRE0jyDvYYrM8KmE+UO2g1bZl0XtF3PSud39NGP5PiHweH2njDI3XUL
Jfj6sKoC81/UBbUI8+fCBYBb1B7swWm1VggDLeeaAQEsvpJKqqDeo7M/mMwyJ49V
EPTdrBSPdm09LKLNMnCb
=XTPF
-----END PGP SIGNATURE-----

--ExXT7PjY8AI4Hyfa--
