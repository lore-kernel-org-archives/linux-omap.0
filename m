From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH] arm: omap3: am35x: Set proper powerdomain states
Date: Tue, 15 May 2012 11:35:27 -0700
Message-ID: <20120515183527.GB26651@animalcreek.com>
References: <1335821208-13098-1-git-send-email-mgreer@animalcreek.com>
 <CAORVsuXouGSdZRKW+T8yvc+23KYr-x0u9FeRXxiET+QmanE_EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:46626 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933288Ab2EOSf3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 May 2012 14:35:29 -0400
Content-Disposition: inline
In-Reply-To: <CAORVsuXouGSdZRKW+T8yvc+23KYr-x0u9FeRXxiET+QmanE_EA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, paul@pwsan.com

On Tue, May 15, 2012 at 09:43:52AM +0200, Jean Pihet wrote:
> Hi Mark,

Hi Jean.

> On Mon, Apr 30, 2012 at 11:26 PM, Mark A. Greer <mgreer@animalcreek.c=
om> wrote:
> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> >
> > The am35x family of SoCs only support the PWRSTS_ON
> > state so create a new set of powerdomain structures
> > that ensure that only the ON state is entered.
> >
> > Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> > ---

> > =A0void __init omap3xxx_powerdomains_init(void)
> > =A0{
> > =A0 =A0 =A0 =A0unsigned int rev;
> > @@ -301,21 +403,31 @@ void __init omap3xxx_powerdomains_init(void)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> >
> > =A0 =A0 =A0 =A0pwrdm_register_platform_funcs(&omap3_pwrdm_operation=
s);
> > - =A0 =A0 =A0 pwrdm_register_pwrdms(powerdomains_omap3430_common);
> >
> > =A0 =A0 =A0 =A0rev =3D omap_rev();
> >
> > - =A0 =A0 =A0 if (rev =3D=3D OMAP3430_REV_ES1_0)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_register_pwrdms(powerdomains_om=
ap3430es1);
> > - =A0 =A0 =A0 else if (rev =3D=3D OMAP3430_REV_ES2_0 || rev =3D=3D =
OMAP3430_REV_ES2_1 ||
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev =3D=3D OMAP3430_REV_ES3_0 || r=
ev =3D=3D OMAP3630_REV_ES1_0)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_register_pwrdms(powerdomains_om=
ap3430es2_es3_0);
> > - =A0 =A0 =A0 else if (rev =3D=3D OMAP3430_REV_ES3_1 || rev =3D=3D =
OMAP3430_REV_ES3_1_2 ||
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev =3D=3D AM35XX_REV_ES1_0 || rev=
 =3D=3D AM35XX_REV_ES1_1 ||
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev =3D=3D OMAP3630_REV_ES1_1 || r=
ev =3D=3D OMAP3630_REV_ES1_2)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_register_pwrdms(powerdomains_om=
ap3430es3_1plus);
> > - =A0 =A0 =A0 else
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "OMAP3 powerdomain init: unkn=
own chip type\n");
> > + =A0 =A0 =A0 if (rev =3D=3D AM35XX_REV_ES1_0 || rev =3D=3D AM35XX_=
REV_ES1_1) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_register_pwrdms(powerdomains_am=
35x);
> > + =A0 =A0 =A0 } else {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_register_pwrdms(powerdomains_om=
ap3430_common);
> Is there a way to avoid the big 'if else' here and have the code
> organized per chipset revision? A mutliple if-else or -even better
> IMO- a switch-case would make the code more readable.

We can't avoid it completely because we have to register
powerdomains_am35x[] [exclusive] OR (powerdomains_omap3430_common[] +
extras).  What I can do is leave the outside 'if' and turn the code
inside the 'else' into a switch stmt which should look nicer.

Good idea, thanks. :)

I will submit v2 in a bit.

Mark
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
