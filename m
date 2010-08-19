From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 0/5] OMAP: McSPI: Implement McSPI in HWMOD way
Date: Thu, 19 Aug 2010 12:39:27 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6722A10@dbde02.ent.ti.com>
References: <1281708323-18989-1-git-send-email-charu@ti.com>
 <AANLkTikS0tX3GA+1LXnqbZYuuWteOTq7dH13i-icKYD2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43585 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111Ab0HSHJz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 03:09:55 -0400
In-Reply-To: <AANLkTikS0tX3GA+1LXnqbZYuuWteOTq7dH13i-icKYD2@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>, "Nayak, Rajendra" <IMCEAEX-_O=TI_OU=EXCHANGE+20ADMINISTRATIVE+20GROUP+20+28FYDIBOHF23SPDLT+29_CN=RECIPIENTS_CN=X0016154@dlee86.itg.ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>



> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of
> Grant Likely
> Sent: Saturday, August 14, 2010 4:15 AM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; khilman@deeprootsystems.com;
> paul@pwsan.com; Cousson, Benoit; tony@atomide.com;
> dbrownell@users.sourceforge.net; spi-devel-general@lists.sourceforge.=
net;
> Nayak, Rajendra; Basak, Partha; Raja, Govindraj
> Subject: Re: [PATCH 0/5] OMAP: McSPI: Implement McSPI in HWMOD way
>=20
> On Fri, Aug 13, 2010 at 8:05 AM, Charulatha V <charu@ti.com> wrote:
> > This patch series implements McSPI Module in HWMOD FW way
> > and use the runtime PM layer.
>=20
> Hi Charulatha,
>=20
> I'll go through and review the patches, but I'm unfamiliar with HWMOD=
=2E
>  Is there a description of HWMOD that you can point me at?

The following link could be of some help:
http://omappedia.org/wiki/HWMOD#Steps_involved_in_HWMOD

>=20
> Thanks,
> g.
>=20
> >
> > This patch series is created on "origin/pm-wip/hwmods-omap4" with
> > McSPI slave mode patches (url given below) on top of it.
> > https://patchwork.kernel.org/patch/79677/
> > Updated McSPI slave mode patches will be posted shortly by Govindra=
j.
> > McSPI slave mode patches were already discussed on open source mail=
ing
> > list and they are almost towards the end of final rebased version.
> > Hence hwmod patches are created on top of McSPI slave mode patch
> > series to avoid major rework later on.
> >
> > Benoit Cousson (1):
> > =A0OMAP4 HWMOD: Add mcspi hwmods.
> >
> > Charulatha V (3):
> > =A0OMAP2420: McSPI: Add mcspi hwmod
> > =A0OMAP2430 : McSPI: Add mcspi hwmod data
> > =A0OMAP3 HWMOD: Add mcspi hwmods.
> >
> > Govindraj.R (1):
> > =A0OMAP McSPI: Adapt McSPI driver to use omap hwmod
> >
> > =A0arch/arm/mach-omap2/clock3xxx_data.c =A0 =A0 =A0 | =A0 =A04 +
> > =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A023=
3 +++++++++------------
> ---
> > =A0arch/arm/mach-omap2/omap_hwmod_2420_data.c | =A0138 ++++++++++++=
++
> > =A0arch/arm/mach-omap2/omap_hwmod_2430_data.c | =A0196 ++++++++++++=
++++++++
> > =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0252
> +++++++++++++++++++++++++
> > =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0244
> +++++++++++++++++++++++++
> > =A0arch/arm/plat-omap/include/plat/mcspi.h =A0 =A0| =A0 27 +++
> > =A0drivers/spi/omap2_mcspi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
273 +++++++++------------
> -------
> > =A08 files changed, 1034 insertions(+), 333 deletions(-)
> >
> >
>=20
>=20
>=20
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
