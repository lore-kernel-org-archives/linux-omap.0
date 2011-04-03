From: Matthias Kaehlcke <matthias@kaehlcke.net>
Subject: Re: [PATCH] OMAP34xx: Add padconfig offsets for GPIOs 126-129
Date: Sun, 3 Apr 2011 13:33:28 +0200
Message-ID: <20110403113328.GC1902@darwin>
References: <4D963442.1020106@tomtom.com>
 <20110403110630.GB2404@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:51587 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab1DCLll convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 3 Apr 2011 07:41:41 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 019BE86598
	for <linux-omap@vger.kernel.org>; Sun,  3 Apr 2011 13:41:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110403110630.GB2404@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Matthias Kaehlcke <matthias.kaehlcke@tomtom.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Hi Felipe,

El Sun, Apr 03, 2011 at 02:06:31PM +0300 Felipe Balbi ha dit:

> On Fri, Apr 01, 2011 at 10:23:30PM +0200, Matthias Kaehlcke wrote:
> > Add OMAP3_CONTROL_PADCONF_GPIOxxx_OFFSET constants for GPIOs 126-12=
9
> >=20
> > Signed-off-by: Matthias Kaehlcke <matthias@tomtom.com>
> > ---
> >  arch/arm/mach-omap2/mux34xx.h |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-omap2/mux34xx.h b/arch/arm/mach-omap2/mu=
x34xx.h
> > index 6543ebf..70d2b8d 100644
> > --- a/arch/arm/mach-omap2/mux34xx.h
> > +++ b/arch/arm/mach-omap2/mux34xx.h
> > @@ -393,6 +393,10 @@
> >  #define OMAP3_CONTROL_PADCONF_SAD2D_SWAKEUP_OFFSET		0xa1c
> >  #define OMAP3_CONTROL_PADCONF_JTAG_RTCK_OFFSET			0xa1e
> >  #define OMAP3_CONTROL_PADCONF_JTAG_TDO_OFFSET			0xa20
> > +#define OMAP3_CONTROL_PADCONF_GPIO127_OFFSET			0xa24
> > +#define OMAP3_CONTROL_PADCONF_GPIO126_OFFSET			0xa26
> > +#define OMAP3_CONTROL_PADCONF_GPIO128_OFFSET			0xa28
> > +#define OMAP3_CONTROL_PADCONF_GPIO129_OFFSET			0xa2a
>=20
> no users for these ?

we use these on a custom board whose board specific code won't be
mainlined. i think it still makes sense to have the constants in
mainline for the sake of completeness

kind regards

--=20
Matthias Kaehlcke
Embedded Linux Developer
Amsterdam

     La libertad es como la ma=F1ana. Hay quienes esperan dormidos a qu=
e
   llegue, pero hay quienes desvelan y caminan la noche para alcanzarla
                        (Subcomandante Marcos)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
