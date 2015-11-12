From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/2] arm: beaglex15: fix USB Gadget
Date: Thu, 12 Nov 2015 11:54:34 -0600
Message-ID: <87k2pnqf1h.fsf@saruman.tx.rr.com>
References: <1447350781-20649-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447350781-20649-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Felipe Balbi <balbi@ti.com> writes:
> Hi,
>
> with the following patches I can get USB Gadget working
> with my beagle x15 with today's Linus' tree.
>
> regards
>
> Felipe Balbi (2):
>   arm: boot: dts: beaglex15: Remove ID GPIO
>   arm: boot: beaglex15: pass correct interrupt

actually, one patch missing. Didn't generate it with format-patch. I'll
send as a reply to this thread.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWRNJcAAoJEIaOsuA1yqREyOsQAJc7HwemHOBsfI2VesjmKJGU
UiTpuTwbTZGWX0emvQmGs2zkwEq+EI4IKFGyEjHdlBgMVvKvX1iXcRc3QO7iR/8l
+otTZbsRd0RG9hirN1kkYTHU1G7S6eyYeXkBiq1PZLfV7zu5V9+IRzZYGPx6sTjH
MpU32eqA5EHyhtWHs/N14l8fIE104by8+GeVFUPysvAY8bmFkXzMawua642bvzLz
HqWNmhrquYFHF0LH8mQV/erwXqEls/TcHWD39oRYMiwwIO5fNYTX9gkulYfbgQvD
LBwyBVceOE+e0ktFW4uYe6zwF3Fx3dgbIozaeUwzFcdEQoXZAx+1XNTCfav5Y0jq
LZAuKudgj2hMrPhiZxovVJLxDXSzxZKkcvRNP66/x4y2Y0FEN5PHpAq+olg9VXhD
rHnG//GhT6QDnjQXbL+i4zNh19LVxCqFhCj6mPaht6fcBtL6c4tuDqJ/GIVPyZ4Z
ZdDDcdU5mR3xwE+F5UNq53euyzGp2BuBCVU9eWV+X/0jfTfgYQy7/uTyIRsoTHuq
19IwbGpqYTIFzIgbV4h0Q2gULsCKvSWnuEcfF6Tx4jclqo2LM9TXGdTTkOt3UAww
UAIP0wHHfY5WYul9fIg0/cMgaCJSMamX66NeQYHIivLg8TDDs2U0L1Uh/qER9tzb
Y1a6nwSvJUmWu9Iaf5fK
=Zyri
-----END PGP SIGNATURE-----
--=-=-=--
