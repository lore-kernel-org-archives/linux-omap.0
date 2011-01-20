From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: omap-mcbsp: Fix building after replacement
Date: Thu, 20 Jan 2011 10:19:52 -0800
Message-ID: <20110120181952.GY4957@atomide.com>
References: <1295532731-5438-1-git-send-email-weber@corscience.de>
 <AANLkTimd--8qbUd7Dnj5dyGiRAZByp_xBUesXN7SPFDj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29761 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295Ab1ATSUI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jan 2011 13:20:08 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimd--8qbUd7Dnj5dyGiRAZByp_xBUesXN7SPFDj@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Poddar, Sourav" <sourav.poddar@ti.com>
Cc: Thomas Weber <weber@corscience.de>, linux-omap@vger.kernel.org

* Poddar, Sourav <sourav.poddar@ti.com> [110120 07:08]:
> On Thu, Jan 20, 2011 at 7:42 PM, Thomas Weber <weber@corscience.de> w=
rote:
> > Fix building omap-mcbsp after replacing ARCH_OMAP24x0 in
> > commit 8a9c1aa6a4caa7db1c2fca4b47168af9077e0f95.
> >
> >> =C2=A0 omap: Start using CONFIG_SOC_OMAP
> >>
> >> =C2=A0 =C2=A0We want to have just CONFIG_ARCH_OMAP2, 3 and 4. The =
rest
> >> =C2=A0 =C2=A0are nowadays just subcategories of these.
> >>
> >> =C2=A0 =C2=A0Search and replace the following:
> >>
> >> =C2=A0 =C2=A0ARCH_OMAP2420 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 SOC_OMAP2420
> >> =C2=A0 =C2=A0ARCH_OMAP2430 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 SOC_OMAP2430
> >> =C2=A0 =C2=A0ARCH_OMAP3430 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 SOC_OMAP3430
> >
>=20
> I was just about to post a patch for this, but you beat me
> to it!
>=20
> > Signed-off-by: Thomas Weber <weber@corscience.de>
>=20
> Acked-by: Sourav Poddar <sourav.poddar@ti.com>

Thanks, merging this into the original. Also adding
applying into linux-omap master.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
