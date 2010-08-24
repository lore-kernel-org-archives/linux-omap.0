From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH 4/13] dmtimer: hwmod: OMAP: api to read omap_hwmod _clk
Date: Tue, 24 Aug 2010 16:49:29 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032419CAC1@dbde02.ent.ti.com>
References: <1281800283-15185-1-git-send-email-tarun.kanti@ti.com>
 <AANLkTinQAmx8vv6fwEZOaCRTHCRDFsYjUb362fyJScK1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49607 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351Ab0HXLTp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Aug 2010 07:19:45 -0400
In-Reply-To: <AANLkTinQAmx8vv6fwEZOaCRTHCRDFsYjUb362fyJScK1@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Gopinath, Thara" <thara@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

> -----Original Message-----
> From: Grazvydas Ignotas [mailto:notasas@gmail.com]
> Sent: Tuesday, August 24, 2010 4:45 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Basak, Partha; Shilimkar, Santosh;
> Gopinath, Thara; Paul Walmsley; Kevin Hilman; Tony Lindgren
> Subject: Re: [PATCH 4/13] dmtimer: hwmod: OMAP: api to read omap_hwmo=
d
> _clk
>=20
> On Sat, Aug 14, 2010 at 6:38 PM, Tarun Kanti DebBarma
> <tarun.kanti@ti.com> wrote:
> > This patch adds the omap_hwmod_get_clk() to access the _clk
> > field needed while setting clock sources of the timers.
> >
> > Signed-off-by: Partha Basak <p-basak2@ti.com>
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > ---
> > =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 2=
1
> +++++++++++++++++++++
> > =A0arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A01 +
> > =A02 files changed, 22 insertions(+), 0 deletions(-)
> > =A0mode change 100644 =3D> 100755 arch/arm/mach-omap2/omap_hwmod.c
> > =A0mode change 100644 =3D> 100755 arch/arm/plat-
> omap/include/plat/omap_hwmod.h
>=20
> watch out for the mode changes..
Sure, I have taken serious note of this. Thanks.
-tarun
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
