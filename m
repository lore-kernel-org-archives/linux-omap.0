From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Mon, 23 Jan 2012 10:53:10 +0200
Message-ID: <1327308790.1916.30.camel@deskari>
References: <1327055619.1921.57.camel@deskari>
	 <CAAL8m4zYQmKAnzjfP2eQUyO3hJ3pig2H_jenC_WAWAogQ1JTbw@mail.gmail.com>
	 <1327060886.1921.63.camel@deskari>
	 <CAORVsuVenz_fUPp3o_x+xrN3JJXDUyreMNvqjCPGzLrQf71EnQ@mail.gmail.com>
	 <1327063256.1921.68.camel@deskari>
	 <CAORVsuVGT1AaMzo0r6T4vWe7zz7Uk=o-DydAcGdMzE+utDoUww@mail.gmail.com>
	 <1327071609.1921.82.camel@deskari> <20120122221132.32bd4d44@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-TmlVfcF72v4/rSPw8fxe"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:57249 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752384Ab2AWIxO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jan 2012 03:53:14 -0500
Received: by mail-lpp01m010-f44.google.com with SMTP id j5so1690506lag.31
        for <linux-omap@vger.kernel.org>; Mon, 23 Jan 2012 00:53:13 -0800 (PST)
In-Reply-To: <20120122221132.32bd4d44@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Govindraj <govindraj.ti@gmail.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, Joe Woodward <jw@terrafix.co.uk>


--=-TmlVfcF72v4/rSPw8fxe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2012-01-22 at 22:11 +1100, NeilBrown wrote:

> This code disables the auto-idling of some clocks ... not entirely sure o=
f
> the details.
>=20
> So it seems that it isn't a low power state but rather some clock being
> allowed to turn off which is the problem.
>=20
> I guess I could selective try denying idle on each clock domain until I f=
ind
> the one that is the problem..

I also did some testing: Normally DISPC's SIDLEMODE is set to smart idle
and MIDLEMODE to smart standby. Changing either of them to no idle or no
standby (respectively) removes the sync lost problem. But I guess that
doesn't tell much, except that the problem is some kind of idle/wakeup
problem.

Then I noticed that the DISPC's ENWAKEUP is not set. Setting ENWAKEUP
(with SIDLEMODE/IDLEMODE in smart mode) also removes the problem.

Again, my understanding of OMAP PM is rather limited, but could this be
the problem? Something (core/L3/whatever) goes to idle mode and when DSS
needs to fetch data or requires a clock, and DSS is not able to wake the
other component up?

 Tomi


--=-TmlVfcF72v4/rSPw8fxe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPHR/2AAoJEPo9qoy8lh71D0cQAJiA2KjEr6C1J7cQsXPBZzh9
vW4eylb1rbJLWikwH/YC7O44jH/DZZKkfhh4ATi34I3zvcirA7tXYbunf0UrAtzs
0+IKA7Q7hYxGG/rYDvDSfIe1xkzkxYG2KAOofT51NZxR4rP1XZLGjdwgqOcHOOKb
/Xxf8Fpivlyxy07tTpSEOGgskEaJOabhFrcrTxicQLveUhRKwfLEkdotWNl0vHXE
k12tB6rI9mKWd+IaR2iklZ9Xnvkok+rc/OBDYnONSM5qSBnn7BpNWPQW34g+ckgO
rGHapu67C7alKfX+eK5XEr6QGELET5atNsn56m/UwH8FxHx3UYdUecL3qwT/CwRX
9TXyekeVhZNGNzXUArI/N8XFlGNL4IdQZJxGTZg3BwzRT17xNPwYVIfN3uPzGPTV
f68Mta4dwT1dguk255t5Uhi7x5WHPOF88GzUk4HXCKr2OI/Yo7qnmoMMurkwxGZ4
U6F/p3lQsws+DSCEoAo3wNpjSzfJOEZmkbPyCVP7VdTUi0Xk4HTxBfYCZ0YZ74tB
Caz7mdiEPLQZpRcjHR3ZnhD0ZMSaBKOQFHw/82fnJ/ffIIWYvaxKEUiNSTcwxWTW
lXaETTzy0GBlroT2WOMDZ/407zqkCAy4ioQmjm++iYJIWC2b5uTAXFDDjnVS3ien
yzEzQ+7GOSzEzLjh1PmC
=mumf
-----END PGP SIGNATURE-----

--=-TmlVfcF72v4/rSPw8fxe--

