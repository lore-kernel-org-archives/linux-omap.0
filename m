From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 1/1] mfd: omap-usb-host: Fix USB device detection problems
 on OMAP4 Panda
Date: Mon, 02 Dec 2013 15:03:47 +0100
Message-ID: <529C9343.3010000@linutronix.de>
References: <1385730118-26402-1-git-send-email-rogerq@ti.com>	<1385730118-26402-2-git-send-email-rogerq@ti.com> <CAOf5uwmEkzFd=e3j8m8=qdTCAMkk_-DPw0fTm=7Vzy0PbE2oDQ@mail.gmail.com> <529C55DF.3000808@ti.com> <529C76AF.10106@linutronix.de> <529C7922.5000601@ti.com> <529C854F.3010101@linutronix.de> <529C8CBD.4070003@ti.com> <529C8D74.10007@linutronix.de> <529C8ED0.6060805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <529C8ED0.6060805-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, ljkenny.mailinglists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 12/02/2013 02:44 PM, Roger Quadros wrote:
> "Errata id: i660
> DESCRIPTION
> In the following configuration :
> =95 USBHOST module is set to smart-idle mode
> =95 PRCM asserts idle_req to the USBHOST module. (This typically happ=
ens when the system is going to
> a low power mode : all ports have been suspended, the master part of =
the USBHOST module has
> entered the standby state, and SW has cut the functional clocks.)
> =95 an USBHOST interrupt occurs before the module is able to answer i=
dle_ack, typically a remote wakeup
> IRQ.
> Then the USB HOST module will enter a deadlock situation where it is =
no more accessible nor functional.
> The only way to recover will be to perform a software reset of the mo=
dule.
>=20
> WORKAROUND
> The best workaround consists in switching the module to force idle mo=
de right before cutting the
> module's FCLK.
> =95 the bus has reached the suspend state.
> =95 write SYSCONFIG:Idlemode=3D ForceIdle and read it back to ensure =
the write has been taken into
> account in case of posted writes.
> =95 cut the FCLK
> =95 Idle_req will be asserted and idle_ack answered within one L3 clo=
ck cycle.
> Upon resume or remote wakeup, switch back the module to smart-idle.
> This workaround reduces the failure window to only one L3 clock cycle=
=2E The probability for an interrupt to
> fire at this exact time is considered extremely low, and the case has=
 never been hit on board."
>=20
> Based on this, I don't see anything wrong in Resetting the module at =
probe or at boot.

If u-boot configured USB into something not smart-idle and the reset
would bring it back then the reset should remain.
If you could tell hwmod not use smart-idle nor smart-standby and you
make sure that the suspend code manually puts the device into suspend
via forceidle then I think could get rid of the "do-not-reset-thingy".

>=20
> cheers,
> -roger
>=20

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
