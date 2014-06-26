From: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>
Subject: Re: [PATCH v1 1/3] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Thu, 26 Jun 2014 12:06:15 -0300
Message-ID: <20140626150615.GA15648@fox>
References: <1403612666-31197-1-git-send-email-pekon@ti.com>
 <1403612666-31197-2-git-send-email-pekon@ti.com>
 <20140626104044.GJ28884@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f45.google.com ([209.85.213.45]:48223 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbaFZPED (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2014 11:04:03 -0400
Received: by mail-yh0-f45.google.com with SMTP id t59so2184899yho.18
        for <linux-omap@vger.kernel.org>; Thu, 26 Jun 2014 08:04:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140626104044.GJ28884@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Pekon Gupta <pekon@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Jason Kridner <jkridner@gmail.com>, Robert Nelson <robertcnelson@gmail.com>

Hi Tony, Pekon

On Thu, Jun 26, 2014 at 03:40:44AM -0700, Tony Lindgren wrote:
> * Pekon Gupta <pekon@ti.com> [140624 05:26]:
> > +
> > +&gpmc {
> > +	ranges =3D <0 0 0 0x01000000>;	/* address range =3D 16MB (minimum=
 GPMC partition) */
> > +	nand@0,0 {
> > +		status =3D "disabled";
> > +		reg =3D <0 0 4>;		/* device IO registers */
>=20
> Hmm so what about other capes potentially also using GPMC CS0?
>=20
> Can you please do a check with two .dtsi files trying to use
> GPMC CS0 and see what the produced .dtb file looks like after
> decompiling it with dtc?
>=20
> I'd assume the 16MB GPMC partition will be just fine for many
> devices and can be also be larger if NOR needs it so maybe it
> can be handled for almost all the cases.
>=20
> The names for devices must be unique though to avoid them
> getting merged. And I don't know if gpmc.c skips disabled devices
> properly.
It doesn't. I've just sent a patch for it.

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/266966.=
html

Regards,
Guido

>=20
> Regards,
>=20
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Guido Mart=EDnez, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
