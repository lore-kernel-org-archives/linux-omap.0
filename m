From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4.14] Add support for bq27521 battery monitor
Date: Fri, 8 Dec 2017 18:06:10 +0100
Message-ID: <20171208170610.gbmlsgm7xzh2zpyn@earth>
References: <20171109210615.GA27638@amd>
 <20171110103937.GA29900@amd>
 <20171201230649.GA27533@amd>
 <cfa89227-e08a-849f-c886-723268ae657c@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4b73ibcjevchptm6"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cfa89227-e08a-849f-c886-723268ae657c-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org, abcloriens-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, clayton-fehKsxFhGzZIf6P1QZMOBw@public.gmane.org, martijn-28JJ9oSIdodmR6Xm/wNWPw@public.gmane.org, sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--4b73ibcjevchptm6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 04, 2017 at 09:20:33AM -0600, Andrew F. Davis wrote:
> On 12/01/2017 05:06 PM, Pavel Machek wrote:
> > Hi!
> >=20
> >> This adds basic support for BQ27521 battery monitor, used in Nokia N9
> >> and N950. In particular, battery voltage is important to be able to
> >> tell when the battery is almost empty. Emptying battery on N950 is
> >> pretty painful, as flasher needs to be used to recover phone in such
> >> case.
> >=20
> > Sebastian, ping? This one should not be too controversial.
>
> Acked-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>

Thanks, queued, I dropped the spurious change in twl.h and added the
dt-binding from the previous patch version, that was lost somehow.

> > If you could also apply the "shut down when battery is low", that
> > would be nice.

I only have one with values specific to N900 hardcoded in the
driver. That one can't be applied for obvious reasons.

-- Sebastian

--4b73ibcjevchptm6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloqxnwACgkQ2O7X88g7
+ppmHxAAohSyPOiKxNsmte5Ut12ziRfcwyA91iNTe//P65PGAfYPuO8vGNJCUCWf
53RwrT8ayHMTGbNbEeWKs9Sw5VlTiKliRA1KkfPAUGflW6l+qJbbWI7YlcZmz4EN
XuOTSO+ORJb+E4lRn7XoLNgLfDaBt24g784v69kZ39AHgX28WXcTLHAQTKi4qBHg
yUIXonBWRk8R+O3a/YJdIdWcKVVOennS/M2Ayc2pHdHRjPR8ozdj08N0Zwo1N4ZE
xFDAn45zXa1fkTB1qPehjqq8KvmHPBOmOd8ikG0IZljdQ3Zu9tWoGdCy681wO2Vr
Wggxxq+lg2pCmCZyPwmpkbVbK5mSWK4iaerLNKr05HA9ai7jzoyEMJRY9Ux5N/Cb
VTtYAPKG+MabJIbPDe3hsv1c6Z130/V1PpVsClJM9iMwgFMn/rOBhcjs84UIqWIe
ZVn/5e9vIQV1kr0rFEXbdltxQzKxtmxRaJX/n1KYi5Ik+KRmGSDv+NwxpfLWSlxx
rOtRasFDcLDINNLyzRnwn+SSeDzBoJ7VdDmaSWgWR88/IgTInxRifamCAxM+Sf7W
aBW0Z6Hxvwc2F2U3yGQ0g6zOFQyVLSwDCrrgze8BuoYOrD3Kk3XRTfM90CmqrEBF
AHn0Dspsjuedp3CZU7a+Z19efH02qhsYCF6F4PbI/RjnvPjO+7o=
=DZ36
-----END PGP SIGNATURE-----

--4b73ibcjevchptm6--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
