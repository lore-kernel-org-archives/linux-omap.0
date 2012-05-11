From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP4: panda: add statics to remove warnings
Date: Fri, 11 May 2012 15:55:09 +0300
Message-ID: <1336740909.8751.80.camel@deskari>
References: <1335166780-5899-1-git-send-email-tomi.valkeinen@ti.com>
	 <20120424171630.GQ3739@atomide.com> <1335356951.2799.5.camel@deskari>
	 <20120504192903.GQ5613@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-gFP3cRLR+aQCO95dsq4w"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:59967 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758964Ab2EKMzQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 May 2012 08:55:16 -0400
Received: by lagv3 with SMTP id v3so591362lag.3
        for <linux-omap@vger.kernel.org>; Fri, 11 May 2012 05:55:12 -0700 (PDT)
In-Reply-To: <20120504192903.GQ5613@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org


--=-gFP3cRLR+aQCO95dsq4w
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-05-04 at 12:29 -0700, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [120425 05:32]:
> > On Tue, 2012-04-24 at 10:16 -0700, Tony Lindgren wrote:
> > > * Tomi Valkeinen <tomi.valkeinen@ti.com> [120423 00:43]:
> > > > Add statics to board-omap4-panda.c's internal functions and data
> > > > structures to remove warnings.
> > >=20
> > > Care to update with the warnings produced?
> >=20
> > Ah, sure. Updated patch below:
> >=20
> > From e96ddeb7d783d48a15a32f8ef5a7bae3089f66b9 Mon Sep 17 00:00:00 2001
> > From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Date: Wed, 28 Mar 2012 11:38:58 +0300
> > Subject: [PATCH] OMAP4: panda: add statics to remove warnings
> >=20
> > Add statics to board-omap4-panda.c's internal functions and data
> > structures to remove sparse warnings:
> >=20
> > arch/arm/mach-omap2/board-omap4panda.c:234:29: warning: symbol
> > 'omap_panda_wlan_data' was not declared. Should it be static?
> > arch/arm/mach-omap2/board-omap4panda.c:441:24: warning: symbol
> > 'omap4_panda_dvi_device' was not declared. Should it be static?
> > arch/arm/mach-omap2/board-omap4panda.c:451:12: warning: symbol
> > 'omap4_panda_dvi_init' was not declared. Should it be static?
> > arch/arm/mach-omap2/board-omap4panda.c:512:13: warning: symbol
> > 'omap4_panda_display_init' was not declared. Should it be static?
>=20
> Thanks adding to fixes-non-critical.

It seems this patch is obsolete, as there's already one in linux-next:

commit 8c3d4534a8da0dc6a2d52b61585e61f7e8143096
Author: Paul Walmsley <paul@pwsan.com>
Date:   Fri Apr 13 06:34:26 2012 -0600

    ARM: OMAP2+: declare file-local functions as static
=20
 Tomi


--=-gFP3cRLR+aQCO95dsq4w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPrQwtAAoJEPo9qoy8lh71KW0QAIYqvm/I+u193qGUde3IihXd
2CLSqndtqhXULOpMpjRq5C6C2pltFHUHjwQXGgHA5lMGGfcsJTrd0D9OjiUvC48k
sSFVFZgsG27+IAx+NSZpIuZYto3hgSfszSxuEIQDQVSryEHR/S+zStdReT+MtpZW
zLIph6cVsjBTRzSEGTzbybzCRaNRPquvpOEgeLZ7JEC9oGlYpOS5w7Yi2pnVOg70
XgMbjF5lAqNh7YMUovwyffCPv9laZ4FGACsFlAPaGr5/eM8MEo3BjKFDwhv6buH2
RtfCaI9F4+qqvV4GXzkJt75EImKuHV1acgUpOnb9kl5wBPrHsILKzGz6b1IMlf4M
yCu3WpBfbEXbjJiRq7UMFqRsaD1Y6ACdJnvpu5itjmPMugtgQFC/QWfr3bogA/ky
dZrncBzZVCDqEHMOjptUZb7TsMfnAKrKIBO5BlLF9bFNTXEpyImL0hdGzIDQ4ZAN
rUPebGyQadIvQK/wh244Jj1qwqTkvAlrgIXFUzYfykxDS4GJqCW6SUOXHaTObb2O
hk3/zR8pWzHhI+GmGOC1KEbQhmE7n7JleFFZWe8/KDgaRRC2IrjilSNG5Txb7w6s
XeYGwypCX4iPfe/v2GDf+9Wo4x6gl2ZlsDMd8ROpNeyBhLd2pjQlGzMLR/Wf81lY
q2oO3mJH+eteLOKJQXrZ
=grkF
-----END PGP SIGNATURE-----

--=-gFP3cRLR+aQCO95dsq4w--

