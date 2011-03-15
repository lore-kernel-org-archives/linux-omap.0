From: Paul Walmsley <paul@pwsan.com>
Subject: Re: 2420 sDMA address mapping typo
Date: Tue, 15 Mar 2011 15:21:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1103151520150.4431@utopia.booyaka.com>
References: <E8606C3FD412994585953171ED63A9340217F287D9@dnce01.ent.ti.com> <4D7FCCD7.7050604@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-5917608-1300224076=:4431"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42654 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932335Ab1COVVR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 17:21:17 -0400
In-Reply-To: <4D7FCCD7.7050604@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Fillinger, Michael" <m-fillinger@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "tony@atomide.com" <tony@atomide.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-5917608-1300224076=:4431
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=EEt, Michael,

On Tue, 15 Mar 2011, Cousson, Benoit wrote:

> On 3/15/2011 5:44 PM, Fillinger, Michael wrote:
> > Hi,
> >=20
> > There is a small issue introduced in 2.6.38 on the address space of sDM=
A for
> > OMAP2420, which seems to be a mix of OMAP2&  newer OMAP addresses :
> >=20
> > arch/arm/mach-omap2/omap_hwmod_2420_data.c
> >=20
> > static struct omap_hwmod_addr_space omap2420_dma_system_addrs[] =3D {
> >          {
> >                   .pa_start   =3D 0x48056000,
> >                   .pa_end     =3D 0x4a0560ff,
> >                   .flags      =3D ADDR_TYPE_RT
> >          },
> > };
> >=20
> > pa_end should be 0x480560ff unless I'm mistaken.
>=20
> Good catch, but the size is almost 4k to store all the channels.
>=20
> The quick and dirty patch is:
> -                   .pa_end     =3D 0x4a0560ff,
> +                   .pa_end     =3D 0x48056fff,

Here's a patch to fix this for the -rc series.  Beno=EEt, care to reply wit=
h=20
a Signed-off-by: or Acked-by: ?


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Tue, 15 Mar 2011 14:13:11 -0600
Subject: [PATCH] OMAP2/3: hwmod data: sDMA IP block has incorrect end addre=
ss

Commits 745685df95961ebbf0bcafcf28f31217a75070ae ("OMAP2420: hwmod
data: add system DMA"), 82cbd1aebafd126f40a8ed0725a6feb6ed710576
("OMAP2430: hwmod data: add system DMA"), and
01438ab6a49b63ef02b2eb44b63345a09792f982 ("OMAP3: hwmod data: add
system DMA") all have an incorrect end address for the SDMA IP block.

Thanks to Michael Fillinger <m-fillinger@ti.com> for reporting this.
Thanks to Beno=EEt Cousson <b-cousson@ti.com> for suggesting an appropriate
correction.

Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>
Reported-by: Michael Fillinger <m-fillinger@ti.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_2420_data.c
index f1776d4..1760d11 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -1789,7 +1789,7 @@ static struct omap_hwmod_irq_info omap2420_dma_system=
_irqs[] =3D {
 static struct omap_hwmod_addr_space omap2420_dma_system_addrs[] =3D {
 =09{
 =09=09.pa_start=09=3D 0x48056000,
-=09=09.pa_end=09=09=3D 0x4a0560ff,
+=09=09.pa_end=09=09=3D 0x48056fff,
 =09=09.flags=09=09=3D ADDR_TYPE_RT
 =09},
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_2430_data.c
index 62ff097..4a7ea12 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -1921,7 +1921,7 @@ static struct omap_hwmod_irq_info omap2430_dma_system=
_irqs[] =3D {
 static struct omap_hwmod_addr_space omap2430_dma_system_addrs[] =3D {
 =09{
 =09=09.pa_start=09=3D 0x48056000,
-=09=09.pa_end=09=09=3D 0x4a0560ff,
+=09=09.pa_end=09=09=3D 0x48056fff,
 =09=09.flags=09=09=3D ADDR_TYPE_RT
 =09},
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_3xxx_data.c
index 41e53c2..0da858c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -2396,7 +2396,7 @@ static struct omap_hwmod_irq_info omap3xxx_dma_system=
_irqs[] =3D {
 static struct omap_hwmod_addr_space omap3xxx_dma_system_addrs[] =3D {
 =09{
 =09=09.pa_start=09=3D 0x48056000,
-=09=09.pa_end=09=09=3D 0x4a0560ff,
+=09=09.pa_end=09=09=3D 0x48056fff,
 =09=09.flags=09=09=3D ADDR_TYPE_RT
 =09},
 };
--=20
1.7.2.3

--155748971-5917608-1300224076=:4431--
