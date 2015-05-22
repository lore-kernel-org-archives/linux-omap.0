From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: races in omap_wdt
Date: Fri, 22 May 2015 13:24:01 -0500
Message-ID: <20150522182401.GF5582@saruman.tx.rr.com>
References: <20150423094354.GD19431@pengutronix.de>
 <20150424091840.GK19431@pengutronix.de>
 <20150522181647.GM24769@pengutronix.de>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s5/bjXLgkIwAv6Hi"
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150522181647.GM24769-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--s5/bjXLgkIwAv6Hi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2015 at 08:16:47PM +0200, Uwe Kleine-K=F6nig wrote:
> On Fri, Apr 24, 2015 at 11:18:40AM +0200, Uwe Kleine-K=F6nig wrote:
> > [dropped Varadarajan Charulatha and Shubhrajyoti D from the addressees
> > because the ti mailserver doesn't know them :-(, added Felipe instead]
> >=20
> > On Thu, Apr 23, 2015 at 11:43:54AM +0200, Uwe Kleine-K=F6nig wrote:
> > > I'm working on an AM335x machine and want to make use of the hardware
> > > watchdog. I write to you because you contributed to the respective Li=
nux
> > > driver and judging from your email address you might be in a position=
 to
> > > help me with a problem I see.
> > >=20
> > > To get reliable behaviour, I don't want to have situations where the
> > > watchdog is disabled. There are currently two situation where this
> > > happens with the current state of linux/drivers/watchdog/omap_wdt.c:
> > >=20
> > >  a) in omap_wdt_probe() there is an unconditional call to
> > >     omap_wdt_disable() which stops the counter. Ideally I'd want to t=
ake
> > >     over the hardware in the state that it is in when Linux is starte=
d.
> > >     This is a bit complicated, but should be doable. Would such a pat=
ch
> > >     be welcome?
> > >=20
> > >  b) The reference manual demands:
> > >=20
> > > 	To modify the timer counter value (the WDT_WCRR register),
> > > 	prescaler ratio (the WDT_WCLR[4:2] PTV bit field), delay
> > > 	configuration value (the WDT_WDLY[31:0] DLY_VALUE bit field), or
> > > 	the load value (the WDT_WLDR[31:0] TIMER_LOAD bit field), the
> > > 	watchdog timer must be disabled by using the start/stop sequence
> > > 	(the WDT_WSPR register).
> > >=20
> > >     This effectively means (and is implemented accordingly in the
> > >     driver) that on .set_timeout the driver has to stop the counter.
> > >     So we have an (admittedly small) unprotected window each time the
> > >     timeout is set (which happens for example when /dev/watchdog is
> > >     opened). Is there something that can be done here? I imagine that
> > >     the above statement from the reference manual could be holding out
> > >     some details like "When writing a new load value (WDT_WLDR) witho=
ut
> > >     stopping the timer first, the new load value doesn't have any
> > >     influence on the running timer. It is only used on the next trigg=
er
> > >     event." Is this too much to wish for?
> > As Felipe predicted (via irc) it's really needed to stop the timer to
> > reprogram the reload value. I proved this by hacking my bootloader's mw
> > command to correctly write to the watchdog registers (i.e wait until the
> > corresponding bit in the Watchdog Write Posting Bits Register disappears
> > to signal the write has reached the hardware) and did:
> >=20
> > 	# make the wdog slow
> > 	mw 0x44e35024 0x3c
> >=20
> > 	# set reload value (WLDR)
> > 	mw 0x44e3502c 0xff000000
> >=20
> > 	# start wdog
> > 	mw 0x44e35048 0xbbbb
> > 	mw 0x44e35048 0x4444
> >=20
> > 	# set reload value lower (WLDR)
> > 	mw 0x44e35024 0x00000000
> >=20
> > 	# trigger
> > 	mw 0x44e35030 0x12345678
> > 	mw 0x44e35030 0x87654321
> >=20
> > 	# show current counter (WCRR)
> > 	md 0x44e35028+4
> >=20
> > 	sleep 4
> >=20
> > 	# trigger again
> > 	mw 0x44e35030 0x12345678
> > 	mw 0x44e35030 0x87654321
> >=20
> > 	# show current counter (WCRR)
> > 	md 0x44e35028+4
> >=20
> > 	# stop wdog
> > 	mw 0x44e35048 0xaaaa
> > 	mw 0x44e35048 0x5555
> >=20
> > The output is twice
> >=20
> > 	44e35028: ff000001
> >=20
> > :-(.
> I guess none of you from inside TI checked any deeper, right? Honestly I
> doubt that it would result in a positive surprise, but still I'm pinging
> these questions once more. Do you can provide a way how to reprogram the
> hardware without stopping it first?

heh, as I said before, this IP requires a stop to be reprogrammed. I
went all the way to back the OMAP1710 TRM (the earliest TRM I still have
around) and lo and behold that in section 17.1.7 it states that "to
modify the timer counter value, prescaler ratio, or load valud, the
32-bit watchdog must be disabled by using a specific start/stop
sequence".

--=20
balbi

--s5/bjXLgkIwAv6Hi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVX3RBAAoJEIaOsuA1yqREpcAQAKGXMtoyG2NIhUNWzaj4HPeU
5ik5bUbvS5jzKUZQQVAIUFTToQeygGvTply9Sil1HOTOGAO0BzkRwZ/RUYkqyE5h
5XhUP6gFbRoKfPM2bg1Nn8bMBX30GbBo1gCUFHyF6yyYFX+L/w4knwDmKRPljybu
EX68NfObjUvFg0825OB8V/6pkz8w60RXl84u11xQq2iTCwrW7IdAqlUPm4vX+j6c
uxKR6GrPQU7JjLnXMLLo/fSo9PZ8hvQmLMWXTNs9STqDOSjtA8tjEItQxLtf5hIJ
nWmEAugI7FXwRgN0/o/XCifE1BzY57dP5Mp6MbuPBua9pjvTlgloQDi5dSoDLl1A
FBSz1oaWhNm7l7e2gL5vLvS7CJ7j+18TLuz0LrEnv8fVjI6d9aATKBlkw5lh5Msr
msCvz3x+o0XS4uJIHZJt0I61NU3WoOVBvSNv+4zoVNR3odF/vE3rPIMS/B2NCWHS
eH3jQ6odmRjHm2ukk4XJy9Yiv3emxCNNCyi85kDuurUsz3pi38C6kZ5Iot7cucZf
KHq3vqX/D0bB+64zBpLD8xE0pFKMCYlJanUDqGztRA2drlI5jfN+XzuJbCRCwgxo
lRkjdY30Ms5kxOPYK2BytX3sJ9QcSai1CosZZ/Om50bSUmpVIq0mq08j0ZdaBFJc
gtB587GxJnlB35kCgbLt
=40xV
-----END PGP SIGNATURE-----

--s5/bjXLgkIwAv6Hi--
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
