From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 1/4] OMAPDSS: APPLY: Add manager timings as
 extra_info in private data
Date: Tue, 08 May 2012 10:01:53 +0300
Message-ID: <1336460513.1896.15.camel@lappyti>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
	  <1336028864-13895-1-git-send-email-archit@ti.com>
	  <1336028864-13895-2-git-send-email-archit@ti.com>
	 <1336402071.2667.16.camel@deskari> <4FA8A00B.4040600@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-IELcJ/w/uVSiCuK/5goK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:51226 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753142Ab2EHHCE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 03:02:04 -0400
Received: by lahm15 with SMTP id m15so1940804lah.37
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 00:02:01 -0700 (PDT)
In-Reply-To: <4FA8A00B.4040600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-IELcJ/w/uVSiCuK/5goK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-05-08 at 09:54 +0530, Archit Taneja wrote:
> Hi,
>=20
> On Monday 07 May 2012 08:17 PM, Tomi Valkeinen wrote:
> > Hi,

> > dss_<ovl|mgr>_<enable|disable>  functions handle GO, so you could have =
a
> > look at them. However, setting the timings is a bit different, so I'm
> > not sure how it should be done.
> >
> > I think we have a few different options:
> >
> > - Separate omapdss internal function (in apply.c) that can be used to
> > set GO after set_timings
> >
> > - set GO in dss_mgr_set_timings(), but don't block
> >
> > - set GO in dss_mgr_set_timings(), and block until the changes are in H=
W
> > (this is more or less what the dss_<ovl|mgr>_<enable|disable>  function=
s
> > do).
> >
> > The first one would be good if the interface drivers would need to set
> > multiple configurations, and we don't want to block after each set call=
.
> > But we don't have anything like that, at least currently.
> >
> > The second one avoids blocking, but could perhaps cause problems becaus=
e
> > the timings are not actually used yet when the function returns.
> >
> > I don't see any problem with the last option, so I'm slightly leaning
> > towards it.
>=20
> The 3rd option looks good to me too, but I'm wondering if we would need=
=20
> to do the same things with all manager parameters which are in shadow=20
> registers. Like in dpi.c, in dpi_set_mode() we set the DISPC_POL_FREQ=20
> and DISPC_DIVISORo registers, writing GO for each parameter would be in=
=20
> efficient, it's good that it doesn't happen much often. Maybe we could=
=20
> group the rest of these parameters.

Hmm, that's true.

We could make shortcuts with settings that are only changed while the
display is off. For example, currently DISPC_POL_FREQ cannot be changed
dynamically, so it could only be set when before enabling the output.
However, it seems we currently do call dispc_mgr_set_pol_freq() in
dpi_set_mode(), which could be called when the output is enabled. But
even then we always set the same values, so it doesn't matter.

For DISPC_DIVISORo, I guess we could make a shortcut with that also.
While it is a shadow register, when we are changing the dss clocks we
also set non-shadowed registers. So I think the best way to change clock
frequencies is to turn off the output temporarily.

Perhaps all the shadow registers currently being set directly from
interface drivers are such settings? The code should still be changed so
that we only touch the registers when enabling the output.

But, of course, a better design and also more future proof would be to
handle all shadow registers properly, even if we currently only set them
while the output is off. That may be left for future, though.

In any case, I think we should mark clearly the places where we set
shadow registers directly, without using the apply.c. Perhaps we should
even mark all the dispc functions that set shadow registers, like
dispc_mgr_set_pol_freq_sh(). But let's not do that now either, as we're
quite close to merge window.

 Tomi


--=-IELcJ/w/uVSiCuK/5goK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPqMThAAoJEPo9qoy8lh71g00P/1uYeFgG6Ir27TtcOXswB8CN
YZS6riU1RWn/2dTcEEVRCJN9QtJaA/I9uB8oWH9tbX1B+v1CvXjrfXw9CaV1Aafm
58CgHPXTxw3Vx0d6b6CEkvn6Bac3mCno1KWykDQ+aR/3aKmlphypZgt+0hNBBUk5
wK9duer5tlJ1CwMF0LLgnwH3wJ8llZ0l3fqsNy9AVTWt5+dOHB7dVVF/hIIU69Tt
1u/sAkDAsv0UFEy9lQrCUahqoKVFLqP2o+xlr6Sdtyu2DhsIXfcLh6twdEv3Q8pX
GFd5cMS9ExQhLJqAhO0A1ys2V6rmDzgoWWwdKobiWBUsod8BfipQXitLh8/LNyss
kPYf7hnbq8aTJD5I2TF/rDDg85O4KNxcs//zfozwaZKeAaCmnrkqmK+Wi40swO2K
YI1DDVtgPcx0E74QmierqgRRAImiLCEll6tN3NCj7ATeEcyMUEy8U0K+I4DTyNvw
bnieP8/PzubusmB8IWZizLSWu/7MWXhNaDG+/bKk/ZAeDfT7A5u5cFNrFeB1QU7l
ewve+gYlrb7b6rxf/42EhwB1cC4LktdWLanXe0Sr2syC4BvqkqVfN/KmIIWYzKh1
JLHhrAsJLBz2ATuzKoHBylf0bpY5WVJbT0kggnv8N5ci1tBJZJkDCOy3i4j0ORFb
y39elXmKtZLcjcLcjhh+
=HWM9
-----END PGP SIGNATURE-----

--=-IELcJ/w/uVSiCuK/5goK--

