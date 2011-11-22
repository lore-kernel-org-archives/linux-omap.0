From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 2/2] OMAPDSS: HDMI: Disable DDC internal pull up
Date: Tue, 22 Nov 2011 15:19:28 +0200
Message-ID: <1321967968.1887.70.camel@deskari>
References: <1321365035-9224-1-git-send-email-mythripk@ti.com>
	 <1321601445.1814.24.camel@deskari>
	 <CAP5A+B8Cv=knJwzRvGg4D2t3g=-bykam9iksHh9UXH4pmCB96Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-W750spDsX3GR8apvbbyG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:36286 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752755Ab1KVNTh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 08:19:37 -0500
Received: by mail-bw0-f47.google.com with SMTP id zs2so204845bkb.20
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 05:19:31 -0800 (PST)
In-Reply-To: <CAP5A+B8Cv=knJwzRvGg4D2t3g=-bykam9iksHh9UXH4pmCB96Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>


--=-W750spDsX3GR8apvbbyG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-11-22 at 18:37 +0530, K, Mythri P wrote:
> >> +     if (cpu_is_omap446x() || (omap_rev() > OMAP4430_REV_ES2_2))
> >
> > If you compare omap_rev() you should also use cpu_is_omap at the
> same
> > time. In this case (cpu_is_omap443x() && omap_rev() >
> > OMAP4430_REV_ES2_2). Otherwise the omap_rev check could match, say,
> > omap3 or omap5 boards.
> Hmmm I am not really sure if that is needed, I dont think omap3 or
> omap5 boards would be named with rev "OMAP4430"_REV_ES2_2 ???=20

OMAP4430_REV_ES2_2 is just a symbolic name for a define for some number.
There's no reason why OMAP3430_REV_ES1_0 wouldn't be defined to the same
number.

That said, looking at arch/arm/plat-omap/include/plat/cpu.h shows that
the REV defines do include an OMAP class number, and so omap_rev() does
return a number with cpu ID. So it seems you indeed do not need
cpu_is_omap443x() there.

 Tomi


--=-W750spDsX3GR8apvbbyG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOy6FgAAoJEPo9qoy8lh71+cEQAI1vth8PN646pe/LL8yJPQ0J
O4xZtL1w2WFulcrb4gQF5vQkrdX1Ry66B9MQGzqg60EZwHtSsyC9qbdAF43LFdhi
6lTzv8C//m23pUxKHl3kqGWqCFPUWtrUBj2JeXJr3YoHAwupZ2k/7DNv+fsyKXj/
Slah3EzBwlRKxwndbHMyU/07svG9NkK7OMgc8StYLFcFEJAAM9pLL+FTtiNkk7Uc
jlspu7Tf4c4wt71UZb8hkuRykZx4c1J63fOH51UDtK5GouAfLKnQ2KDEGdqJr7vI
NLDrBrYJ2tjn5m/odfnWYDx/xnORbdTNebolFHmwEdBcTRBL/0g7UBKpk47vujx7
b/QotQDU3Ry9KXcF71Fg/cuRWA0SZqnMeUP+7jC2BAsSPcf2Pntqu6zvCQHiWyaR
zzdTljX+qkAxUB/RhB4i3TiS605ylKUy0iY7pbIHwGlmyKCkFNqh5TI7G+as7BLl
nIuVlMf/Lf55T6qXerhPNgHSgnP/Hhb9q7YgvIsZ2TVHIH23o/nniW3SeAyFIZUK
2pWXQ6WH6+IxpzCF7XvRcDs6pl+8CsN5cDs5aTk3iFyvNT21FE4V1pAPj9uVEJob
MS0Bp8MJjtMf8JN7GtdtjW/FvhlapFw/FpaWO1Yyw29sZrsMZKbvqv90nb/RoERv
pfHKaBpnz8TWq6CzE8cR
=94Fd
-----END PGP SIGNATURE-----

--=-W750spDsX3GR8apvbbyG--

