From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH 6/7] omap4: Workaround for CMD line reset.
Date: Wed, 15 Sep 2010 14:30:23 -0500
Message-ID: <C697598BA21C473088EC09E944FAFD03@am.dhcp.ti.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com><1284031395-25988-2-git-send-email-santosh.shilimkar@ti.com><1284031395-25988-3-git-send-email-santosh.shilimkar@ti.com><1284031395-25988-4-git-send-email-santosh.shilimkar@ti.com><1284031395-25988-5-git-send-email-santosh.shilimkar@ti.com><1284031395-25988-6-git-send-email-santosh.shilimkar@ti.com><1284031395-25988-7-git-send-email-santosh.shilimkar@ti.com> <AANLkTimd5pAFPfGfODXA1FrC4TEoAy9fGgdVibHpB-vH@mail.gmail.com> <4A2EB6064EC0403DB3ADE4A8F347F65C@am.dhcp.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F798@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55866 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285Ab0IOTa1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 15:30:27 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F798@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "'Shilimkar, Santosh'" <santosh.shilimkar@ti.com>, 'kishore kadiyala' <kishorek.kadiyala@gmail.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@deeprootsystems.com



> -----Original Message-----
> From: Shilimkar, Santosh [mailto:santosh.shilimkar@ti.com]
> Sent: Tuesday, September 14, 2010 11:49 AM
> To: Chikkature Rajashekar, Madhusudhan; 'kishore kadiyala'
> Cc: linux-omap@vger.kernel.org; tony@atomide.com;
> khilman@deeprootsystems.com
> Subject: RE: [PATCH 6/7] omap4: Workaround for CMD line reset.
>=20
> Madhu,
> > -----Original Message-----
> > From: Chikkature Rajashekar, Madhusudhan
> > Sent: Tuesday, September 14, 2010 9:28 PM
> > To: 'kishore kadiyala'; Shilimkar, Santosh
> > Cc: linux-omap@vger.kernel.org; tony@atomide.com;
> > khilman@deeprootsystems.com
> > Subject: RE: [PATCH 6/7] omap4: Workaround for CMD line reset.
> >
> >
> >
> > > -----Original Message-----
> > > From: kishore kadiyala [mailto:kishorek.kadiyala@gmail.com]
> > > Sent: Tuesday, September 14, 2010 10:47 AM
> > > To: Madhusudhan Chikkature; Santosh Shilimkar
> > > Cc: linux-omap@vger.kernel.org; tony@atomide.com;
> > > khilman@deeprootsystems.com
> > > Subject: Re: [PATCH 6/7] omap4: Workaround for CMD line reset.
> > >
> > > Hi Madhu,
> > >
> > > On Thu, Sep 9, 2010 at 4:53 PM, Santosh Shilimkar
> > > <santosh.shilimkar@ti.com> wrote:
> > > > From: Madhusudhan Chikkature <madhu.cr@ti.com>
> > > >
> > > > Add a delay after CMD line reset to accomdate the reset to comp=
lete.
> > > > The SYSCTL seems to reflect SRC immediately which might not rea=
lly
> > > > be indicating the complete of reset. This is observed only with
> ES2.0
> > > > silicon
> > > >
> > > > Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
> > > > ---
> > > > =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A08 ++++++++
> > > > =A01 files changed, 8 insertions(+), 0 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/host/omap_hsmmc.c
> > > b/drivers/mmc/host/omap_hsmmc.c
> > > > index 4a8776f..1c359f0 100644
> > > > --- a/drivers/mmc/host/omap_hsmmc.c
> > > > +++ b/drivers/mmc/host/omap_hsmmc.c
> > > > @@ -986,6 +986,14 @@ static inline void
> > > omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host *host,
> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(i++ < limit))
> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
> > > >
> > > > + =A0 =A0 =A0 /*
> > > > + =A0 =A0 =A0 =A0* On OMAP4 ES2 the SRC is zero in the first lo=
op itself
> > > strangely
> > > > + =A0 =A0 =A0 =A0* vs on ES1 it takes some time.
> > > > + =A0 =A0 =A0 =A0* Could be a an issue on ES2 to indicate reset=
 complete
> even
> > > before
> > > > + =A0 =A0 =A0 =A0* it is complete.
> > > > + =A0 =A0 =A0 =A0*/
> > > > + =A0 =A0 =A0 udelay(500);
> > >
> > > Since the above work around is applicable only for OMAP4 ES2 ,
> > > shouldn't this udelay be avoided for other OMAP versions
> > >
> > I did not post this to Linux omap at all. What patch are you talkin=
g
> > about?
> >
> I have posted this patch on Tony and Kevin's request keeping the orig=
inal
> author. This is needed to get MMC working on ES2.0 samples.
>=20
> Do you have fresh version of this patch?
>=20
Yes. There is a TRM update lately that explains the procedure for CMD l=
ine
reset changes in ES2. I will post that patch.

Regards,
Madhu

> Regards,
> Santosh

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
