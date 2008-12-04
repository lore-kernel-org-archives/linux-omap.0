From: David Brownell <david-b@pacbell.net>
Subject: Re: OMAP Zoom kernel ALSA build problem
Date: Thu, 4 Dec 2008 09:40:17 -0800
Message-ID: <200812040940.18076.david-b@pacbell.net>
References: <23D0CDE7C386D144A4F26EB0F427F8C019A5829E@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:38721 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758263AbYLDRkU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 12:40:20 -0500
In-Reply-To: <23D0CDE7C386D144A4F26EB0F427F8C019A5829E@dlee04.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Smith, Stephen" <smsmith@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 04 December 2008, Smith, Stephen wrote:
> I am trying to build sound support for the MDK (3430LDP).=A0 There is=
 a build
> problem on the current git master of the OMAP Zoom kernel.

Perhaps that kernel should sync with newer code?

Both linux-omap and mainline use standard GPIO calls for
such stuff now.

And for that matter, the ASoC framework holds current
twl4030 codec support... those patches are in linux-omap,
linux-next, and of course the ALSA tree.

- Dave



> If "OMAP3 TWL4030 alsa driver" is turned on, the compile fails (looks=
 like
> the header for the twl4030 gpio routines is missing).=A0 Additionally=
, if it
> is selected as a Module, the build will also fail because only
> CONFIG_SND_OMAP3_TWL4030 is being checked (not CONFIG_SND_OMAP3_TWL40=
3_MODULE)
> in sound/arm/omap/omap-alsa-dma.h.     =20
>=20
> Device Drivers -=20
> =A0 Sound card support -=20
> =A0=A0=A0 Advanced Linux Sound Architecture -=20
> =A0=A0=A0=A0=A0 ARM sound devices -
> =A0=A0=A0=A0=A0=A0=A0 OMAP3 TWL4030 alsa driver
>=20
>=20
> sound/arm/omap/omap-alsa-twl4030.c: In function 'twl4030_ext_mut_conf=
':
> sound/arm/omap/omap-alsa-twl4030.c:312: error: implicit declaration o=
f function 'twl4030_request_gpio'
> sound/arm/omap/omap-alsa-twl4030.c:317: error: implicit declaration o=
f function 'twl4030_set_gpio_direction'
> sound/arm/omap/omap-alsa-twl4030.c: In function 'twl4030_ext_mut_unco=
nf':
> sound/arm/omap/omap-alsa-twl4030.c:329: error: implicit declaration o=
f function 'twl4030_free_gpio'
> sound/arm/omap/omap-alsa-twl4030.c: In function 'twl4030_ext_mut_off'=
:
> sound/arm/omap/omap-alsa-twl4030.c:344: error: implicit declaration o=
f function 'twl4030_set_gpio_dataout'
>=20
>=20
> OMAP Linux Kernel Tracker Bug ID 224
>=20
> Stephen
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
