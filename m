From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 1/3] usb: dwc3: Add the suspend/resume functionality
Date: Thu, 18 Oct 2012 20:29:36 +0300
Message-ID: <20121018172936.GB7823@arwen.pp.htv.fi>
References: <20121018150009.GT5378@xanatos>
 <Pine.LNX.4.44L0.1210181244080.1495-100000@iolanthe.rowland.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45121 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932125Ab2JRRfQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 13:35:16 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1210181244080.1495-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, Felipe Balbi <balbi@ti.com>, Vikas Sajjan <vikas.sajjan@linaro.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, joshi@samsung.com, kishon@ti.com, Abhilash Kesavan <a.kesavan@samsung.com>, Doug Anderson <dianders@chromium.org>

--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 18, 2012 at 12:44:50PM -0400, Alan Stern wrote:
> On Thu, 18 Oct 2012, Sarah Sharp wrote:
>=20
> > For system suspend while the DW3 hardware is in host mode, doesn't the
> > USB core prevent drivers from submitting URBs just before the
> > PCI/platform suspend is called?  Alan?
>=20
> Sure it does.

ok great, so my concerns is limited to the gadget side ;-) I still want
to see both sides tested, though.

(sorry guys, but with DWC3 now passing full USB3 certification, I want
to be very careful with patches I accept, specially related to PM ;-)

--=20
balbi

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQgDyAAAoJEIaOsuA1yqREJ/QP/233m88UwUKaDcUkHJ3YvKL8
is0mKeDyeyinM0vthGqPyEImNVNbrQmBsgZRWTuXxc9RfJqwWwZJaE6/SyWKAv+T
krw1NdDfmzH4U1Z4JVxSIHN28/xCpa4RvCGDybGwZZBID2JOFqHjbTBSYtLpS527
EjM0+ykrKZqCN1xgHMzNUuZFw2DuYSeyAnSesCLAIbhpOpOIoWx/Yfo+4YWqX7v6
A26/l5GFZkHU6PszYgi+6KqmbugY9mVKpGsAQapYktTeILd5sbv1ZrlIc2ZgdW1z
ElN8Wjbs8eN31xvbZJ0AEgtjl9M+6AZmDcPhTWFiCL9tVcms4u/QHA8T9x8h745p
+YF7pJ3Gp9c6ByON6yb9NMy8AL1hftNT8XwXuu14WZojZfrEjf234mx9ykW6QkRp
svqpXqdyIDkINTokmkv7Yezmx6zRMiRB616y3/NdzNJfWHnKwbPqycZR/T9j5dfd
WF+4tN6/1zxGjmpxVTFzaBrhiGkVI1hK4qrTBQg9cJUZbXTF4tHRLD1HaryzVozN
NB1cvhKTdbgec8NyP2pVvcSgrot9Mx3n6SyGos/1Ez3OfBe2B4HwXSAXsJnXXQUr
fJqpO9onF92ke7Ht6FzrkE/iJyEf+vxbOz/jJFcW96TqTW9ZV+1F9uQSKQAQjQlK
5enyPj6vkPtmX06l+VkK
=dop+
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
