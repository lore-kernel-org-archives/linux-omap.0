From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH 15/15] tty: serial: 8250: omap: add dma support
Date: Tue, 2 Sep 2014 22:38:35 +0200
Message-ID: <20140902203834.GA7050@earth.universe>
References: <20140827202313.GF16006@atomide.com>
 <20140828082348.GA5413@linutronix.de>
 <20140828164645.GG16006@atomide.com>
 <53FF84DF.7080406@linutronix.de>
 <20140828225454.GM16006@atomide.com>
 <540048B4.7010807@linutronix.de>
 <20140829161221.GO16006@atomide.com>
 <5404B149.6010400@linutronix.de>
 <54060EDA.6060204@linutronix.de>
 <20140902201536.GC11766@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:41836 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302AbaIBUiy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Sep 2014 16:38:54 -0400
Content-Disposition: inline
In-Reply-To: <20140902201536.GC11766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, balbi@ti.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2014 at 01:15:37PM -0700, Tony Lindgren wrote:
> * Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140902 11:40]:
> > On 09/01/2014 07:47 PM, Sebastian Andrzej Siewior wrote:
> > > Comparing it with serial-omap I see the same thing: I takes approx the
> > > same amount of data until the first one is displayed. After a lot of
> > > "long" writes which wake the chip up from idle I manage to freeze bot=
h,
> > > the serial-omap driver and mine driver.
> >=20
> > So after some testing:
> > - it happens with omap-serial as well. Especially after disabling the
> >   LED trigger for both LEDs.
> >=20
> > - it seemed that disabling the MDR1 check whether or not we lost
> >   context made the problem appear less often but it was a trick. Even
> >   with restoring the context each time I see the same problem.
> >=20
> > - it seems to be easier to trigger with the LED trigger switched off.
> >   However sometimes it works for 10 minutes, sometimes it triggers
> >   after one.
> >=20
> > - I see to face two kind of "deaths":
> >   - the LED still goes on and off and the uart just does not respond
> >     even if I tell the button print something on the screen (the button
> >     also changes the frequency of the LED so I know that the button is
> >     doing something).
> >     Also from dumping the content of /proc/interrupts it seems that a
> >     wake up is made, the uart should have restored the registers.
>=20
> OK yeah this is the case I was seeing too. So do you just set the
> LED triggers to none in sysfs to make it easier to reproduce?
>=20
> >   - one where the system is dead and the LED does not blink anymore.
> >     Also my button is dead.
>=20
> This I don't think I've seen. This could also be the errata issue on
> your earlier rev beagleboard-xm with off-idle.
> =20
> > - disabling DMA makes the problem not go away.
>=20
> OK
> =20
> > - mdelay(25) in omap8250_lost_context() is long enough to drop the 403
> >   bytes I send in my testcase. That means I see only "good" characters.
> >   With this the box remained alive for 2h. However the uart died anyway.
>=20
> I wonder if doing some TX on the uart restores it? So maybe try
>=20
> $ while [ 1 ]; do date; sleep 10 done &
>=20
> To have it occasionally print something in the background.

If there is a way to detect the hangup you may try to recover by
resetting the serial device using omap_hwmod_reset().

-- Sebastian

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUBirKAAoJENju1/PIO/qaCIgP/Rds/S7BGi6+vDjkYjvjnAC4
WFCthw8g084rktqWOxZXg4HyCRVTnFpPvrxcurEOtZZSFacvR/e+v1ZObLqJ12O6
75xRgMTSAOY9tzxe62Sq4Gqmf07Gdu8iqSlkk5eAUOAXRRsehaMFMJNxK+MVnczA
HZY5ZKbEv9C43GyDL2TaCEn4q/9q35qY9/TcdTPO9rJNUg6SVQkcCf0ixxgfqBkk
C17XD050YRyWdonh7hL5ZJY1GhdHDXN4ZJtzQXkDLfNPu3noq1SqubNfvWsU1KzB
HVW/QKvc4uyoThotbF7ZSa3JYfpB0+m7Y6I0rGgDfxVCKBBjD1MKbUUlyjQdHPGf
dC03A0NCJmTSvUUs1/86QgpgiGBWAPi2GxMuSw3+PklbNfrCRmzG4ykRa7J+6Ini
kpjKpDOmj6S70T+bO6lv+8KjnPr8Wn32gK3YvHVZ22VP8Lx1wm+3cmn6T9AFXSYE
f3w7TbGND8b8xeDir6kbUBLAfcZpAuUme1R74WRXehkw2l3q05iMURWkm7ZgJwHS
SqszW0qhnX2+IIPecH2g7LHu0LNzO1rfm3vOhV/o7RHN6shtX481KONPEkzXELM2
Ldisg4gyXI5s3EfAJjMMsSEibTqoSbeYZXtrM3fq4kmkhZfSaeSdN+Nyz7YLuT2A
xcY1vmkekO+4ju2oXo+0
=hCWF
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
