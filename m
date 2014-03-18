From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: twl-core: Fix accessibility of some twl4030 audio
 registers
Date: Tue, 18 Mar 2014 20:19:47 +0000
Message-ID: <20140318201947.GT25478@lee--X1>
References: <20140310191250.34f1410e@tomas.local.tbs-biometrics.cz>
 <531EC981.8090806@ti.com>
 <20140318172650.GA307@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:54556 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933063AbaCRUTx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2014 16:19:53 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi5so4217166wib.11
        for <linux-omap@vger.kernel.org>; Tue, 18 Mar 2014 13:19:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140318172650.GA307@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomas Novotny <tomas@novotny.cz>, linux-omap@vger.kernel.org

> > > There are some unused registers in twl4030 at I2C address 0x49 an=
d function
> > > twl4030_49_nop_reg() is used to check accessibility of that regis=
ters. These
> > > registers are written in decimal format but the values are correc=
t in
> > > hexadecimal format. (It can be checked few lines above the patche=
d code -
> > > these registers are marked as unused there.)
> > >=20
> > > As a consequence three registers of audio submodule are treated a=
s
> > > inaccessible (preamplifier carkit right and both handsfree regist=
ers).
> > >=20
> > > CC: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > Signed-off-by: Tomas Novotny <tomas@novotny.cz>
> > > ---
> > >  drivers/mfd/twl-core.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> > > index ed71832..e87140b 100644
> > > --- a/drivers/mfd/twl-core.c
> > > +++ b/drivers/mfd/twl-core.c
> > > @@ -282,11 +282,11 @@ static struct reg_default twl4030_49_defaul=
ts[] =3D {
> > >  static bool twl4030_49_nop_reg(struct device *dev, unsigned int =
reg)
> > >  {
> > >  	switch (reg) {
> > > -	case 0:
> > > -	case 3:
> > > -	case 40:
> > > -	case 41:
> > > -	case 42:
> > > +	case 0x00:
> > > +	case 0x03:
> > > +	case 0x40:
> > > +	case 0x41:
> > > +	case 0x42:
> >=20
> > Uhm, I can not be that @#$%^& that I did this... I have no idea how=
 I left out
> > the "0x"
> >=20
> > Thanks for spotting it!
> >=20
> > Acked-by Peter Ujfalusi <peter.ujfalusi@ti.com>
>=20
> Peter, if this does not make it to the -rc series, care to send this =
to
> the stable for inclusion after it hits mainline?
>=20
> This fixes twl4030 audio regression at least on boards using Handsfre=
eL
> for audio.

I think it's a little late in the cycle to send this to the -rcs.

Stable will be Cc'ed however.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
