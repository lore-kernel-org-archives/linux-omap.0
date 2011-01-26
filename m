From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 2/4] OMAP4: hwmod: add entries for DMIC driver
Date: Wed, 26 Jan 2011 10:28:45 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101261028370.16671@utopia.booyaka.com>
References: <1295992862-6154-1-git-send-email-dlambert@ti.com> <1295992862-6154-3-git-send-email-dlambert@ti.com> <alpine.DEB.2.00.1101251654290.16671@utopia.booyaka.com> <AANLkTi=GFtasMK70zOs-m6FTXchNgxv3ryS1g11sL_2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-9490624-1296062925=:16671"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51753 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097Ab1AZR2q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jan 2011 12:28:46 -0500
In-Reply-To: <AANLkTi=GFtasMK70zOs-m6FTXchNgxv3ryS1g11sL_2w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lambert, David" <dlambert@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-9490624-1296062925=:16671
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 26 Jan 2011, Lambert, David wrote:

> On Tue, Jan 25, 2011 at 5:54 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > On Tue, 25 Jan 2011, David Lambert wrote:
> >
> > > From: Benoit Cousson <b-cousson@ti.com>
> > >
> > > Adds HWMOD entries for the OMAP DMIC driver and creates
> > > a platform device. =A0The HWMOD entires define the system
> > > resource requirements for the drvier such as DMA addresses, channels,
> > > and IRQ's. =A0Placing this information in the HWMOD database allows
> > > for more generic drivers to be written and having the specific
> > > implementation details defined in HWMOD.
> > >
> > > Signed-off-by: David Lambert <dlambert@ti.com>
> >
> > This should have Benoit's Signed-off-by: also.
> >
>=20
> OK... Benoit has already agreed to it... will it be sufficient if I just=
=20
> have him ACK the change here on e-mail?

Yes.

- Paul
--155748971-9490624-1296062925=:16671--
