From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: Re: [PATCH] ARM: OMAP: Add support for dynamic GPIO switch update
Date: Mon, 15 Dec 2008 16:52:32 +0200
Message-ID: <1229352752.5895.325.camel@jani-desktop>
References: <1229342896-7363-1-git-send-email-ext-jani.1.nikula@nokia.com>
	 <20081215134010.GA10709@mail.solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32141 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbYLOOwe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 09:52:34 -0500
In-Reply-To: <20081215134010.GA10709@mail.solidboot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Juha =?ISO-8859-1?Q?Yrj=F6l=E4?= <juha.yrjola@solidboot.com>
Cc: linux-omap@vger.kernel.org

On Mon, 2008-12-15 at 15:40 +0200, ext Juha Yrj=C3=B6l=C3=A4 wrote:
> On Mon, Dec 15, 2008 at 02:08:16PM +0200, Jani Nikula wrote:
>=20
> > Add new function omap_update_gpio_switch() to support dynamically
> > changing the GPIO switch notify callback functions and debounce
> > timeouts.
>=20
> Why do they need to be changed? GPIO switches related to the board sc=
hematics,
> which do not hopefully change dynamically.

The switches themselves don't change (nor does this patch support
changing them), but different kinds of external devices may be connecte=
d
to the GPIO swiches. It would be useful to be able to change the
notification callbacks and debounce timeouts according to the device.

> > +	spin_lock_irqsave(&sw->lock, flags);
> >  	if (state)
> >  		timeout =3D sw->debounce_rising;
> >  	else
> >  		timeout =3D sw->debounce_falling;
> > +	spin_unlock_irqrestore(&sw->lock, flags);
>=20
> What's the point of this? The above read can be consider an atomic op=
eration.

Umm, I suppose I was more worried that the write might not be an atomic
operation, messing up the read as well. But I'll take your word for it
if you say the write is okay. :)

> > +	spin_lock_irqsave(&sw->lock, flags);
> > +	notify =3D sw->notify;
> > +	notify_data =3D sw->notify_data;
> > +	spin_unlock_irqrestore(&sw->lock, flags);
> > +
> > +	if (notify !=3D NULL)
> > +		notify(notify_data, state);
>=20
> What if omap_update_gpio_switch() is called just before the check for
> notify !=3D NULL from another (hypothetical =3D)) CPU? Then you end u=
p with the
> function completing, but still having the old notify callback called =
with
> old notify_data.

I was, of course, making sure a NULL pointer is not called and there's
no mismatch between old/new notify/notify_data. Your scenario might
theoretically actually occur on a single processor system as well, don'=
t
you think?=20

But is it actually a problem or not? And if yes, do you have any
suggestions as to handling the case? If there's no need to lock for
reading the debounce timeouts in gpio_sw_irq_handler() as you say above=
,
do you think I could switch to a mutex and call notify callback holding
that?


BR,
Jani.


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
