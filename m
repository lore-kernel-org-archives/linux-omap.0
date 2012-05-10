From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v3] ARM: OMAP3: gpmc: add BCH ecc api and modes
Date: Thu, 10 May 2012 18:52:18 +0300
Message-ID: <1336665138.2243.1.camel@brekeke>
References: <1335442669-13474-1-git-send-email-ivan.djelic@parrot.com>
	 <20120509002927.GF5088@atomide.com> <20120509081047.GC17333@parrot.com>
	 <20120509153141.GI5088@atomide.com>
	 <1336655257.2625.8.camel@sauron.fi.intel.com>
	 <20120510151725.GA11107@parrot.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-XlZI6Mkrpg3NfJ9gr8GM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:40823 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755160Ab2EJPz4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 11:55:56 -0400
Received: by lahd3 with SMTP id d3so1197482lah.19
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 08:55:54 -0700 (PDT)
In-Reply-To: <20120510151725.GA11107@parrot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivan Djelic <ivan.djelic@parrot.com>
Cc: Tony Lindgren <tony@atomide.com>, "afzal@ti.com" <afzal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>


--=-XlZI6Mkrpg3NfJ9gr8GM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-05-10 at 17:17 +0200, Ivan Djelic wrote:
> But in order to do so, I need the changes that Afzal has submitted
> (in particular [3]). Those changes (and as a consequence, my new patch)
> won't hit 3.5.
>=20
> So, when Afzal's patches are pushed, I'll submit a new, single MTD patch.

But this is not going to happen this merge window as I understood, may
be not even the next one. We need to make UBIFS happy sooner than that,
I think. So may be we go forward with your original patch?

--=20
Best Regards,
Artem Bityutskiy

--=-XlZI6Mkrpg3NfJ9gr8GM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPq+QyAAoJECmIfjd9wqK0Rb4QAKxKZtZoFNYFHuyOgKirFrdL
ReIGlBcdw9pICIbtukO+yQjPpXPlhueAqNfAY5LKVzeEM9DEki1UuNfIg3yHIyLQ
+BLUGIConFn3U9loR4yQdC0gMDl7YoTC25bXOQYUw5Mrl5SqMEPj49heZIjG+rXO
/VUy3h9qOw2HRbmapHlyY0s3rXGxL4YXlongqUMy22ofrLHwFKPJt5MAJ2gTBqDR
Iy3fD14lpZPr6jD3KCrsGuNBKBZq7F1h1dAUqyad4ceLPzSugQM2AtoeTu25P5/s
xkTW2UjOiGSaxGlTRQHGmxjz3H1/9QymDuXPX5WqXejp5GERDmX8568u0SfRwZRn
o2lfiLU9H2nfYe+QD5QUJHZ/6DTubTacmqnp/fCkqLjfoqCIKj4xT6UDRrzQP9Jd
tqET34UjVgSBoFLhHomi3bqqDHJ4ZcRHqKEwGUsXpOMrumHWdETRBh9Fhvkl05Tk
quoLv2TwVsy+ZQ9FsA/AizfCM2Z6j4VwWL3515/fahGgRZ977yOSpTdosnRyS3IP
aHlXrurgym7PwRTJDQwyieVBR7FflSfMoJe8gqpqXaJOT5Ovs4IboUe+A+TmXCCk
PARG/wRY+Pob0WwTsT1LrZF5jYGINfaiRtLMJMuQ+hF35zdzl9PDwgvy9TZv64B5
e/YlBjANwIQkTtQd10/H
=0b+w
-----END PGP SIGNATURE-----

--=-XlZI6Mkrpg3NfJ9gr8GM--

