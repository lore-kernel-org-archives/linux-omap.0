From: NeilBrown <neilb@suse.de>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Sat, 4 Feb 2012 11:01:31 +1100
Message-ID: <20120204110131.7378b8fe@notabene.brown>
References: <13274430881471@kroah.org>
	<alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
	<20120126042155.GA3185@suse.de>
	<alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
	<20120126191604.GA15516@suse.de>
	<alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
	<alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
	<20120203150708.386951d2@notabene.brown>
	<alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com>
	<20120203205401.5ddf241d@notabene.brown>
	<alpine.DEB.2.00.1202031255330.27947@utopia.booyaka.com>
	<20120204085940.2de44594@notabene.brown>
	<alpine.DEB.2.00.1202031532540.27947@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/FSiDglXPns_dXXOa3SgaGRD"; protocol="application/pgp-signature"
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1202031532540.27947@utopia.booyaka.com>
Sender: linux-serial-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: greg@kroah.com, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--Sig_/FSiDglXPns_dXXOa3SgaGRD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Feb 2012 16:02:42 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrot=
e:

> On Sat, 4 Feb 2012, NeilBrown wrote:
>=20
> > On Fri, 3 Feb 2012 13:10:28 -0700 (MST) Paul Walmsley <paul@pwsan.com> =
wrote:
> >=20
> > > Considering your theory that the UART clocks are being cut while ther=
e's=20
> > > still data in the FIFO, you might consider removing this code at the =
end=20
> > > of transmit_chars():
> > >=20
> > > 	if (uart_circ_empty(xmit))
> > > 		serial_omap_stop_tx(&up->port);
> >=20
> > I read the code and chickened out of just removing that.
> > serial_omap_stop_tx seem to do 2 things:
> >  1/ tell the uart to stop sending interrupts when the tx fifo is empty
> >  2/ set forceidle (really smartidle) on the uart.
> >=20
> > I didn't feel comfortable removing '1' as I thought it might generate an
> > interrupt storm .. maybe not.
>=20
> Might be worth a try.  In theory, since the current UART driver sets the=
=20
> TX_EMPTY flag in the SCR register, the UART should only raise a TX=20
> interrupt when the FIFO + shift register are totally empty.  So hopefully=
=20
> you should only get one extra interrupt per TTY transmit operation.
>=20
> > Instead I just removed '2'.  In fact I replaced the 'set_forceidle' cal=
l with
> > 'set_noidle'.  So the uart should never report that it was idle.
> >=20
> > I did this with my other patch removed so pm_runtime_put() was still be=
ing
> > called.
> >=20
> > Result:  I still get corruption.
> > So having the UART say "no, I'm not idle" does *not* stop the clock
> > being turned off when we use omap_hwmod_idle() to turn off the clocks.
>=20
> Hmm that's doubtful.  If that's really so, then we should be seeing=20
> massive UART transmit problems.  I'd expect that the driver wouldn't be=20
> able to get any transmit buffers out the door at all before the UART's=20
> fclk is cut.

Guess what happens if I set autosuspend_delay_ms to 0?
Massive transmit problems.  Driver can hardly get anything out before the
UART's fclk is cut...


>=20
> What's probably happening in this case is that the hwmod code is rewritin=
g=20
> the UART SIDLEMODE bits in the hwmod code's _idle() function.  This gets=
=20
> called as part of the PM runtime suspend operation.  So it's bypassing=20
> your debugging hack :-)  The hwmod code expects to control the SYSCONFIG=
=20
> register bits itself, and the current way that the UART driver messes wit=
h=20
> the SYSCONFIG bits is a total hack that that hwmod code is not expecting.=
 =20
> You could try disabling that behavior in _idle_sysc() by adding a hack to=
=20
> skip it if it's the UART3 hwmod.
>=20
> > When we turn off a clock, if that is the last clock in the clock-domain=
, we
> > also turn off the clock-domain (I think).
>=20
> That's only true if the clockdomain is programmed to use=20
> software-supervised idle.  CORE & PER should both be programmed to=20
> hardware-supervised idle by mach-omap2/pm34xx.c.  In that case, we let th=
e=20
> PRCM put the clockdomain to sleep by itself.
>=20
> > Could it be that the clock-domain doesn't do any handshaking with modul=
es,
> > and so turns off the clocks even though they are being used?
>=20
> Probably not -- I'd think that hardware-supervised idle wouldn't work at=
=20
> all if that were true.

Thanks for those hints.  Next time I dive into the code/doco they might help
me understand a bit more.

Thanks,
NeilBrown


--Sig_/FSiDglXPns_dXXOa3SgaGRD
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTyx1Wznsnt1WYoG5AQLQQw//cdmLqXn/xosNgh6u1bE9FpT8uce6YWQR
h7+RE7wMBK1M9MXVMbaitNJgWpNp6iww1IsiIU7bjpwj+4+orQt5tT91Y/jUky7u
zDGozEskWINxftsWtBhMv+ecUql2a0B0D6sMQ+UA6Disqb4WyVaKF7gBmGQQtntd
gnN7bkhvQnwSHGejCY7At9VnNNHWR1vwwVuj9NaUbshb8HeShdSAG8Q4cqvflbmv
9MfxXPzdCz0KLDjuyjC2c4mopVswedBedJcQXcH965zqwKOiHw6CLneKR8tufJRs
Lb0NWFbmOH5BxBDZfpn8VxKYfJX7xdVS/tMVK3MQ94Wrg9cLNdcC02xSTPJvYynj
f3BY5YudAMXRDkklJKWvdisTFqIdrwbR3J/2Eg59yJ5hJhY/rG+b9Q3Zn+rab+kp
BXcDiFuAg4uOojQlBATBTVM7UpgTDcwLLG5RHs1/pDx60WlYe2P4z7ZPsoHgFWkg
RKHVZ7xufxNnOueJmahtMNa5hPN1r40hqJAWb6RBnvm2mdHSKnnBWnb1zyCGWcec
tFqiL4NzD15wmy9LObkZxxzsgZIiF/M5HG5pd/gWwh97wmQ6TDQF3RebZlFrNizr
Ly/Fn6yt9ua/xBGSOnlofvP9jli6/Og+pGRI5DjQ0mqKH/Y7HclYgjhs/+DW1bGn
JgkJMHzmLbw=
=Ab4Q
-----END PGP SIGNATURE-----

--Sig_/FSiDglXPns_dXXOa3SgaGRD--
