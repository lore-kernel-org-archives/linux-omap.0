From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Thu, 12 Jan 2012 11:28:10 +0200
Message-ID: <1326360490.2065.10.camel@deskari>
References: <WC20120109124643.880164@terrafix.co.uk>
	 <20120110080849.5a242adf@notabene.brown>
	 <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
	 <4F0D9B15.4070803@ti.com>  <WC20120111151532.4602C0@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-PTgxx5KKF+3pF6XVpARP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:53176 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752859Ab2ALJ2R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jan 2012 04:28:17 -0500
Received: by lahs8 with SMTP id s8so755034lah.38
        for <linux-omap@vger.kernel.org>; Thu, 12 Jan 2012 01:28:14 -0800 (PST)
In-Reply-To: <WC20120111151532.4602C0@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com
Cc: Archit <a0393947@ti.com>, Paul Walmsley <paul@pwsan.com>, NeilBrown <neilb@suse.de>, linux-omap@vger.kernel.org


--=-PTgxx5KKF+3pF6XVpARP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2012-01-11 at 15:15 +0000, Joe Woodward wrote:

> > The pm_runtime_get_sync() call in dss_runtime_get() is returning  a=20
> > negative value, could you print out that value too?
> >=20
> > If the call to pm_runtime_get_sync() fails, we bail out immediately. So
> > the LCD interface shouldn't have been enabled at all. I don't know why=
=20
> > we get sync lost errors.
> >=20
> > There is a possibility that the LCD interface wasn't switched off when=
=20
> > for some reason when we suspended, and switching on the clocks again=
=20
> > tries to start the transfer without DSS being configured correctly?

I can reproduce this on my Overo. The problem goes away if I change
dss's and dispc'c pm_runtime_put() calls to pm_runtime_put_sync(). But
I'm not quite sure why.

I would imagine that the pm framework would flush the async
pm_runtime_put calls before the system goes into suspend. Comparing the
logs of successful and non-successful suspends it seems that the order
of suspend and resume events changes. Perhaps the suspend goes fine, but
for whatever reason the resume calls happen in a different order,
causing the problems. I need to study this more to understand the
problem.

Kevin, can you confirm that just using pm_runtime_put() is enough even
in system suspend case, and the framework handles doing the runtime_put
before suspending?

 Tomi


--=-PTgxx5KKF+3pF6XVpARP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPDqeqAAoJEPo9qoy8lh71j88P/iWivDpXxERF7M7gQ19fGXfU
3XSZXsH571Sm26uLV3B2je99m2OiDmj+GH13vBUTK3UUnOoLixyB5Iy+ST6IzBEr
9pBVWpdE9zgRJCffgstYYVjdXhkhDitTLfEUn4zmxB3WX6qx37XgJDOM4JaUXpSA
Izt76yxcvpuOkTipcV7bxKsNznWPvtSNQ4ymQJ+k2t42SgdZyhfnDnNxeCTgLDnP
J82wvY6+A4yRuRGvGZhiBlx1vgL6eeW/DPG0QqNyUmnQMsVZ/FkksDW7uDN8y4uS
qqzRyW+ykCaxisu3xjk5S7MNIagbpwUy4hWyINaPWKmobhDhCTtCHRUcigf6PPT6
HJaeI7gv/dS6UPZVVQ1sFbi/8GvJYxxGL/e4a4jmX4lwqDirdLLXkZwEZRbNw0Up
2+aAPTn6leJ1ovTecimCNYjmqVlRv+MaKPn+6gbn0Rl77FEUpDO9TkEwKthqD/ok
8Z4Oq0OH6qS5/siZQhLb9WoPFuxDBPEMtnDSMrSxbM/OPhkewcAd4U0MdON88wBH
jsIzI9G+gQ1I7zlYhhogXEEUanm+tE3xFrTmgvjO/emRI4Rx5hH2DYPjW0YIEJJ/
qevtuKCKIpV5hsyMDEzjZQARNrqsH1HYrnaHK5Db7ElzFuM/prpDrgiaHHaVurik
KPhO/bG/p4Dcs6VpY7Uk
=5PBG
-----END PGP SIGNATURE-----

--=-PTgxx5KKF+3pF6XVpARP--

