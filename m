From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/6] ARM: OMAP2+: Remove board-4430sdp.c
Date: Mon, 22 Jul 2013 12:40:13 +0300
Message-ID: <51ECFDFD.60102@ti.com>
References: <20130517191304.468.73487.stgit@localhost> <20130517191751.468.89202.stgit@localhost> <20130520095447.GR21614@n2100.arm.linux.org.uk> <20130706131057.GU21614@n2100.arm.linux.org.uk> <20130706133627.GV21614@n2100.arm.linux.org.uk> <20130708093410.GT5523@atomide.com> <20130708142103.GX21614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2MHJIHSHKEUDJUBKDKOLW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34876 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757005Ab3GVJkv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jul 2013 05:40:51 -0400
In-Reply-To: <20130708142103.GX21614@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

------enig2MHJIHSHKEUDJUBKDKOLW
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/07/13 17:21, Russell King - ARM Linux wrote:

> Also looks like the nonfunctional video stuff is even more nonfunctiona=
l
> than usual:
>=20
> omapdss DSI error: can't get VDDS_DSI regulator
> omapdss HDMI error: can't get VDDA_HDMI_DAC regulator

Those should be followed by "...requests probe deferral", and the driver
is probed again later.

The log
http://www.arm.linux.org.uk/developer/build/result.php?type=3Dboot&idx=3D=
946
shows "taal display2: panel revision e3.83.7d" which hints that the
panel (and DSS) was initialized properly.

Those error prints should probably be tuned down a bit now that the
driver uses probe deferral.

 Tomi



------enig2MHJIHSHKEUDJUBKDKOLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR7P4BAAoJEPo9qoy8lh71BicP/1SPBpi8+4NNb1LpwX+AUTGf
dGCRCpHxkagc7wf3a19umf4irpb1yANZbzeKBiJTC8mDAAVLZmfTAFw5fUlw8A2l
3j/2i1jpNT6SJy8DYOfAuDndxsUiD5hCsaTWjc0dqinNlyi7lf7V/TKGRJOikopK
s2SbLAs/3E5vngf1NVhiefSu7Cftsv97uFH5WU4QbFzigqH9HjHy8xN0zAJ+cT6g
mikA0RtaW5ZhBBTo2I9+egXnXsx/ZBLJ3Axg4zpe3hhgm75QTBpsRW2VZKIRmwlI
d7CxxkdTsucQfVLuqwrZjvvMuzjq8mVWAoJkMMu5olHCJ8N4+lXVooddl7lwEEjS
87plOXTaPvuMfB79trO0U/7iLctfMSz7rWmlI4GottkfyCHN4TNOM41eG6T9MTvq
B8rSCyPmoH3qekp6A4QyyaWuQmGBaqO75pp9lkV2Ots6mq9s/YIwFRwTSdSCHLfa
IbEQb3hGhq2pwnWyrTgH/8kqcQp5pD0BBOQeYt3PlpDy+VEsRsE/JC+f2M7FMoH4
IWVV33E3xlFInijT3qkm5tshHyCNxFmPBQ+F4ZI7y8CBpVRt3mf3jGFEMxexl9Ss
IinR9pve+OQVTnQChU52rJAF5scLT6EgD6ThGrsvXQv0XkFSc8360kRZEJqM95JF
Q3C4yal4yoXuE9d6Kyvv
=xkkb
-----END PGP SIGNATURE-----

------enig2MHJIHSHKEUDJUBKDKOLW--
