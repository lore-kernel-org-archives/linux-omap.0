From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Problems with 3.4-rc5
Date: Fri, 04 May 2012 16:50:15 +0300
Message-ID: <1336139415.2552.4.camel@deskari>
References: <WC20120502115251.8503FF@terrafix.co.uk>
	 <4FA12775.1090206@ti.com> <WC20120502124638.320406@terrafix.co.uk>
	 <1336033721.14378.2.camel@deskari> <WC20120503084938.900446@terrafix.co.uk>
	 <1336050442.14378.10.camel@deskari>
	 <WC20120504091902.970499@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-ur5MKUFiSp0ZQZj712h7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:48181 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756713Ab2EDNu2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 09:50:28 -0400
Received: by lagy4 with SMTP id y4so2434952lag.8
        for <linux-omap@vger.kernel.org>; Fri, 04 May 2012 06:50:22 -0700 (PDT)
In-Reply-To: <WC20120504091902.970499@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org


--=-ur5MKUFiSp0ZQZj712h7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-05-04 at 10:19 +0100, Joe Woodward wrote:
> -----Original Message-----
>  From: Tomi Valkeinen <tomi.valkeinen@ti.com>
>  To: Joe Woodward <jw@terrafix.co.uk>
>  Cc: Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org
>  Date: Thu, 03 May 2012 16:07:22 +0300
>  Subject: Re: Problems with 3.4-rc5
> =20
> > On Thu, 2012-05-03 at 09:49 +0100, Joe Woodward wrote:
>  >=20
> > > Both patches together results in slightly different behaviour, the
>  > display is still broken-=20
> > > it flickers on and off with occassional underflows before breaking
>  > completely.
>  >=20
> > Beagle works fine for me with omap2plus based config, and I think overo
>  > also although I can't test it now as I broke my micro mmc adapter.
>  >=20
> > Can you send your panel definition? Any other things that could affect
>  > display? Do you have PM enabled? Can you share your kernel config?
>  >=20
> >  Tomi
>  >=20
>=20
> I've gone back to a test setup others can replicate.

Ok, I can replicate it now. It seems to be somehow PM related. I
normally have USB gadget stuff compiled into kernel so that I can boot
via nfsroot with usb. After disabling USB support from the kernel, I can
see synclosts.

I have no idea yet what could be causing this. I've also tried adding
the couple of DSS patches which are in queue for next merge window, that
force OPP100 when DSS is enabled. They don't seem to help.

 Tomi


--=-ur5MKUFiSp0ZQZj712h7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPo96XAAoJEPo9qoy8lh71pwEP/jZRlM1L+vwV81mMo5y2EQPH
N2nlp/lLHh4ge6hHsvNRCJP47Z3K2qHVSBv0b4K6qVmYAMsDEUzTXEfcg817gThS
OBlfhVk+s9jnDPptKhymRhV2dpNtW7LW2wNonmESY1vi7t9A8aiBZD7h+65TYxGJ
tI3db4YYAm3OBKNlo2pyP34S1bV9KPI1TEfshDbF1y/DFrkzHDa/W2P1yiIQ0kBO
YFXOp8+p32z3xoINvLJrEKV5ZACAk37AXptPrV02aUE2uXAoQ3diNH3vFe5AA/F2
aC9Gj0CUs8fEZF8c0UEO9Sv1z9HZ9oSAjXCAGJg/LeTTyNI+Gmz1Y9vlb7MCGvEy
iu2b7Mv9E63jb7glUBfjgHVuYXlGKmZtijpB36RZ8T8M0lspswnCmATdT05SWgnR
rSjBcWW/lIdt9QzbBf5hv7V0ipJxztjYjwFA4YX2Ywevl21cKPrKAisocjPic2Ha
6dsRxTeTMnt6FJj7mJNlMOkyYpgx+I4E8TXI/bzVGE3fvVPRk0claAX+Bz0WHpIO
ZVfijLG6y6Du1PvlhoRnXNOV9McY33SFdjjHquQHCbB1rDBZuGhleen4GiYTs6Et
+xpK+/5FYT7XB+iEmxlgqHe8AWqckV8di5g54A6wVR6I6pDn0y4nksUq5PGLoNaw
98qRAozBT159MP1l0wOb
=gPQ2
-----END PGP SIGNATURE-----

--=-ur5MKUFiSp0ZQZj712h7--

