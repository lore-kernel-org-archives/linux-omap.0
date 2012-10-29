From: Tim Niemeyer <tim.niemeyer@corscience.de>
Subject: Re: [PATCH] gpio: omap-gpio: add support for pm_runtime autosuspend
Date: Mon, 29 Oct 2012 09:52:08 +0100
Message-ID: <1351500728.2194.69.camel@herbert.er.corscience.de>
References: <20121026114250.GA26342@arwen.pp.htv.fi>
	 <1351257553-7896-1-git-send-email-tim.niemeyer@corscience.de>
	 <20121026200137.GC29548@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:51955 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758174Ab2J2Ivh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Oct 2012 04:51:37 -0400
In-Reply-To: <20121026200137.GC29548@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jon Hunter <jon-hunter@ti.com>

Hello

Am Freitag, den 26.10.2012, 23:01 +0300 schrieb Felipe Balbi:
> Hi,
>=20
> On Fri, Oct 26, 2012 at 03:19:13PM +0200, Tim Niemeyer wrote:
> > Adds support for configuring the omap-gpio driver use autosuspend f=
or
> > runtime power management. This can reduce the latency in using it b=
y
> > not suspending the device immediately on idle. If another access ta=
kes
> > place before the autosuspend timeout (2 secs), the call to resume t=
he
> > device can return immediately saving some save/ restore cycles.
> >=20
> > This removes also the bank->mod_usage counter, because this is alre=
ady
> > handled in pm_runtime.
> >=20
> > I use a gpio to monitor a spi transfer which occurs every 250=C2=B5=
s. The
> > suspend overhead is to high, so almost every second transfer is los=
t.
> > This patch fixes that.
> >=20
> > Signed-off-by: Tim Niemeyer <tim.niemeyer@corscience.de>
> > ---
> >  drivers/gpio/gpio-omap.c |   81 ++++++++++++++++++++++++----------=
-----------
> >  1 files changed, 43 insertions(+), 38 deletions(-)
> >=20
> > diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> > index 94cbc84..708d5a9 100644
> > --- a/drivers/gpio/gpio-omap.c
> > +++ b/drivers/gpio/gpio-omap.c
> > @@ -31,6 +31,7 @@
> >  #include <asm/mach/irq.h>
> > =20
> >  #define OFF_MODE	1
> > +#define GPIO_AUTOSUSPEND_TIMEOUT                2000
>=20
> something just hit me... If you keep timeout at 2000 ms and you hook
> this up to an IRQ line, it's very unlikely GPIO will ever sleep.
>=20
> Why did you choose 2000 ms ? Arbitrary value ?
Got it from the spi driver (27b5284cfbe187732ebb184b03ea693f44837f9d).
I have no problem with reducing this. As i don't know how much
power-overhead the suspend needs, what do you think is a good value in
terms of power-saving?

--=20
Tim Niemeyer

Corscience GmbH & Co. KG
Henkestr. 91
D-91052 Erlangen
Germany

e-mail: tim.niemeyer@corscience.de
Internet: www.corscience.de

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
