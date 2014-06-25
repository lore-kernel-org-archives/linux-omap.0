From: Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH/RESEND 9/9] drm/tilcdc: replace late_initcall with
 module_init
Date: Wed, 25 Jun 2014 11:32:46 -0300
Message-ID: <20140625143246.GA743@arch.cereza>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-10-git-send-email-guido@vanguardiasur.com.ar>
 <53A9F5F4.3030806@ti.com>
 <20140625130042.GK3705@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f46.google.com ([209.85.213.46]:46414 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756382AbaFYOdd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2014 10:33:33 -0400
Received: by mail-yh0-f46.google.com with SMTP id c41so1197438yho.33
        for <linux-omap@vger.kernel.org>; Wed, 25 Jun 2014 07:33:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140625130042.GK3705@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Darren Etheridge <detheridge@ti.com>
Cc: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

(Ccing Guido back)

Hello Russell, Darren,

On 25 Jun 02:00 PM, Russell King - ARM Linux wrote:
> On Tue, Jun 24, 2014 at 05:04:36PM -0500, Darren Etheridge wrote:
> > On 06/17/2014 09:17 AM, Guido Mart=EDnez wrote:
> >> Use module_init instead of late_initcall, as is the norm for modul=
ar
> >> drivers.
> >>
> >> module_init was used until 6e8de0bd6a51fdeebd5d975c4fcc426f730b339=
b
> >> ("drm/tilcdc: add encoder slave (v2)") changed it to a late_initca=
ll,
> >> but it does not explain why. Tests show it's working properly with
> >> module_init.
> >>
> >
> > If I recall, the late_initcall stuff was done to try and make sure =
the =20
> > tda998x/i2c subsystem came up before tilcdc.

That doesn't make any sense. Using late_initcall for the tilcdc DRM
driver would make the tilcdc DRM get probed before any other regular
module_init driver, including the tda998x encoder.

> > However it didn't always =20
> > work so we added commit: 39de6194131c155901f96686a063212656d80c2e t=
o try =20
> > and ensure the ordering.  This might be why changing back to module=
_init =20
> > is fine (and I agree with your assessment from my testing).

That commit is adds a proper probe deferal mechanism in case the
i2c is not available. OMAP is special because it has its own nasty init=
call
to probe the i2c busses. However, that should be fixed and then i2c wou=
ld be
always probed *after* the DRM, as per the ordering in drivers/Makefile.

>=20
> There's a solution to that...

A solution to *what* ?

> I have patches which convert the tda998x
> driver to also register into the component helpers as well as remaini=
ng
> as a drm slave device.  This makes it possible to transition tilcdc t=
o
> use the component helper to solve the initialisation ordering.
>=20

AFAIK, there's no issue with the initialisation ordering, except that t=
he
DRM driver is currently probed before the TDA998x encoder and so the pr=
obe
is defered. Unless I'm missing something that's very easy to fix, you j=
ust
need to change the link order to guarantee that i2c encoders are probed
*before* the DRM drivers that require them.

I have just posted a very simple patch to fix it, but it seems Thierry =
wasn't
happy with it, not sure why yet [1].

[1] http://www.spinics.net/lists/dri-devel/msg61987.html
--=20
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
