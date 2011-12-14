From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv11 2/8] ARM: OMAP2+: hwmod: Add API to check IO PAD
 wakeup status
Date: Wed, 14 Dec 2011 12:17:08 +0200
Message-ID: <1323857828.14920.9.camel@sokoban>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com>
	 <1323713733-13115-3-git-send-email-t-kristo@ti.com>
	 <alpine.DEB.2.00.1112131505000.12046@utopia.booyaka.com>
	 <20111213222804.GV32251@atomide.com>
	 <alpine.DEB.2.00.1112131530100.12046@utopia.booyaka.com>
	 <20111213224851.GX32251@atomide.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47535 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755106Ab1LNKRO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 05:17:14 -0500
In-Reply-To: <20111213224851.GX32251@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, "R, Govindraj" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 2011-12-13 at 14:48 -0800, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [111213 14:06]:
> > On Tue, 13 Dec 2011, Tony Lindgren wrote:
> >=20
> > > * Paul Walmsley <paul@pwsan.com> [111213 13:44]:
> > > >=20
> > > > On Mon, 12 Dec 2011, Tero Kristo wrote:
> > > >=20
> > > > So the patch description says:
> > > >=20
> > > > > From: R, Govindraj <govindraj.raja@ti.com>
> > > > >=20
> > > > > Add API to determine IO-PAD wakeup event status for a given
> > > > > hwmod dynamic_mux pad.
> > > >=20
> > > > But the code does:
> > > >=20
> > > > > +	for (i =3D 0; i < hmux->nr_pads; i++) {
> > > > > +		struct omap_device_pad *pad =3D &hmux->pads[i];
> > > >=20
> > > > which is going to check all of the pads, not just the dynamic o=
nes.
> > > >=20
> > > > So it seems to me that we need to decide whether this code shou=
ld be=20
> > > > testing all the pads, or just the dynamically remuxed ones.  Th=
e same=20
> > > > thing should be decided for the code in patch 1.
> > > >=20
> > > > Na=C3=AFvely it seems to me that we want to test all of the pad=
s in both=20
> > > > patches 1 and 2, not just the dynamically remuxable ones.  Comm=
ents?
> > >=20
> > > You're right, it should be only the dynamic ones.
> >=20
> > Hmm, looks to me like it should check all of them?  Can't a pad be =
marked=20
> > with OMAP_DEVICE_PAD_WAKEUP, but not be marked with OMAP_DEVICE_PAD=
_REMUX? =20
> > In that case it would not end up on the dynamic list, right?
>=20
> Hmm yes that's even more true :) Maybe the right approach would be to
> copy the OMAP_DEVICE_PAD_WAKEUP pins also to the dynamic list to
> avoid going through all of them.

Yea, all pads that have WAKEUP capability should be checked. Not sure i=
f
this comment is valid anymore seeing patch 2 is kind of irrelevant with
patch 8, but the code that scans wakeups should check them all.

-Tero


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
