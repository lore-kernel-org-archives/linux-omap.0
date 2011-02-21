From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] OMAP2+: voltage: reorganize, split code from data
Date: Mon, 21 Feb 2011 11:53:27 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102211034450.22636@utopia.booyaka.com>
References: <20110221020231.7598.14024.stgit@twilight.localdomain> <20110221020856.7598.34506.stgit@twilight.localdomain> <AANLkTikdx41hE5d5xG8rpB95DUvVu0=VHi6Zj=ePtREb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-905897584-1298310144=:22636"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56133 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195Ab1BUSx2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 13:53:28 -0500
In-Reply-To: <AANLkTikdx41hE5d5xG8rpB95DUvVu0=VHi6Zj=ePtREb@mail.gmail.com>
Content-ID: <alpine.DEB.2.00.1102211045140.22636@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gulati, Shweta" <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-905897584-1298310144=:22636
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1102211045141.22636@utopia.booyaka.com>

Hello

On Mon, 21 Feb 2011, Gulati, Shweta wrote:

> On Mon, Feb 21, 2011 at 7:38 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/o=
pp3xxx_data.c
> > index 0486fce..3c7f0c0 100644
> > --- a/arch/arm/mach-omap2/opp3xxx_data.c
> > +++ b/arch/arm/mach-omap2/opp3xxx_data.c

=2E..

> > +/* VDD2 */
> > +struct omap_volt_data omap36xx_vddcore_volt_data[] =3D {
> > + =A0 =A0 =A0 VOLT_DATA_DEFINE(OMAP3630_VDD_CORE_OPP50_UV, OMAP3630_CON=
TROL_FUSE_OPP50_VDD2, 0xf4, 0x0c),
> > + =A0 =A0 =A0 VOLT_DATA_DEFINE(OMAP3630_VDD_CORE_OPP100_UV, OMAP3630_CO=
NTROL_FUSE_OPP100_VDD2, 0xf9, 0x16),
> > + =A0 =A0 =A0 VOLT_DATA_DEFINE(0, 0, 0, 0),
> > +};
> > +
> The definition of "VOLT_DATA_DEFINE" is there in voltage.h
> I think its better to move these Volt_data to voltagedomains files
> rather than in
> OPP layer files

opp*_data.c is currently where process/wafer/die-variable parameters go. =
=20
The struct omap_volt_data also consists mostly[1] of=20
process/wafer/die-variable parameters.  So it made sense to group it=20
there.

In comparison, voltagedomains*_data.c files consist of=20
process/wafer/die-invariant data, such as register layouts, voltage domain=
=20
partitioning, etc.  This is data that we don't expect to ever change over=
=20
the lifetime of a production design.

You are correct in that there seems to be little point leaving the=20
VOLT_DATA_DEFINE macro in voltage.h, so I have moved this to=20
omap_opp_data.h.


- Paul

1. The SCM register offsets in the struct omap_volt_data don't technically=
=20
belong in the process/wafer/die-variable parameters.  It probably would=20
make sense to replace these with SCM OPP IDs, and then to create an=20
interface in the SCM code to fetch the SR data from the SCM, given an OPP=
=20
ID.

--155748971-905897584-1298310144=:22636--
