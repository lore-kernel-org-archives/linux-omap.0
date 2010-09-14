From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 6/7] omap4: Workaround for CMD line reset.
Date: Tue, 14 Sep 2010 22:18:55 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F798@dbde02.ent.ti.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com><1284031395-25988-2-git-send-email-santosh.shilimkar@ti.com><1284031395-25988-3-git-send-email-santosh.shilimkar@ti.com><1284031395-25988-4-git-send-email-santosh.shilimkar@ti.com><1284031395-25988-5-git-send-email-santosh.shilimkar@ti.com><1284031395-25988-6-git-send-email-santosh.shilimkar@ti.com><1284031395-25988-7-git-send-email-santosh.shilimkar@ti.com>
 <AANLkTimd5pAFPfGfODXA1FrC4TEoAy9fGgdVibHpB-vH@mail.gmail.com>
 <4A2EB6064EC0403DB3ADE4A8F347F65C@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51950 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509Ab0INQtD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 12:49:03 -0400
In-Reply-To: <4A2EB6064EC0403DB3ADE4A8F347F65C@am.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, 'kishore kadiyala' <kishorek.kadiyala@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Madhu,
> -----Original Message-----
> From: Chikkature Rajashekar, Madhusudhan
> Sent: Tuesday, September 14, 2010 9:28 PM
> To: 'kishore kadiyala'; Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; tony@atomide.com;
> khilman@deeprootsystems.com
> Subject: RE: [PATCH 6/7] omap4: Workaround for CMD line reset.
>=20
>=20
>=20
> > -----Original Message-----
> > From: kishore kadiyala [mailto:kishorek.kadiyala@gmail.com]
> > Sent: Tuesday, September 14, 2010 10:47 AM
> > To: Madhusudhan Chikkature; Santosh Shilimkar
> > Cc: linux-omap@vger.kernel.org; tony@atomide.com;
> > khilman@deeprootsystems.com
> > Subject: Re: [PATCH 6/7] omap4: Workaround for CMD line reset.
> >
> > Hi Madhu,
> >
> > On Thu, Sep 9, 2010 at 4:53 PM, Santosh Shilimkar
> > <santosh.shilimkar@ti.com> wrote:
> > > From: Madhusudhan Chikkature <madhu.cr@ti.com>
> > >
> > > Add a delay after CMD line reset to accomdate the reset to comple=
te.
> > > The SYSCTL seems to reflect SRC immediately which might not reall=
y
> > > be indicating the complete of reset. This is observed only with E=
S2.0
> > > silicon
> > >
> > > Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
> > > ---
> > > =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A08 ++++++++
> > > =A01 files changed, 8 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/omap_hsmmc.c
> > b/drivers/mmc/host/omap_hsmmc.c
> > > index 4a8776f..1c359f0 100644
> > > --- a/drivers/mmc/host/omap_hsmmc.c
> > > +++ b/drivers/mmc/host/omap_hsmmc.c
> > > @@ -986,6 +986,14 @@ static inline void
> > omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host *host,
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(i++ < limit))
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
> > >
> > > + =A0 =A0 =A0 /*
> > > + =A0 =A0 =A0 =A0* On OMAP4 ES2 the SRC is zero in the first loop=
 itself
> > strangely
> > > + =A0 =A0 =A0 =A0* vs on ES1 it takes some time.
> > > + =A0 =A0 =A0 =A0* Could be a an issue on ES2 to indicate reset c=
omplete even
> > before
> > > + =A0 =A0 =A0 =A0* it is complete.
> > > + =A0 =A0 =A0 =A0*/
> > > + =A0 =A0 =A0 udelay(500);
> >
> > Since the above work around is applicable only for OMAP4 ES2 ,
> > shouldn't this udelay be avoided for other OMAP versions
> >
> I did not post this to Linux omap at all. What patch are you talking
> about?
>=20
I have posted this patch on Tony and Kevin's request keeping the origin=
al
author. This is needed to get MMC working on ES2.0 samples.

Do you have fresh version of this patch?

Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
