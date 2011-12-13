From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv11 2/8] ARM: OMAP2+: hwmod: Add API to check IO PAD wakeup
 status
Date: Tue, 13 Dec 2011 15:38:17 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112131530100.12046@utopia.booyaka.com>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com> <1323713733-13115-3-git-send-email-t-kristo@ti.com> <alpine.DEB.2.00.1112131505000.12046@utopia.booyaka.com> <20111213222804.GV32251@atomide.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1609260115-1323815897=:12046"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44663 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755363Ab1LMWiV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Dec 2011 17:38:21 -0500
In-Reply-To: <20111213222804.GV32251@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "R, Govindraj" <govindraj.raja@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1609260115-1323815897=:12046
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 13 Dec 2011, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [111213 13:44]:
> >=20
> > On Mon, 12 Dec 2011, Tero Kristo wrote:
> >=20
> > So the patch description says:
> >=20
> > > From: R, Govindraj <govindraj.raja@ti.com>
> > >=20
> > > Add API to determine IO-PAD wakeup event status for a given
> > > hwmod dynamic_mux pad.
> >=20
> > But the code does:
> >=20
> > > +=09for (i =3D 0; i < hmux->nr_pads; i++) {
> > > +=09=09struct omap_device_pad *pad =3D &hmux->pads[i];
> >=20
> > which is going to check all of the pads, not just the dynamic ones.
> >=20
> > So it seems to me that we need to decide whether this code should be=20
> > testing all the pads, or just the dynamically remuxed ones.  The same=
=20
> > thing should be decided for the code in patch 1.
> >=20
> > Na=C3=AFvely it seems to me that we want to test all of the pads in bot=
h=20
> > patches 1 and 2, not just the dynamically remuxable ones.  Comments?
>=20
> You're right, it should be only the dynamic ones.

Hmm, looks to me like it should check all of them?  Can't a pad be marked=
=20
with OMAP_DEVICE_PAD_WAKEUP, but not be marked with OMAP_DEVICE_PAD_REMUX? =
=20
In that case it would not end up on the dynamic list, right?


- Paul
--155748971-1609260115-1323815897=:12046--
