From: Gregoire Gentil <gregoire@gentil.com>
Subject: Re: How to completely switch off LCD backlight
Date: Sun, 06 Feb 2011 10:41:07 -0800
Message-ID: <1297017667.21804.5.camel@gregoire-laptop>
References: <C9741AB5.23E3E%marathon96@gmail.com>
	 <4732E696-B597-4BCE-A0E9-E60E30A7F94D@mac.com>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.polytechnique.org ([129.104.30.34]:54483 "EHLO
	mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303Ab1BFSvV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Feb 2011 13:51:21 -0500
In-Reply-To: <4732E696-B597-4BCE-A0E9-E60E30A7F94D@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Grant Erickson <marathon96@gmail.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

If you are not using it, put .reset_gpio =3D 96 in your board file for =
the
DSS2 structure. Then echo 1/0 > .../fb0/blank will do the trick to turn
on/off your screen,

Gr=C3=A9goire

On Sun, 2011-02-06 at 21:53 +0400, Elvis Dowson wrote:
> Hi Grant,
>                     Thanks for the reply.=20
>=20
> On Feb 6, 2011, at 9:30 PM, Grant Erickson wrote:
> >=20
> > The following script should be instructive:
> >=20
> >    device=3D"/sys/devices/platform/pwm-backlight.0/backlight/pwm-ba=
cklight.0"
>=20
> For me, this is located in /sys/class/backlight/beagleboard
>=20
> and bl_power is located in /sys/class/backlight/beagleboard
>=20
> >    power=3D"${device}/bl_power"
> >    brightness=3D"${device}/brightness"
> >    max=3D"${device}/max_brightness"
> >=20
> >=20
> >    disable_backlight () {
> >        echo 1 > ${power}
> >    }
> >=20
> >    enable_backlight () {
> >        echo 0 > ${power}
> >    }
>=20
> I did try
>=20
> echo 1 > bl_power
>=20
> but there was no effect. GPIO 96 from the OMAP3503 is physically conn=
ected to LCD LED backlight enable, which I think is what would be used =
to turn the backlight on/off.=20
>=20
> Where can I specify the mapping of GPIO 96 to the bl_power file, so t=
hat the LCD backlight can be switched off?
>=20
> Elvis
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
