From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
Subject: Re: [PATCH] cbus-tahvo: Add tahvo_write_reg locking
Date: Mon, 7 Nov 2011 09:18:36 +0000
Message-ID: <20111107091836.61377657@Nokia-N900>
References: <20111105171954.230d12fb@milhouse>
	<20111107061044.GB4265@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bues.ch ([80.190.117.144]:38206 "EHLO bues.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019Ab1KGJKT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 04:10:19 -0500
In-Reply-To: <20111107061044.GB4265@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On Mon, 7 Nov 2011 08:10:45 +0200
=46elipe Balbi <balbi@ti.com> wrote:

> Hi,
>=20
> On Sat, Nov 05, 2011 at 05:19:54PM +0100, Michael B=C3=BCsch wrote:
> > tahvo_write_reg() needs to take the mutex to avoid a race
> > condition with tahvo_set_clear_reg_bits:
> >=20
> > tahvo_set_clear_reg_bits():   |  tahvo_write_reg():
> >     __tahvo_read_reg()        |
> >                               |      __tahvo_write_reg() <-- race h=
ere
> >     __tahvo_write_reg()       |
> >=20
> > Signed-off-by: Michael Buesch <m@bues.ch>
> >=20
> > ---
> >=20
> > Index: linux-3.1/drivers/cbus/tahvo.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-3.1.orig/drivers/cbus/tahvo.c	2011-11-05 17:03:39.5988461=
19 +0100
> > +++ linux-3.1/drivers/cbus/tahvo.c	2011-11-05 17:04:36.274768324 +0=
100
> > @@ -104,7 +104,9 @@ void tahvo_write_reg(struct device *chil
> >  {
> >  	struct tahvo		*tahvo =3D dev_get_drvdata(child->parent);
> > =20
> > +	mutex_lock(&tahvo->mutex);
> >  	__tahvo_write_reg(tahvo, reg, val);
> > +	mutex_unlock(&tahvo->mutex);
>=20
> yeah, my bad. The same should be done with tahvo_read_reg(). Care to
> resend this patch adding the change to tahvo_read_reg() too...

I think tahvo_read_reg is fine without a lock.
read vs write is already atomic due to the cbus lock.

it's the same situation as for retu. where we also don't need the lock =
in retu_read_reg.

--=20
Greetings, Michael.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
