From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: MMC: recover from transfer failures
Date: Mon, 2 Feb 2009 11:05:06 -0800
Message-ID: <20090202190503.GT7215@atomide.com>
References: <20081207213617.10456.43951.stgit@localhost> <4965C120.3010705@nokia.com> <200901081249.20152.jpihet@mvista.com> <200902020946.16508.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55690 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbZBBTFd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2009 14:05:33 -0500
Content-Disposition: inline
In-Reply-To: <200902020946.16508.jpihet@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>
Cc: Adrian Hunter <ext-adrian.hunter@nokia.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, "Jarkko Lavinen (NMP/Helsinki)" <jarkko.lavinen@nokia.com>

Hi,

* Jean Pihet <jpihet@mvista.com> [090202 00:46]:
> Tony,
>=20
> Has this patch been applied to the linux-omap tree? Does it need to g=
o the=20
> patchwork?
>=20
> Cf. http://marc.info/?l=3Dlinux-omap&m=3D123141577308177&w=3D2

I'm not applying MMC patches, we need to move that discussion to LKML
and keep Pierre involved.

Jarkko Lavinen was planning to set up a git branch against the mainline
tree for the omap mmc patches, so until we have that, let's just let th=
e
patches float on the list for a while.

But yeah, if you want patchwork to pick up your patch so it does not
get lost, just please resend it to the linux-omap list and it should
get automatically picked up by patchwork.

Regards,

Tony

> Regards,
> Jean
>=20
> On Thursday 08 January 2009 12:49:19 Jean Pihet wrote:
> > Thanks for the suggestion, it works great (stress tested) and is a =
cleaner
> > fix.
> > Here is a patch the latest linux-omap-2.6 tree. Is this OK?
> >
> > Regards,
> > Jean
> >
> > From d143f6b2e705aa4e9d2b032097fd1c82f8163262 Mon Sep 17 00:00:00 2=
001
> > From: Jean Pihet <jpihet@mvista.com>
> > Date: Thu, 8 Jan 2009 12:35:21 +0100
> > Subject: [PATCH] OMAP: MMC: recover from transfer failures
> >
> > Timeouts during a command that has a data phase can result in the
> > next command issued after the command that failed not being process=
ed,
> > i.e. no interrupt ever occurs to indicate the command has completed=
=2E
> > This failure can result in a deadlock.
> >
> > This patch resets the data state machine to clear the error in
> > case of a command timeout.
> >
> > Tested on OMAP3430 chip and intensive MMC/SD device removal while
> > transferring data.
> >
> > Signed-off-by: Andy Lowe <alowe@mvista.com>
> > Signed-off-by: Jean Pihet <jpihet@mvista.com>
> > Signed-off-by: Adrian Hunter <ext-adrian.hunter@nokia.com>
> > ---
> >  drivers/mmc/host/omap_hsmmc.c |    9 ++++++++-
> >  1 files changed, 8 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_=
hsmmc.c
> > index d5c1e9d..97150c0 100644
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > @@ -464,8 +464,15 @@ static irqreturn_t mmc_omap_irq(int irq, void =
*dev_id)
> >                                 }
> >                                 end_cmd =3D 1;
> >                         }
> > -                       if (host->data)
> > +                       if (host->data) {
> >                                 mmc_dma_cleanup(host);
> > +                               OMAP_HSMMC_WRITE(host->base, SYSCTL=
,
> > +                                       OMAP_HSMMC_READ(host->base,
> > +                                                       SYSCTL) | S=
RD);
> > +                               while (OMAP_HSMMC_READ(host->base,
> > +                                               SYSCTL) & SRD)
> > +                                       ;
> > +                       }
> >                 }
> >                 if ((status & DATA_TIMEOUT) ||
> >                         (status & DATA_CRC)) {
> > --
> > 1.5.4.4.21.gc4a6c
> >
> > On Thursday 08 January 2009 10:02:24 Adrian Hunter wrote:
> > > Why not do the reset in mmc_omap_irq() like the other resets?
> > > e.g.
> > >
> > > static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
> > > ...
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if ((status & CMD=
_TIMEOUT) ||
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0(status & CMD_CRC)) {
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0if (host->cmd) {
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (status & CMD_TIMEOUT) {
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0OMAP_HSMMC_WRITE(=
host->base,
> > > SYSCTL, OMAP_HSMMC_READ(host->base, SYSCTL) | SRC); while
> > > (OMAP_HSMMC_READ(host->base, SYSCTL) & SRC) ;
> > >
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0host->cmd->error =
=3D -ETIMEDOUT;
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else {
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0host->cmd->error =
=3D -EILSEQ;
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0end_cmd =3D 1;
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0}
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0if (host->data)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0if (host->data) {
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mmc_dma_cleanup(host);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0OMAP_HSMMC_WRITE(host->base, SYSCTL,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0OMAP_HSMMC_READ(host=
->base,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0SYSCTL) | SRD);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0while (OMAP_HSMMC_READ(host->base,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0SYSCTL) & SRD)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0}
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if ((status & DAT=
A_TIMEOUT) ||
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0(status & DATA_CRC)) {
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
