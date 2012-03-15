From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/6] ARM: OMAP: fix missing __devexit_p() annotations
Date: Thu, 15 Mar 2012 09:59:33 -0700
Message-ID: <20120315165932.GY12083@atomide.com>
References: <20120315102845.GB16389@n2100.arm.linux.org.uk>
 <E1S87wp-0000Mz-V8@rmk-PC.arm.linux.org.uk>
 <CAORVsuUVC4hpotK=eybA=Eqtfg0+PivjwRUENjCwcLG2dp1Ucg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:45138 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161076Ab2COQ7h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 12:59:37 -0400
Content-Disposition: inline
In-Reply-To: <CAORVsuUVC4hpotK=eybA=Eqtfg0+PivjwRUENjCwcLG2dp1Ucg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Jean Pihet <jean.pihet@newoldbits.com> [120315 04:09]:
> Russell,
>=20
> On Thu, Mar 15, 2012 at 11:30 AM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > Missing __devexit_p() annotations in driver structures for remove f=
unctions
> > marked with __devexit is waiting for build errors to happen, such a=
s:
> >
> > `omap_system_dma_remove' referenced in section `.data' of arch/arm/=
plat-omap/bui
> > lt-in.o: defined in discarded section `.devexit.text' of arch/arm/p=
lat-omap/buil
> > t-in.o
> >
> > Add the necessary annotation, and as a result of audit, fix others =
which
> > are also missing in arch/arm/*omap*.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > ---
> > =C2=A0arch/arm/mach-omap2/smartreflex.c | =C2=A0 =C2=A02 +-
> > =C2=A0arch/arm/plat-omap/dma.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 =C2=A02 +-
> > =C2=A02 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap=
2/smartreflex.c
> > index 7e755bb..47c77a1 100644
> > --- a/arch/arm/mach-omap2/smartreflex.c
> > +++ b/arch/arm/mach-omap2/smartreflex.c
> > @@ -1012,7 +1012,7 @@ static int __devexit omap_sr_remove(struct pl=
atform_device *pdev)
> > =C2=A0}
> >
> > =C2=A0static struct platform_driver smartreflex_driver =3D {
> > - =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D omap=
_sr_remove,
> > + =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D __de=
vexit_p(omap_sr_remove),
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.driver =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D =
{
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0=
 =3D "smartreflex",
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> Tony already has this change in his master branch, commit
> 149f1d5c8d2fd6879cdf93ca70f1cb745e698a1e ('ARM: OMAP2+: Fix devexit
> for smartreflex when CONFIG_HOTPLUG is not set').

Also same commit in arm-soc/for-next.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
