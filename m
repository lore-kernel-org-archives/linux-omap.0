From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900: Broken lirc ir-rx51 driver
Date: Tue, 5 Jan 2016 11:18:41 +0100
Message-ID: <20160105101841.GI22661@pali>
References: <201601021545.35201@pali>
 <20160102170657.GB12622@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160102170657.GB12622@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machel <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Saturday 02 January 2016 09:06:57 Tony Lindgren wrote:
> Hi,
>=20
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [160102 06:46]:
> > --- a/drivers/media/rc/ir-rx51.c
> > +++ b/drivers/media/rc/ir-rx51.c
> > @@ -25,9 +25,9 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/sched.h>
> >  #include <linux/wait.h>
> > +#include <linux/clk.h>
> > =20
> > -#include <plat/dmtimer.h>
> > -#include <plat/clock.h>
> > +#include "../../../arch/arm/plat-omap/include/plat/dmtimer.h"
>=20
> Well we don't want to export the dmtimer functions to drivers..But
> we now have the PWM driver that can be already used for most of the
> ir-rx51.c.

Ok. Is PWM driver included in mainline kernel?

> >  #include <media/lirc.h>
> >  #include <media/lirc_dev.h>
> > @@ -208,7 +208,7 @@ static int lirc_rx51_init_port(struct lirc_rx51=
 *lirc_rx51)
> >  	}
> > =20
> >  	clk_fclk =3D omap_dm_timer_get_fclk(lirc_rx51->pwm_timer);
> > -	lirc_rx51->fclk_khz =3D clk_fclk->rate / 1000;
> > +	lirc_rx51->fclk_khz =3D clk_get_rate(clk_fclk) / 1000;
> > =20
> >  	return 0;
> > =20
> >=20
> > So Tony, you are author of that commit (a62a6e98c3) which broke ir-=
rx51
> > module for Nokia N900. Do you know how to fix this driver for upstr=
eam
> > kernel? It would be great to have driver working and not to have it=
 in
> > this dead state...
>=20
> Yup please take a look at thread "[PATCH 0/3] pwm: omap: Add PWM supp=
ort
> using dual-mode timers". Chances are we still need to set up the dmti=
mer
> code to provide also irqchip functions. That way ir-rx51.c can just d=
o
> request_irq on the selected dmtimer for interrupts.

No I see that patch from that thread uses dmtimer.h from plat-omap. So
it is really OK?

> > Also platform data for this driver are only in legacy board code.
> > Support in DTS is missing, so driver (after fixing above problem) c=
annot
> > be used on DT booted kernel.
>=20
> Yeah those parts should be already doable with the PWM timer code AFA=
IK.
>=20
> Regards,
>=20
> Tony
>=20
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
