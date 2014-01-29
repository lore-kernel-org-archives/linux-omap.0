From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH 0/6] N900 DTS additions for 3.14
Date: Wed, 29 Jan 2014 16:47:29 +0100
Message-ID: <20140129154729.GA27128@earth.universe>
References: <1389475023-11616-1-git-send-email-sre@debian.org>
 <20140120155950.GB17118@earth.universe>
 <52DE612E.2080205@baylibre.com>
 <20140121132653.GA8964@earth.universe>
 <20140129150328.GA25527@earth.universe>
 <52E9188E.1080404@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:54047 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702AbaA2Pre (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Jan 2014 10:47:34 -0500
Content-Disposition: inline
In-Reply-To: <52E9188E.1080404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nishanth,

On Wed, Jan 29, 2014 at 09:04:46AM -0600, Nishanth Menon wrote:
> On 01/29/2014 09:03 AM, Sebastian Reichel wrote:
> > On Sat, Jan 11, 2014 at 10:16:57PM +0100, Sebastian Reichel wrote:
> >> Here are a couple of additions for the Nokia N900 Device Tree
> >> Source file. All related drivers changes are queued for 3.14
> >> (except for the tpa6130a2, which got merged into 3.13).
> >>
> >> I may have some more additions if the driver changes for the
> >> accelerometer, the touchscreen or the wireless lan chip will be
> >> queued up.
> >=20
> > Ping. If I'm not mistaken the merge window will probably be closed
> > at the weekend (2014-01-19 + 2 weeks =3D 2014-02-02).
> >=20
> > P.S.: Accelerometer, Touchscreen and WLAN driver changes haven't
> > made it into 3.14, so the patchset I mailed is complete.
> >=20
> > -- Sebastian
> >=20
>=20
> It is usually suggested for dts patches to be cced with devicetree and
> linux-arm-kernel lists as well..

Well I CC'd them for the patches adding the binding documentation
and updating the drivers. I think its not so common for the dts
entries to reduce the workload of the DT binding maintainers?

Of course I can add them for future patchsets.

-- Sebastian

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS6SKRAAoJENju1/PIO/qaI1sP/02epRwujO8TM1xm6R18qVSx
+olbEtN9Uwf0/5Ygf+lxTb+efBlRTjynYt4n40pL8wfwSag1Drf6MGEKHHGU7ZoD
p2hVWb8IzF4tnuBcfp1Ab17qLjNFu0eJHfNxAyQ193au5D3JgeOBePNpOA6gzg1u
/1G+LGVyC8tGXHUp7vE+jPU5dVKMh5hIjYn0tB00E3YMkCX6kBs+SS8iMeaMo5uD
C5H+tH3owMR3Qyav2Hwl4Fhr7MxIXjyWTge/Y1rZ+dlwGJRRbN1+wbRc4ScByr3j
gIw6D0OHhu2yU8SXmfToj5tRoRnQ5173+e0Q7dB5A4rEXpoaTwk2X68TYfDi1lxl
CbA123wfCy5ZvahQyPr7AupkR/7Drqz3XmTV4QkDUYLJfwD+YYQ61n6XqZrqgSzU
SmgYS1aUm0+IP4WteTLqsn9p2nYX2lJqZRzUIsW+TA8/YD+oH14dq6VYWnzI8d4R
ALPHE052VKDS3f8/IGi86w+tNMfHxkCIfhAQ8itmcA0a+QdtpbRqCR7Hb+MMYNGm
sDUeZU3rxmFf/g59iii6allKLXaNAW2YWMiW7KuOrVVGx1QhA/WO+WfzsxlaZzKQ
ZNerYQ5IH5pB8IfYfULmopbrTnYnMqWVZUzlLNZWLtCC+gFRejMlBRqzyfBQ3zl8
HyckL24G7xoFrUnkmHh2
=t5wt
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
