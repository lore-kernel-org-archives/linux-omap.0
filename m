From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/22] ARM: dts: Remove '0x's from OMAP2420 H4 DTS file
Date: Wed, 14 Aug 2013 00:30:01 -0700
Message-ID: <20130814073000.GW7656@atomide.com>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-12-git-send-email-lee.jones@linaro.org>
 <20130813154425.GH15278@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60703 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757923Ab3HNHaE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Aug 2013 03:30:04 -0400
Content-Disposition: inline
In-Reply-To: <20130813154425.GH15278@lee--X1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de, linus.walleij@stericsson.com, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org

* Lee Jones <lee.jones@linaro.org> [130813 08:51]:
> Tony, Benoit,
>=20
> Poke

Looks like Benoit's new email address is bcousson@baylibre.com.
Probably best for Benoit to pick these to avoid merge conflicts.

Regards,

Tony
=20
> On Mon, 22 Jul 2013, Lee Jones wrote:
>=20
> > Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: linux-omap@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/arm/boot/dts/omap2420-h4.dts | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/arch/arm/boot/dts/omap2420-h4.dts b/arch/arm/boot/dts/=
omap2420-h4.dts
> > index 224c08f..34cdecb 100644
> > --- a/arch/arm/boot/dts/omap2420-h4.dts
> > +++ b/arch/arm/boot/dts/omap2420-h4.dts
> > @@ -50,15 +50,15 @@
> >  			label =3D "bootloader";
> >  			reg =3D <0 0x20000>;
> >  		};
> > -		partition@0x20000 {
> > +		partition@20000 {
> >  			label =3D "params";
> >  			reg =3D <0x20000 0x20000>;
> >  		};
> > -		partition@0x40000 {
> > +		partition@40000 {
> >  			label =3D "kernel";
> >  			reg =3D <0x40000 0x200000>;
> >  		};
> > -		partition@0x240000 {
> > +		partition@240000 {
> >  			label =3D "file-system";
> >  			reg =3D <0x240000 0x3dc0000>;
> >  		};
>=20
> --=20
> Lee Jones
> Linaro ST-Ericsson Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
