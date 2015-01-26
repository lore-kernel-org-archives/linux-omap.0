From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 01/23] ARM: OMAP2+: clock: move clock provider infrastructure
 to clock driver
Date: Mon, 26 Jan 2015 12:38:48 +0200
Message-ID: <54C61938.8000303@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com> <1417103514-17027-2-git-send-email-t-kristo@ti.com> <alpine.DEB.2.02.1501242142181.5450@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="dThQP6IFRFQ5PGTAVCdDVSA9OicpXNn9G"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35842 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755298AbbAZKjQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Jan 2015 05:39:16 -0500
In-Reply-To: <alpine.DEB.2.02.1501242142181.5450@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, nm@ti.com, linux-arm-kernel@lists.infradead.org

--dThQP6IFRFQ5PGTAVCdDVSA9OicpXNn9G
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 24/01/15 23:51, Paul Walmsley wrote:
> + Tomi=20
>=20
> On Thu, 27 Nov 2014, Tero Kristo wrote:
>=20
>> Splits the clock provider init out of the PRM driver and moves it to
>> clock driver. This is needed so that once the PRCM drivers are separat=
ed,
>> they can logically just access the clock driver not needing to go thro=
ugh
>> common PRM code. This would be wrong in the case of control module for=

>> example.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>=20
> This patch moves things in the wrong direction (ie, rather than keeping=
=20
> the PRM register accesses in the PRM code, it moves PRM register access=
es=20
> into the clock code).  But I see that a subsequent patch in this series=
=20
> moves them back.  So this change is temporary and that seems reasonable=
 to=20
> me.
>=20
> However, as long as the clock code wants to do low-level register acces=
ses=20
> to PRM/CM/SCM registers, there needs to be some way to keep register=20
> updates originating from the clock code from racing with register updat=
es=20
> coming from other code (e.g. non-clock-related PRM/CM/SCM accesses). So=
=20
> I've changed this patch to use regmap (as below), and the followup patc=
h=20
> later in the series will be changed too.  Seems to work so far but let'=
s=20
> see how things go with the rest of the series.

I'm not sure if I miss something, but regmap_write does not protect from
problems if there are multiple users for the same registers. You need to
use regmap_update_bits() to get a protected read/write sequence, in
which you can change only the bits that you want to change.

 Tomi



--dThQP6IFRFQ5PGTAVCdDVSA9OicpXNn9G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUxhk4AAoJEPo9qoy8lh71rC0QAJdZk1t1zRPZUiZLfzuEogh3
RQfoKbaEiXd2BDK1pJvBFVUtC5Lby9F4y+/XNpi0BCgQmyWIo5rgoyEikXDl1kC4
gCTAX5vz+l3cyfvaiACpBSg1A8Ii0/16qmu4WYdZVOFWwAxs2/8jkyJRUoOvPY9g
vy7C1tyWRUmJuCQi/doek/J1s6fHf8MTQV7jWyeYqa2NWO4z/bswHf0sUGbDpjX3
RaKsZtGlp3bJoFWkzGuqvs204trGKk3WtiNojhLptHCCU4uMDJo6yxdb6OhO1Fb8
8X0ALDa3abn2a+I4fj02hFD1NM2w5iAn5SJnZuK7h9TjJGL5eBDfB0AboC+1My59
ar/OOscZxoaU6+YCn3vGC3ds7RMf9LQkcLOpKBLYL7ktoxmJQrU26l4rcGcXKiF8
F80211dUKGpSTiJN5aS//ZilxWYKEyKKBXUBJJQID0MR4XNQ0yNstfiS0N84ge6M
HGr7fJYyZu+KmLFhDJQIBCoJ3f47KOIz1CjChoB4kgoLydH0VolkOeuzn2p/A0rq
bjvrYezDFNSMsXb+JEXAGPpfYuNEda6aCcMgpdmukc2fXGhR/AVmqhUVx2U7aLOE
vilcilJaGySOa72tg3BY8vLBIdbQTV7gfwAFdRZTolyE2Vq8OJfALCfxVDPKH6u9
Nx7kWWTveF/eCoJ+qXqn
=22iW
-----END PGP SIGNATURE-----

--dThQP6IFRFQ5PGTAVCdDVSA9OicpXNn9G--
