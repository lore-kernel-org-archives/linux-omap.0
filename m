From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] arm: omap1: devices: need to return with a value
Date: Fri, 5 Nov 2010 14:31:06 -0700
Message-ID: <20101105213106.GV9264@atomide.com>
References: <1287473455-25773-1-git-send-email-balbi@ti.com>
 <1287473455-25773-2-git-send-email-balbi@ti.com>
 <20101019080150.GC11713@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51988 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646Ab0KEVb0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 17:31:26 -0400
Content-Disposition: inline
In-Reply-To: <20101019080150.GC11713@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

* Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> [101019 00:53]=
:
> On Tue, Oct 19, 2010 at 10:30:54AM +0300, Felipe Balbi wrote:
> > Get rid of the following warning:
> >=20
> > arch/arm/mach-omap1/devices.c: In function 'omap_init_wdt':
> > arch/arm/mach-omap1/devices.c:298: warning: 'return' with
> > no value, in function returning non-void
> >=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  arch/arm/mach-omap1/devices.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/de=
vices.c
> > index 63d68cf..a037aba 100644
> > --- a/arch/arm/mach-omap1/devices.c
> > +++ b/arch/arm/mach-omap1/devices.c
> > @@ -295,7 +295,7 @@ static struct platform_device omap_wdt_device =3D=
 {
> >  static int __init omap_init_wdt(void)
> >  {
> >  	if (!cpu_is_omap16xx())
> > -		return;
> > +		return -ENODEV;
> > =20
> >  	platform_device_register(&omap_wdt_device);
> >  	return 0;
> It's unrelated to this patch, but using
>=20
> 	return platform_device_register(&omap_wdt_device);
>=20
> would be a bit cleaner.

=46elipe, care to update this one?

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
