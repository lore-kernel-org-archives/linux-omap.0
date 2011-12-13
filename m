From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv11 2/8] ARM: OMAP2+: hwmod: Add API to check IO PAD
 wakeup status
Date: Tue, 13 Dec 2011 14:28:04 -0800
Message-ID: <20111213222804.GV32251@atomide.com>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com>
 <1323713733-13115-3-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1112131505000.12046@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38578 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab1LMW2M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Dec 2011 17:28:12 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1112131505000.12046@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "R, Govindraj" <govindraj.raja@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [111213 13:44]:
> Hi
>=20
> a question
>=20
> On Mon, 12 Dec 2011, Tero Kristo wrote:
>=20
> So the patch description says:
>=20
> > From: R, Govindraj <govindraj.raja@ti.com>
> >=20
> > Add API to determine IO-PAD wakeup event status for a given
> > hwmod dynamic_mux pad.
>=20
> But the code does:
>=20
> > +	for (i =3D 0; i < hmux->nr_pads; i++) {
> > +		struct omap_device_pad *pad =3D &hmux->pads[i];
>=20
> which is going to check all of the pads, not just the dynamic ones.
>=20
> So it seems to me that we need to decide whether this code should be=20
> testing all the pads, or just the dynamically remuxed ones.  The same=
=20
> thing should be decided for the code in patch 1.
>=20
> Na=C3=AFvely it seems to me that we want to test all of the pads in b=
oth=20
> patches 1 and 2, not just the dynamically remuxable ones.  Comments?

You're right, it should be only the dynamic ones.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
