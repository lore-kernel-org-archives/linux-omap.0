From: Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: N900: Remove mmc1 "safety feature"? (was: Re: mmc0 on Nokia N900
 on Linux 5.4.18)
Date: Sun, 9 Feb 2020 09:11:49 +0100
Message-ID: <14cbf6a2-c438-3f92-08c7-ee0a2784db9f@wizzup.org>
References: <5362c659-120f-5247-aaa5-7916229300bc@wizzup.org>
 <20200208190448.GA12984@amd>
 <270f27c9-afd6-171d-7dce-fe1d71dd8f9a@wizzup.org>
 <1eac0db3-17ce-8ebd-4997-8b1c282126e4@wizzup.org>
 <20200208220621.GA18161@amd>
 <d2d6d6ac-c964-ac48-1616-6f1826219385@wizzup.org>
 <op.0fpbjlbwhxa7s4@supervisor.net28>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FTWHKiY98fexUfkq6wE34RROqeasvi97A"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from a80-127-99-228.adsl.xs4all.nl ([80.127.99.228]:53500 "EHLO
        hetgrotebos.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725900AbgBIIKn (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Sun, 9 Feb 2020 03:10:43 -0500
In-Reply-To: <op.0fpbjlbwhxa7s4@supervisor.net28>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Arthur D." <spinal.by@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FTWHKiY98fexUfkq6wE34RROqeasvi97A
Content-Type: multipart/mixed; boundary="RuoGXgEQ0tgXcepA9j5F8VDneE8Lr1p8X"

--RuoGXgEQ0tgXcepA9j5F8VDneE8Lr1p8X
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,

On 09/02/2020 04:48, Arthur D. wrote:
> I suppose the real life scenario would be:
>=20
> 0. The OS runs on eMMC.
> 1. The user opens his phone back cover and inserts MicroSD card.
> 2. Kernel doesn't try to access the card until the cover is closed.

This kinda makes sense - but assume the card is already in there, and
the user wants to swap them? Then it doesn't help.


> It seems wise to me: we don't want to damage user's data or hardware.
> Accessing data on unstable medium can't be considered safe.
> While the cover is open and user just inserted the microsd card everyth=
ing
> can happen - the phone can be dropped, may be unstable contact to micro=
sd
> while the user interacting it, etc.

Maybe I am just used to the microsd port being exposed, but I have no
other ARM device that doesn't have the microsd slot easily exposed. Many
phones, cables, development boards, and they all just allow me to insert
a microSD card, and it'll work. Clearly the manufacturers didn't have a
similar worry there.

> It seems to be inconvenient for us, while we run OS mostly from microsd=
=2E
> But removing such behaviour from the kernel completely doesn't seem to
> be a good idea generally. Vanilla kernel shouldn't be dedicated for
> debugging purposes or edge cases (like running only from external MMC).=

> Running from embedded MMC should be common for most users in perspectiv=
e.
>=20
> If I remember correctly, if the microsd is already mounted and the back=

> cover is open, nothing bad happens. It continues to work. You can unmou=
nt
> the card and remove it safely. But you are not going to see the new car=
d
> insertion detected until you close the cover.

I think the last paragraph might actually be key, because when you said
that, my initial reaction was: "aha! that makes some sense".

Still not sure if it warrants the hassle it currently is. And as it
stands, we also disable this feature in Maemo Leste, so we clearly
decided we don't want it either. ;-)

> I'm not sure about the last paragraph. Please correct me if I'm wrong a=
bout
> how it actually works.

OK.

If we don't want to remove this, can we at least somehow have a runtime
warning? I spent quite some time searching my dmesg, trying to figure
out why I couldn't even see the mmc interface that I needed.

Cheers,
Merlijn


--RuoGXgEQ0tgXcepA9j5F8VDneE8Lr1p8X--

--FTWHKiY98fexUfkq6wE34RROqeasvi97A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCXj++xQAKCRAGN09rynK8
WsGJAQD1Xg/R/rVJbMv2qfXyBbtyHHhEQ2qXAfRjkVxkqAZtyAD/T4cHhO5TJnxj
IC3Z7TjQylRcSff5VsFLv8i4Zy+YzQs=
=wwxU
-----END PGP SIGNATURE-----

--FTWHKiY98fexUfkq6wE34RROqeasvi97A--
