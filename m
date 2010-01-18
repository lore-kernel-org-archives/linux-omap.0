From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v9 4/4] OMAP: McBSP: Use cache when modifying individual register bits
Date: Mon, 18 Jan 2010 10:05:12 +0200
Message-ID: <201001181005.12307.peter.ujfalusi@nokia.com>
References: <201001141658.32034.jkrzyszt@tis.icnet.pl> <201001151111.28462.peter.ujfalusi@nokia.com> <4B509B1F.2000302@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:50971 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479Ab0ARIG2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 03:06:28 -0500
In-Reply-To: <4B509B1F.2000302@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Janusz,

On Friday 15 January 2010 18:43:11 ext Janusz Krzysztofik wrote:
> >> --- git/arch/arm/plat-omap/mcbsp.c.orig	2010-01-14 00:36:14.000000=
000
> >> +0100 +++ git/arch/arm/plat-omap/mcbsp.c	2010-01-14 02:05:23.00000=
0000
> >> +0100 @@ -114,7 +114,8 @@ static irqreturn_t omap_mcbsp_tx_irq_han
> >>  		dev_err(mcbsp_tx->dev, "TX Frame Sync Error! : 0x%x\n",
> >>  			irqst_spcr2);
> >>  		/* Writing zero to XSYNC_ERR clears the IRQ */
> >> -		MCBSP_WRITE(mcbsp_tx, SPCR2, irqst_spcr2 & ~(XSYNC_ERR));
> >> +		MCBSP_WRITE(mcbsp_tx, SPCR2,
> >> +			    MCBSP_READ_CACHE(mcbsp_tx, SPCR2) & ~(XSYNC_ERR));
> >
> > The reg_cache will never have the XSYNC_ERR, or any other flags set=
,
> > since these flags has never written to the reg_cache.
> > So it is kind of not necessary to clear the flag, which is actually
> > always 0.
>=20
> Agree.
>=20
> > Another thing is that as far as I understand the reason behind of t=
his
> > series is that you have a problem, that you can not trust on the va=
lues
> > that you read from the McBSP registers, if this is true, than the p=
roblem
> > can occur when the above path has been taken:
> >
> > ...
> > 	irqst_spcr2 =3D MCBSP_READ(mcbsp_tx, SPCR2);
> > ...
> > 	if (irqst_spcr2 & XSYNC_ERR) {
> >
> > But since you read from McBSP registers much rarely, than probably =
the
> > corruption is not that visible?
>=20
> Sure no software solution can correct my hardware issue in case of
> register bits manintained by the hardware itself. Well, maybe softwar=
e
> that limits heat dissipation by lowering overal power consumption cou=
ld
> do to some extent ;).
>=20
> What I'm going to address here is only a case when writing back possi=
bly
> corrupted bits can be avoided if correct values are well known and
> can be determined without reading them back from the register itself.

Yeah, this is also my understanding, but I just did not found the right=
 words ;)

>=20
> > Anyway, clearing the status/error flags are not necessary, since th=
e
> > reg_cache will never got these bits set, you could just write back =
the
> > SPCR2/SPCR1 register content from the cache as it is...
> >
> >>  	} else {
> >>  		complete(&mcbsp_tx->tx_irq_completion);
> >>  	}
> >> @@ -134,7 +135,8 @@ static irqreturn_t omap_mcbsp_rx_irq_han
> >>  		dev_err(mcbsp_rx->dev, "RX Frame Sync Error! : 0x%x\n",
> >>  			irqst_spcr1);
> >>  		/* Writing zero to RSYNC_ERR clears the IRQ */
> >> -		MCBSP_WRITE(mcbsp_rx, SPCR1, irqst_spcr1 & ~(RSYNC_ERR));
> >> +		MCBSP_WRITE(mcbsp_rx, SPCR1,
> >> +			    MCBSP_READ_CACHE(mcbsp_rx, SPCR1) & ~(RSYNC_ERR));
> >
> > Same here.
> >
> > ...
> >
> >> @@ -653,7 +657,7 @@ int omap_mcbsp_pollwrite(unsigned int id
> >>  	if (MCBSP_READ(mcbsp, SPCR2) & XSYNC_ERR) {
> >>  		/* clear error */
> >>  		MCBSP_WRITE(mcbsp, SPCR2,
> >> -				MCBSP_READ(mcbsp, SPCR2) & (~XSYNC_ERR));
> >> +				MCBSP_READ_CACHE(mcbsp, SPCR2) & (~XSYNC_ERR));
> >
> > Well, I think here also, the reg_cache does not have the XSYNC_ERR =
set,
> > it is only set in the McBSP register.
> >
> >>  		/* resend */
> >>  		return -1;
> >>  	} else {
> >> @@ -662,10 +666,12 @@ int omap_mcbsp_pollwrite(unsigned int id
> >>  		while (!(MCBSP_READ(mcbsp, SPCR2) & XRDY)) {
> >>  			if (attemps++ > 1000) {
> >>  				MCBSP_WRITE(mcbsp, SPCR2,
> >> -					    MCBSP_READ(mcbsp, SPCR2) & (~XRST));
> >> +						MCBSP_READ_CACHE(mcbsp, SPCR2) &
> >> +						(~XRST));
> >
> > Also here, the XRST will surely not set in the cached SPCR2...
> >
> > This applies fro all other cases regarding to status/error bits in =
McBSP.
>=20
> OK, I can try to identify all those cases.
>=20
> What about introducing this simplification in a separate followup pat=
ch,
> quoting your rationale in its changelog? I can try to prepare one if =
you
> agree.

I think it is OK to have a followup patch addressing these.
Just mention in a comment, that you are writing the cached value back t=
o the=20
register, which does not have these status flags set, thus clearing the=
 reason=20
in McBSP.

Jarkko: What do you think?

Otherwise, I think this set is good to go.

>=20
> Thanks,
> Janusz
>=20

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
