From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/21] OMAPDSS: DISPC changes for writeback pipeline
Date: Fri, 14 Sep 2012 11:27:43 +0300
Message-ID: <1347611263.2559.44.camel@deskari>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-GXE1kr1MhAey7Y/cKhBo"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:51832 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758200Ab2INI1s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Sep 2012 04:27:48 -0400
Received: by lbbgj3 with SMTP id gj3so2576836lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Sep 2012 01:27:46 -0700 (PDT)
In-Reply-To: <1347538505-25359-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-GXE1kr1MhAey7Y/cKhBo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-09-13 at 17:44 +0530, Archit Taneja wrote:
> DSS HW on OMAP4 onwards supports a new pipeline called writeback. Unlike =
other
> pipelines(called overlays in OMAPDSS), writeback takes pixel data from an
> overlay output or a overlay manager output and writes it back into a spec=
ified
> address in memory.
>=20
> writeback pipeline allows us to take benefit of the hardware processing
> available inside the DISPC like color space conversion, rescaling, compos=
iting
> etc and do either a) perform memory-to-memory transfer with data processi=
ng,
> b) capture a displayed frame. The former is known as memory to memory mod=
e of
> the writeback pipeline, and the latter is known as capture mode. More det=
ails
> about writeback can be found in the Display Subsystem section of the OMAP=
4/5 TRMs.
>=20
> witeback has properties of both overlays and overlay managers. It is like=
 an
> overlay as it has programmable base addresses and contains blocks like sc=
alar,

You consistently use the term "scalar" in the patches, but I believe the
correct term is "scaler".

> color conversion unit, truncation unit, DISPC DMA FIFO. It is like a mana=
ger as
> enabling it immediately starts transfer to the memory, and it has a GO bi=
t to use
> a new writeback configuration.
>=20
> This series prepares the low level DISPC driver(dispc.c) to configure wri=
teback
> registers. The aim is to reuse most of the code as most of its registers =
are
> like overlay or manager registers, and are configured in the same way in =
most
> cases. The first few patches rename dispc_ovl_* functions to dispc_plane_=
*

I'm not sure if the renaming causes more confusion than clarity... It
kinda creates a mishmash of ovl/plane names, and the term "plane"
doesn't really sound like it's a base for both overlays and wb. Could we
consider the wb as a special case, and keep the ovl name for most of the
things and have "wb" used for wb specific things?

> functions. The next few patches change how overlay caps are used within t=
he
> dispc functions, this helps reusing more functions between overlays and

I dislike this a bit, I think dispc driver should know what HW it has,
you shouldn't need to pass caps to it. So I'd prefer the dispc driver to
to have this information in dispc_features. I believe all OVL_CAPS
should be there, and then exported to other drivers via some means. I
guess this means could for now be just initializing ovl->caps with data
from dispc.c.

 Tomi


--=-GXE1kr1MhAey7Y/cKhBo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQUup/AAoJEPo9qoy8lh71Pi8P/39FOBwXSRyPEgaOujbcZ1nl
ZRf2eqe2VvmDCR+iAe5WVS1AEb8fzK1Y5ej4MHiYKQb7bnD6y3KhFBOIHueqet1n
X01V1rMIa1UFN1SKS+BzCUzOtYw1yemOhh65/0ueZsjizeLKDdgkYrWkc4eiSG/Y
MuiJjRy9qKW9HBQUH8oTfh2EznSOX9rGwMiXHKI4wUNuof580EvsxVgWukbZgat8
Q3gRnD2Xd78GRTny/o5UdyrNjHfOvptMhDyuqNRaIFLaz0Gvs6mGVYLyMkQLzP/L
HJ7OE14t1HCDsMSFwUa8PBuRY1SOTp012P9jwchxBA9WI0KMcVehS4w60oSK2U8c
k3HSs4IMHt7GG7f2+gi1WAkdJ5wsdnKJrLkdGH8MZQzZtDedBk5+kPNZvv3QRBGU
uhDNqfNn/cr/T+n479obCjMi2HyKRpW37sITAmzaK2YLwXdpXTdWJvPR6kmA92h8
/zkrEy+pUmdKJL06If25HAG+Y/36YZROp0zSRjW6Xhhc7R6c/HZxldh5om6SWQY5
NjERMIDVCMorKHpF2baCkrUcS5q9tYw/zNzHyWgCt757ZQH3jDf9OpJs81MTKDMm
LgG8vV/HxbLwqkYKdGQ/S/5DaWczj/+bRctHug04SG0T23xgEpp+p70SgGMp31Ua
H9xKgC/+g3QzbXe+qN/o
=akSR
-----END PGP SIGNATURE-----

--=-GXE1kr1MhAey7Y/cKhBo--

