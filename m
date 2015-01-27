From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 01/23] ARM: OMAP2+: clock: move clock provider infrastructure
 to clock driver
Date: Tue, 27 Jan 2015 13:34:38 +0200
Message-ID: <54C777CE.1070900@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com> <1417103514-17027-2-git-send-email-t-kristo@ti.com> <alpine.DEB.2.02.1501242142181.5450@utopia.booyaka.com> <54C61938.8000303@ti.com> <20150126154936.GC28663@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="T5vhoWAe2CUA3QtPv3ugfSlsfD5SeGqmX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57992 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758028AbbA0LfG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Jan 2015 06:35:06 -0500
In-Reply-To: <20150126154936.GC28663@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, nm@ti.com, linux-arm-kernel@lists.infradead.org

--T5vhoWAe2CUA3QtPv3ugfSlsfD5SeGqmX
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 26/01/15 17:49, Tony Lindgren wrote:

>> I'm not sure if I miss something, but regmap_write does not protect fr=
om
>> problems if there are multiple users for the same registers. You need =
to
>> use regmap_update_bits() to get a protected read/write sequence, in
>> which you can change only the bits that you want to change.
>=20
> To me it seems that issue can be fixed by making all the code use regma=
p.
> AFAIK that should work for the legacy code too.

Even if everybody uses regmap, doing

v =3D regmap_read()
modify v
regmap_write(v)

is racy. regmap_update_bits() has to be used to protect the read/write
sequence. Which may be somewhat challenging at times with some strange
registers, the like Roger Q encountered recently related to CAN.

 Tomi



--T5vhoWAe2CUA3QtPv3ugfSlsfD5SeGqmX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUx3fOAAoJEPo9qoy8lh71PNEP/jV8+G/+xtiDXJkHQFxCoteY
wbIdi3EzkbVWfJEoQlZ3JD+jmU9JuCBXHLNqBJoRMam/8FxXhX832DCe300i7J7h
7QnhdRluY89ZhY3oHcTpdiwA6Rlrwk/pdYF/MWFekR8luFO1kP+T3YUtv+IIwuB+
F6oGWhQ37XEBu7QnxSlcNrqGEAn/DQ9bHX7T4D4i6omVYS4Vnrt/HMvwt/zwkxyL
xbKCi5Llm0my5h6lTsaQ+2ROVtJ0SJ8dkmamNJIKtzeyiB1qPEQQNMLWangWQXN4
iRzUQTYq6QqBXWUPBje26fyn1Lh6R3sZdemzrJXVdsBqj/c+Rqof4c22ITR4DlB5
FpCh5pQdGlFU/E3Vfadq3uTjFcrPgMEcBgsA0jBUCHnk9yKi+TU7QctLBZS7b1mz
eap2W1ObXehnSHgKM3Cd8sTXymC2tf/qCzuAfbY1PClqmCu8/KNFNIfHFVnix/hL
WT+QlFDWsiyG8N+DVtNN+P4NssWcfi+cfbpnLfpVeE+C4nf9KL6ozCQkAzoz9Wkt
2Oizb24dHkkOYiR7EgR30NTuFiBlS5jI44dSdDjPHKGuSd0LCvgHWjhaqxmWxAmE
/GhhkvODTmseEqOfdQ5SfjkTlNcjSoWntZMun77x7uJDkrQBXS8cPppbnB8EKPU8
gdXmHgI5dIH3nxlQX+Tg
=/V/q
-----END PGP SIGNATURE-----

--T5vhoWAe2CUA3QtPv3ugfSlsfD5SeGqmX--
