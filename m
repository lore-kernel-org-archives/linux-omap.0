From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv11 2/8] ARM: OMAP2+: hwmod: Add API to check IO PAD
 wakeup status
Date: Tue, 13 Dec 2011 14:48:51 -0800
Message-ID: <20111213224851.GX32251@atomide.com>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com>
 <1323713733-13115-3-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1112131505000.12046@utopia.booyaka.com>
 <20111213222804.GV32251@atomide.com>
 <alpine.DEB.2.00.1112131530100.12046@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61612 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751593Ab1LMWsz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Dec 2011 17:48:55 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1112131530100.12046@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "R, Govindraj" <govindraj.raja@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [111213 14:06]:
> On Tue, 13 Dec 2011, Tony Lindgren wrote:
>=20
> > * Paul Walmsley <paul@pwsan.com> [111213 13:44]:
> > >=20
> > > On Mon, 12 Dec 2011, Tero Kristo wrote:
> > >=20
> > > So the patch description says:
> > >=20
> > > > From: R, Govindraj <govindraj.raja@ti.com>
> > > >=20
> > > > Add API to determine IO-PAD wakeup event status for a given
> > > > hwmod dynamic_mux pad.
> > >=20
> > > But the code does:
> > >=20
> > > > +	for (i =3D 0; i < hmux->nr_pads; i++) {
> > > > +		struct omap_device_pad *pad =3D &hmux->pads[i];
> > >=20
> > > which is going to check all of the pads, not just the dynamic one=
s.
> > >=20
> > > So it seems to me that we need to decide whether this code should=
 be=20
> > > testing all the pads, or just the dynamically remuxed ones.  The =
same=20
> > > thing should be decided for the code in patch 1.
> > >=20
> > > Na=C3=AFvely it seems to me that we want to test all of the pads =
in both=20
> > > patches 1 and 2, not just the dynamically remuxable ones.  Commen=
ts?
> >=20
> > You're right, it should be only the dynamic ones.
>=20
> Hmm, looks to me like it should check all of them?  Can't a pad be ma=
rked=20
> with OMAP_DEVICE_PAD_WAKEUP, but not be marked with OMAP_DEVICE_PAD_R=
EMUX? =20
> In that case it would not end up on the dynamic list, right?

Hmm yes that's even more true :) Maybe the right approach would be to
copy the OMAP_DEVICE_PAD_WAKEUP pins also to the dynamic list to
avoid going through all of them.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
