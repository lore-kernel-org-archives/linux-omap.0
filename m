From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 4/5] OMAPDSS: APPLY: Remove display dependency from
 overlay and manager checks
Date: Tue, 08 May 2012 14:55:39 +0300
Message-ID: <1336478139.5761.27.camel@deskari>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
	  <1336471096-21096-1-git-send-email-archit@ti.com>
	  <1336471096-21096-5-git-send-email-archit@ti.com>
	 <1336474223.1821.6.camel@lappyti> <4FA901EC.8020002@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-cyO+YiaZoONE3Oy0ISN3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:43529 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753187Ab2EHLzo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 07:55:44 -0400
Received: by lban1 with SMTP id n1so3968585lba.24
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 04:55:42 -0700 (PDT)
In-Reply-To: <4FA901EC.8020002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-cyO+YiaZoONE3Oy0ISN3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-05-08 at 16:52 +0530, Archit Taneja wrote:
> On Tuesday 08 May 2012 04:20 PM, Tomi Valkeinen wrote:

> > Checking the validity of all the settings is a bit tricky, but currentl=
y
> > I think, as a rule of thumb, we should accept any settings when things
> > are disabled. So, until the interface driver sets the timings before
> > enabling the output, all ovl/mgr settings should be allowed. And we
>=20
> We have 2 ways to go about this, one is to have an initial set of=20
> 'always valid' values like I have done, the other option is to ignore=20
> manager timing related checks if the manager is disabled, i.e all=20
> configs are okay. To implement the second option, I think our function=
=20
> dss_check_settings_low() would get more complicated. We would now have=
=20
> to pass mp->enabled outside of apply, and pass it to dss_mgr_check()=20
> which would further need to pass this to dss_ovl_check(). Hence I used=
=20
> the first approach.

I'm not sure about that. We already do it for overlay. In ovl.c we have
dss_ovl_simple_check() and dss_ovl_check(). The simple check sees if the
settings pass basic sanity check. The check sees if all the ovl & mgr
settings are compatible with each other.

Simple check is done when setting the config, called from
dss_ovl_set_info(). The proper check is done later when the actual
config is about to be taken into use.

If mp->enabled =3D=3D false, can't we just skip dss_check_settings_low()
totally for that manager? We skip the check for ovls the same way.

> > shouldn't even write any shadow registers until the moment the output i=
s
> > enabled.
>=20
> That's being done correctly even now I guess, with the checks for=20
> mp->enabled in wrtie_regs() and set_go_bits().

Yes, for timings. I was thinking more about the other settings done in
dpi.c currently, like dispc_mgr_set_pol_freq(). That writes directly to
registers, so we need runtime_get for that.=20

 Tomi


--=-cyO+YiaZoONE3Oy0ISN3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPqQm7AAoJEPo9qoy8lh71N58QAKtw70MuJJVwKUFJvbHN5eLf
Kdk/RijW/154ibZTyuVsKgle4aHyELi08qwHSz2LyOQ7PeyiKWrlMfwvlzb116p1
YD6cqJCY3LwIpcJrJzp1vfiPQCw6emiijYKQ8JNPYNeFQCmKX97GRXkqouFOuVD8
7jSYsVuo7dgvTOdckh+Kc3yAK6oDEHlzQjEG7bauQQqW42aRJIMRSwQLDkpggAOf
58PUZeYlRlrFUacW8UOi6nntqznlftmF9ZqkSjDdKzsy09Wa/1wJ9SrT66WsNXPS
CNqjWgG/TqQ3w3I8Y3Hr0zZfkF3CaSgZPQwXjGQ1IqXrr8sIv1DNQoomdIxxOrQ1
S/4yt0hdEe0LUO2mn48e9VciABjNjkymqFbNEuTYSNf1cmGHLKU+4o22zqAGMwNO
E4tdFNO8bLx7VM52F1Ck+b9YsV4pSyrMvHeqWN6PJMpWYdrxYe/BfFrfh69M9k6g
O751wfsKXKylGNt8zRuz/tkomrq3UYwxAMfrhDoIYE/zIrSMJbvZFOIEeKGGmu38
Bym1ZBLbT7tTBwRN8ruM5EqauQ4nVYdoYx3I0o/N0GvDzUwKknbwadYdSgwyNAkQ
8zdyUnN9lbK8W7uWD+QK3dnc3aHXxy1MFYUeyIh6/jQOFi7yLoJCbffxWOkDxbgn
gTGvMZ5eRZvgDTIG8wHs
=P+1j
-----END PGP SIGNATURE-----

--=-cyO+YiaZoONE3Oy0ISN3--

