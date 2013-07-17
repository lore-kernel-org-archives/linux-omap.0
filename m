From: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: musb: dsps: make it work with two instances
Date: Wed, 17 Jul 2013 14:58:03 -0300
Message-ID: <20130717175802.GD29791@localhost>
References: <1373031178-8871-1-git-send-email-bigeasy@linutronix.de>
 <CALF0-+Vo64Znw_iY0gOx5hGJ9mgw7OXFQ5HqBrTW4udW-Z=N+g@mail.gmail.com>
 <20130717171229.GA1516@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130717171229.GA1516-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Ezequiel Garcia <elezegarcia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, george.cherian-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

On Wed, Jul 17, 2013 at 07:12:29PM +0200, Sebastian Andrzej Siewior wro=
te:
>=20
> >After some minor DT tweaking on the current patchset,
> >I've managed to detect an USB mass storage device in the
> >second instance (host / usb1) using a Beaglebone black board.
>=20
> Beaglebone black, that one has a different device tree which is not
> mainline, right?
>=20

Beaglebone black it is. But I'm almost sure I just used the
am....bone.dts file that's mainlined.

I just changed the mode or something like that, very minor tweaking
indeed, altough right now I don't remember exactly which changes.

> >However, after I unplug the device, it's not recognized
> >when I replug it. Maybe you can take a look at this;
> >i'll do some more testings and see what I can come up with.
>=20
> I figured out why my Host is not recognized on the second plug:
> At module load time, musb_start() is executed and it sets the
> MUSB_DEVCTL_SESSION in devctl.
> After the device is unplugged dsps_musb_try_idle() schedules a timer
> which executes the local otg_timer() function. Since the phy is in
> OTG_STATE_A_WAIT_BCON state, the MUSB_DEVCTL_SESSION bit gets removed=
=2E
> If the removal of the bit is ignored, the device is recognized after =
a
> re-plug.
>=20

Mmmm... okey. Interesting insight, thanks!

> >Also, FWIW, I think that having a separate USB phy for am35xx would =
be
> >much better.
> So you would prefer a new file with 90% copy of what we already have =
in
> the nop_phy?
>=20

No, of course not.

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
