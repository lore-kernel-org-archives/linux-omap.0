From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 09/13] OMAPDSS: SDI: Create a function to set timings
Date: Tue, 14 Aug 2012 20:33:20 +0300
Message-ID: <1344965600.2345.70.camel@deskari>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
	  <1344512989-4071-1-git-send-email-archit@ti.com>
	  <1344512989-4071-10-git-send-email-archit@ti.com>
	 <1344951845.4845.58.camel@lappyti> <502A8322.6000309@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-JslMYqJWCSwidz20NEbw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:33985 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755233Ab2HNRdZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Aug 2012 13:33:25 -0400
Received: by lbao2 with SMTP id o2so384034lba.24
        for <linux-omap@vger.kernel.org>; Tue, 14 Aug 2012 10:33:22 -0700 (PDT)
In-Reply-To: <502A8322.6000309@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-JslMYqJWCSwidz20NEbw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-08-14 at 22:26 +0530, Archit Taneja wrote:
> On Tuesday 14 August 2012 07:14 PM, Tomi Valkeinen wrote:

> I guess it depends on how drm/fb want to use it. I guess an output=20
> should have a set_timings() kind of op if it can do it seamlessly. I=20
> guess we can do that easily in DPI, for example, we could reduce the fps=
=20
> from 60 to 30 without causing an artefacts(I think). For outputs which=
=20

Yes, that kind of thing is easy to do by just changing the pck divider,
which is in a shadow register. I mean, "easy" in theory, at least. Our
clock calculation doesn't work like that currently, though, so it could
end up changing DSS fck.

> can't do it, we could remove the set_timings totally.

But we do need set_timings for other outputs also (like sdi). We just
can't change them just like that. Only outputs that do not need timings
are DSI command mode and rfbi.

> However, it'll be kind of inconsistent for some outputs to set timings,=
=20
> and for others to not, and if in the future drm/fb gets exposed to ops=
=20
> too, we may have dirty checks to see if set_timings is populated or not.
>=20
> The easiest way would be to make all set_timings just update the copy of=
=20
> the timings output has, and expect drm/fb to disable and re enable the=
=20
> panel. We may end up doing unnecessary gpio resets and configuration of=
=20
> the panels though.

I think changing things like timings is quite a rare operation. The only
case it'd be necessary to change timings often, with speed, and without
artifacts would be the fps drop you mentioned, for lower power use with
panels that don't mind the fps drop.

If I understood correctly, Rob said that drm already disables the output
when changing the mode, when I asked if it's ok for the apply's
set_timings to require the output to be off.

In any case this is not a big issue, I mean, it's not causing any
problems. Somebody is going to disable the output anyway when changing
the timings. Perhaps even these patches are good, because they make the
set_timings consistent across the output drivers (don't they?).

 Tomi


--=-JslMYqJWCSwidz20NEbw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQKovgAAoJEPo9qoy8lh717lMP/A053sRFCptQ+Gi6w3oVy8OJ
fzC8RE5m0XUfNku8XpcVEV93p1lJNvjvEGZcVHQpNd4Oe66gThEy5BGi5+HSB8qK
n+jDMuV09UWTqztCXFty0cd16Qfuuj0C3XlV2pyLfKEQdntu2w4w4GE20qlh1PRR
azfTYRm4H9NQUY8kEXpgywnfd+tsKyUj7N/aXu6v5FkatUK7k1ObWcvEKXqbR0f6
UTf6xPaybPNffnXvhRWr5/2lyJBKWHBuhvdOFH/lfGwfAxwtyxIDyiWG4bmYKhKz
87lqvU2+BhgUzaX6mwxXuDf90d1qzcUMRw9eDXjXi04xqTxrqUUHwkTQFJ34eZls
gpQwj1fhyko9W0dBxObNCRVfPNAZX1QQ+5jGNQK5mWRWJBmVykDAxYIp5LW9c1KR
IStVUKuSJN9Dwq+3lstfc5STAqXBoty4flQcQwjCtzxU7BRm2UWuaFiwKSmV4pbq
4Zp8QVOJA7khsIC+5i8t+p+twKR8fft+4WbHX/d80bOK9Ts4p32l0jtYYH2Qh0s/
IgDEyReZdlNu2rodh6XcI3+T7nbWu//qOxasaBmxKkyWrhyDA+ESvUxfJDUrJKi+
nI5x0v5Ej181EGyle8ehz8K2e9AmBVSawM7QMJNzYJ9blUgmUtC0lfn8PqQAHBpO
Pwj1wmv6aBNoIdqbveN/
=lZ3d
-----END PGP SIGNATURE-----

--=-JslMYqJWCSwidz20NEbw--

