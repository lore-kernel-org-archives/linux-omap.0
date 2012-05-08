From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/25] OMAPDSS: DT preparation patches v2
Date: Tue, 08 May 2012 11:44:28 +0300
Message-ID: <1336466668.5761.12.camel@deskari>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
	 <20120507174657.GF5088@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-5jQRUGVlH4AYBdmVudcJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:47758 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751075Ab2EHIoe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 04:44:34 -0400
Received: by lbbgj10 with SMTP id gj10so4163225lbb.9
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 01:44:31 -0700 (PDT)
In-Reply-To: <20120507174657.GF5088@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com


--=-5jQRUGVlH4AYBdmVudcJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-05-07 at 10:46 -0700, Tony Lindgren wrote:
> Hi,
>=20
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [120503 07:01]:
> > Hi,
> >=20
> > I started cleaning up and restructuring omapdss for device tree, and he=
re's the
> > first set of patches from that ordeal. There's nothing DT specific in t=
hese
> > patches, but they are mostly generic cleanups that make sense even with=
out DT.
> >=20
> > This is the second version of these patches, the previous version can b=
e found
> > from: http://www.spinics.net/lists/linux-fbdev/msg05667.html
> >=20
> > The first 21 patches, which were in the previous version, have only got=
ten
> > minor cleanups (and, of course, more testing). The last 4 patches are n=
ew. The
> > most important of those patches is the DSI pin config patch, which make=
s it
> > possible for the panel driver to configure the DSI pins it needs.
> >=20
> > This series can also be found from:
> > git://gitorious.org/linux-omap-dss2/linux.git work/devtree-base
>=20
> Nice clean up. Can you please put the first 12 arch/arm/*omap*/* touching
> patches (and the drivers/video dependencies needed) into a separate branc=
h
> and send me a pull request. That is assuming those patches are now immuta=
ble.
>=20
> Then I can pull it into cleanup-dss branch that we both can merge as
> needed.

Ok, I'll see how it goes. Do I have your ack for the board file changes?

Do you want to have patches that touch only
arch/arm/mach-omap2/display.c, but not the board files? That's a dss
specific file, and I don't expect anyone else to make changes to it, so
chances for conflicts should be quite minimal.

 Tomi


--=-5jQRUGVlH4AYBdmVudcJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPqNzsAAoJEPo9qoy8lh71GlEQAJXe64e1bqXIepfvO2uQ+krM
sErmflZmlzqtkXpyqt4gXfbpLylHFGAeex3SpTdiWGGTPCqoNZUbg6rdNaJwl6bb
QC1DbiQD0LGTLfWZYyG3C5qcVBiw9dW4zKThmjAuhOh4TKAFkY6MvFQRzlAVUa2m
uLhSRsOUedREeW2NoXJKKI+gkA1DJgsD9G0q5yZd50GsZj2zrTNpVwsQNBowK2+6
ZpA4/8nJ6fOR7cHh02KXK2YlfU7xMiQyUv0/yo7z8cyOznLmOhiluou4X2WyTRyU
OWrfps7WtVhrfKuP2+Im+NQT/q/DZxn5Vqs5m4UEchUxhi4/Znf3fCWi6OE/dKSZ
s20ZhoK6xBXHF5bhe6j7FB2FuxTqi5s/l6WZ5e6ve6ZCNjQKtM1KkF+uJa5RCQbA
KUqZV468EhTufe0Q9mvjz3yhi9B4LTD1ZPQk8RKBCqYOKAGkXvnlE86nJDG0TQia
K3L3LsxG7VeTsif4JxvvZMnX/YPL8PsLFxAKpiwKveIl0mAlCIJqVs90EPFG7MNh
yaPaUpnB7yGs2T/jDtzLG1GsAL1H/4pZTEkb34l+uma7VkE2lskJy7Hy3g09w6sx
K64E9XeW0ZFhU1CEOAJrLcHNIfNj1bsuAF7ql49L3iO/Feg86Mi/Zs2v9zh56my2
YIW5L/CtWWV0PiIfV+Mi
=MrD7
-----END PGP SIGNATURE-----

--=-5jQRUGVlH4AYBdmVudcJ--

