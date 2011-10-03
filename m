From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] OMAP2PLUS: DSS: Ensure DSS works correctly if display
 is enabled in bootloader
Date: Mon, 3 Oct 2011 11:21:55 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110031055590.4611@utopia.booyaka.com>
References: <1315811306-11001-1-git-send-email-archit@ti.com>  <alpine.DEB.2.00.1110022237171.4611@utopia.booyaka.com> <1317630070.2026.27.camel@deskari>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-239861043-1317662515=:4611"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33414 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757039Ab1JCRV4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 13:21:56 -0400
In-Reply-To: <1317630070.2026.27.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, santosh.shilimkar@ti.com, r.sricharan@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-239861043-1317662515=:4611
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Tomi,

On Mon, 3 Oct 2011, Tomi Valkeinen wrote:

> On Sun, 2011-10-02 at 22:45 -0600, Paul Walmsley wrote:
> > On Mon, 12 Sep 2011, Archit Taneja wrote:
> >=20
> > > Resetting DISPC when a DISPC output is enabled causes the DSS to go i=
nto an
> > > inconsistent state. Thus if the bootloader has enabled a display, the=
 hwmod code
> > > cannot reset the DISPC module just like that, but the outputs need to=
 be
> > > disabled first.
> > >=20
> > > Add function dispc_disable_outputs() which disables all active overla=
y manager
> > > and ensure all frame transfers are completed.
> > >=20
> > > Modify omap_dss_reset() to call this function and clear DSS_CONTROL,
> > > DSS_SDI_CONTROL and DSS_PLL_CONTROL so that DSS is in a clean state w=
hen the
> > > DSS2 driver starts.
> > >=20
> > > This resolves the hang issue(caused by a L3 error during boot) seen o=
n the
> > > beagle board C3, which has a factory bootloader that enables display.=
 The issue
> > > is resolved with this patch.
>=20
> <snip>
>=20
> > +struct omap_dss_dispc_dev_attr {
> > +=09u8=09manager_count;
> > +=09bool=09has_framedonetv_irq;
> > +};
> > +
> > +#endif
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach=
-omap2/omap_hwmod_2420_data.c
> > index 09d9395..8e32cb3 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> > @@ -945,6 +945,7 @@ static struct omap_hwmod omap2420_dss_dispc_hwmod =
=3D {
> >  =09.slaves_cnt=09=3D ARRAY_SIZE(omap2420_dss_dispc_slaves),
> >  =09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
> >  =09.flags=09=09=3D HWMOD_NO_IDLEST,
> > +=09.dev_attr=09=3D &omap2_3_dss_dispc_dev_attr
> >  };
>=20
> I didn't know you can add arbitrary data like that to hwmods. What kind
> of data is it meant for?=20

It's intended for data that's specific to the integration of that IP block=
=20
on a given SoC.

In an ideal world, Linux could just read some registers from the IP block=
=20
to determine these.  Many of our IP blocks have a REVISION register.  But=
=20
many types of integration-specific data are not identified in that=20
register. And often when IP blocks are revised, the hardware people seem=20
to forget to update the REVISION register :-(.  So we need some way to=20
supply this information in software.

In terms of concrete uses, one use would be to identify IP block=20
features that may be enabled on certain instances of the IP.  For example,=
=20
on OMAPs, some DMTIMER blocks have 1ms tick adjustment support; others do=
=20
not.  As far as I know, there's no way for the driver to determine this=20
from the IP block.

The dev_attr data is intended to be fairly high-level functional data.

> Can the data be used by the driver, or is it meant just for arch stuff?

It can be used by both.  But if it's intended for use by the driver, then=
=20
the dev_attr data needs to be copied into struct platform_data by the=20
arch-specific code.  This is because the drivers themselves should have no=
=20
direct dependencies on hwmod data or code, in case the IP block is used on=
=20
a non-OMAP SoC.

For example, if you look at arch/arm/mach-omap2/hsmmc.c around line 471,=20
you can see the arch-specific code copying dev_attr data into=20
platform_data.

> I'm wondering this as we have a complex mechanism in the dss driver to
> find out about the differences of DSS hardware
> (drivers/video/omap2/dss/dss_features.[ch]). The dss_features system is
> currently part of the driver, but should be moved under arch/arm/*omap*
> at some point, and this hwmod dev_attr sounds like it could possibly be
> a right place to handle these.
>=20
> I looked at how the dev_attrs are used, and all of them seemed to be
> very small, a few fields at max. The DSS features set is, on the other
> hand, quite big amount of data, and meant for the driver.

Just from a brief look, it looks like much of that data would be good=20
candidates to pass via the dev_attr mechanism.  The reg_fields would be one=
=20
exception: it would be better (in terms of dev_attr) to simply pass data=20
like ".reg_field_layout =3D 1" or ".reg_field_layout =3D 2", and then selec=
t=20
between those tables in the driver code.

Beno=EEt is right, though, that you might want to take the upcoming DT=20
migration into account in your plans.


- Paul
--155748971-239861043-1317662515=:4611--
