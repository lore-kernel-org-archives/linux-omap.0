From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change
 state
Date: Tue, 26 Jun 2012 18:01:15 +0300
Message-ID: <1340722875.24530.66.camel@deskari>
References: <Pine.LNX.4.44L0.1206261031450.1636-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-EEF0ADtupsxtnBXZ27Xh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:52449 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757325Ab2FZPBV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 11:01:21 -0400
Received: by eekc1 with SMTP id c1so6847eek.10
        for <linux-omap@vger.kernel.org>; Tue, 26 Jun 2012 08:01:19 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1206261031450.1636-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Rajendra Nayak <rnayak@ti.com>, jaswinder.singh@linaro.org, mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org


--=-EEF0ADtupsxtnBXZ27Xh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-06-26 at 10:34 -0400, Alan Stern wrote:
> On Tue, 26 Jun 2012, Grazvydas Ignotas wrote:
>=20
> > CCing some PM people, maybe they can comment?
> >=20
> > On Tue, Jun 26, 2012 at 7:51 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> > > On Monday 25 June 2012 06:20 PM, Tomi Valkeinen wrote:
> > >>
> > >> Do you know how the drivers should handle CONFIG_PM_RUNTIME=3Dn?
> > >> Are they supposed to handle the error values returned by runtime PM
> > >> functions somehow, or should they use #ifdef CONFIG_PM_RUNTIME?
> > >
> > > hmm, I always though with CONFIG_RUNTIME_PM=3Dn, the functions would
> > > be stubbed to return success and not failure.
>=20
> Not exactly.  They are stubbed to indicate that the device cannot be=20
> suspended, that it is always active.
>=20
> Failure to suspend a device should not be regarded as particularly bad,=
=20
> because it doesn't affect the device's functionality.  That's true even=
=20
> when CONFIG_RUNTIME_PM is enabled.

This makes sense. So if CONFIG_RUNTIME_PM=3Dn, using pm_runtime_get_sync()
will return 1, meaning the HW is already enabled, and using
pm_runtime_put_sync() will return -ENOSYS, meaning the hardware cannot
be suspended.

With CONFIG_RUNTIME_PM=3Dy, it's a bit more complex. If I read the code
correctly, when I call pm_runtime_get_sync(), the usage counter is
always increased, even if the pm_runtime_resume() fails. So a get()
needs to be always matched with a put(), even if get() has returned an
error.

But if pm_runtime_get_sync() returns an error, it means the HW has not
been resumed successfully, and is not operational, so the code should
bail out somehow. So basically I'd use this kind of pattern everywhere I
use pm_runtime_get_sync():

---

r =3D pm_runtime_get_sync(dev);
if (r < 0) {
	pm_runtime_put_sync(dev);
	/* handle error */
	return -ESOMETHING;
}

/* do the work */

pm_runtime_put_sync(dev);

---

Is this correct?

 Tomi


--=-EEF0ADtupsxtnBXZ27Xh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6c67AAoJEPo9qoy8lh71UJEP/RivQ5xkJrRK9phiKM6UxeUM
BGRd0ZZrZDIXFoYk2zDJDb1OZGHfkVyxJI/yO8z1LpyuGk8lZxeO572yt4tD9IBV
5hFtxS55UW3bmpkOnhm5W6wX22ibKQhUYkQgw4whZ0RCsJyCchpCBc/Sjo6Ifj+J
zS43lPkFk/cJjjSWxEwZor0+54jOsK61G+jICnUQeU7y4XnrwHImq17M7tuhRp8V
IDSERUAir0e4ziC6eaZ/mPFy02lMeeunlpAjH/cIOzb5cuQnaNR9BfZ8Uzcz9Cx/
900NqNCG1azPiH89DGvpE04+BDFUB4P8qbriPW/xmxr6RQtsiQLM06KkjXDOO8BC
K4dIy8tNlURbJP7HMkbUt1qKQnXsCCBNxd2TKn2JSccuH5eCee+TCjcDerLbvTDJ
mXhXXS4HQBz6cSdSv63EYxwYSMWh3wOiexfZgysSeZ3LDctSgqr65A8Sbj5L7Opx
DEWHgvgHjjBqw8+DUWX4Zx3qw8CTuHCoU7kTMHgZ2iYc7BjSXQu0v7B5pXn3qEou
I4fgChNmAnjFydVUs7NTzCpOYRVMSGBRM7OYNr+kUtlqzgvz9HLki1NvAZnsnYhf
euMH95EBi216g/FKmTZxtbmeZbeBchYEL3sr2Ar7d1VxEIh9bNWibs9+ZjXpw+kw
38SIN8zFyhReLx/2g+Ut
=3cJv
-----END PGP SIGNATURE-----

--=-EEF0ADtupsxtnBXZ27Xh--

