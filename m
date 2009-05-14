From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 0/2] PM: OMAP3 SDRC: fix some SDRAM settings for Qimonda
 parts
Date: Thu, 14 May 2009 13:30:48 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0905141330190.17514@utopia.booyaka.com>
References: <20090514185012.2152.36226.stgit@localhost.localdomain> <13B9B4C6EF24D648824FF11BE8967162038BE09DCE@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-948682463-1242329448=:17514"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52604 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbZENTas (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 15:30:48 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162038BE09DCE@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-948682463-1242329448=:17514
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 14 May 2009, Woodruff, Richard wrote:

> > Also when reviewing the timing calculations, it appears that the lowest=
 speed
> > setting had an error in its autorefresh counter value.  I don't know if
> > anything out there still uses this low-speed setting - my recollection =
is
> > that it was added for some early Labrador boards that had speed restric=
tions -
> > any comments from TI on whether these 133.3MHz/66.6MHz rates should be =
dropped
> > is most welcome.
>=20
> Alpha LDP board had only 133MHz rated memory on them.  These were quickly=
 replaced with beta then production boards with 166MHz rated memory.
>=20
> Probably only a few dumpsters at TI have 133MHz restricted alpha boards (=
and maybe at logicpd).  I don=E2=80=99t' think you will even find an alpha =
in plastics.
>=20
> Nothing stops a person from running at 133 on the 166 rated parts.  But m=
ost won't choose to on a 3430.

Great, thanks Richard.  Will add a patch to drop those rates...

- Paul
--155748971-948682463-1242329448=:17514--
