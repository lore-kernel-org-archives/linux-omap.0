From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 14/14] ARM: OMAP4: hwmod data: Clean up the data file
Date: Fri, 7 Jun 2013 09:50:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306070949300.32163@utopia.booyaka.com>
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com>  <1369845494-30231-15-git-send-email-santosh.shilimkar@ti.com>  <alpine.DEB.2.02.1306061754560.5152@utopia.booyaka.com>  <51B0D54A.1090107@ti.com> <51B175E4.1060909@ti.com>
 <alpine.DEB.2.02.1306070751210.32163@utopia.booyaka.com>  <51B1A150.9020307@ti.com> <1370598383.25965.73.camel@sokoban>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1336670744-1370598640=:32163"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:44737 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462Ab3FGJul (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 05:50:41 -0400
In-Reply-To: <1370598383.25965.73.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Ambresh K <ambresh@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1336670744-1370598640=:32163
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 7 Jun 2013, Tero Kristo wrote:

> On Fri, 2013-06-07 at 14:31 +0530, Sricharan R wrote:
> > On Friday 07 June 2013 01:22 PM, Paul Walmsley wrote:
> > > cc Beno=C3=AEt
> > >
> > > On Fri, 7 Jun 2013, Sricharan R wrote:
> > >
> > >> I used autogen to remove the data, but some of the data were not in =
sync
> > >> with the mainline .(like abe, dss, aess, context register offsets et=
c..).
> > >> So i have to sync them manually.
> > > OK.  Are you going to fix the differences up soon?
> > >
> > > - Paul
> > + Ambresh and Tero for autogen.
>=20
> This is not going to happen soon, if ever. We might consider doing this
> if a complete overhaul for the hwmod data is going to be done at some
> point so that re-generating the new format is easier.

OK.  Sricharan, how about reposting the OMAP4 hwmod data patch and drop=20
the comment regarding autogeneration?  That will be more accurate and will=
=20
save some more lines.


- Paul
--843723315-1336670744-1370598640=:32163--
