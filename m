From: NeilBrown <neilb@suse.de>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Sat, 4 Feb 2012 08:59:40 +1100
Message-ID: <20120204085940.2de44594@notabene.brown>
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
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/EN0kda3g02SFo22xq=XCYCE"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50180 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754779Ab2BCV76 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Feb 2012 16:59:58 -0500
In-Reply-To: <alpine.DEB.2.00.1202031255330.27947@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: greg@kroah.com, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--Sig_/EN0kda3g02SFo22xq=XCYCE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Feb 2012 13:10:28 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrot=
e:

> One other comment..
>=20
> On Fri, 3 Feb 2012, NeilBrown wrote:
>=20
> > On Thu, 2 Feb 2012 22:45:53 -0700 (MST) Paul Walmsley <paul@pwsan.com> =
wrote:
> >=20
> > > On Fri, 3 Feb 2012, NeilBrown wrote:
> > >=20
> > > > I can remove this effect with:
> > > >=20
> > > > diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/=
omap-serial.c
> > > > index f809041..c7ef760 100644
> > > > --- a/drivers/tty/serial/omap-serial.c
> > > > +++ b/drivers/tty/serial/omap-serial.c
> > > > @@ -440,7 +440,8 @@ static unsigned int serial_omap_tx_empty(struct=
 uart_port *port)
> > > >  	spin_lock_irqsave(&up->port.lock, flags);
> > > >  	ret =3D serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : =
0;
> > > >  	spin_unlock_irqrestore(&up->port.lock, flags);
> > > > -	pm_runtime_put(&up->pdev->dev);
> > > > +	pm_runtime_mark_last_busy(&up->pdev->dev);
> > > > +	pm_runtime_put_autosuspend(&up->pdev->dev);
> > > >  	return ret;
> > > >  }
>=20
> It's a little surprising that this helps.  The pm_runtime_get*() and=20
> _put*() in serial_omap_tx_empty() are just intended to ensure that the=20
> UART's clocks are running for that LSR register read.
>=20
> Considering your theory that the UART clocks are being cut while there's=
=20
> still data in the FIFO, you might consider removing this code at the end=
=20
> of transmit_chars():
>=20
> 	if (uart_circ_empty(xmit))
> 		serial_omap_stop_tx(&up->port);

I read the code and chickened out of just removing that.
serial_omap_stop_tx seem to do 2 things:
 1/ tell the uart to stop sending interrupts when the tx fifo is empty
 2/ set forceidle (really smartidle) on the uart.

I didn't feel comfortable removing '1' as I thought it might generate an
interrupt storm .. maybe not.
Instead I just removed '2'.  In fact I replaced the 'set_forceidle' call wi=
th
'set_noidle'.  So the uart should never report that it was idle.

I did this with my other patch removed so pm_runtime_put() was still being
called.

Result:  I still get corruption.
So having the UART say "no, I'm not idle" does *not* stop the clock
being turned off when we use omap_hwmod_idle() to turn off the clocks.

When we turn off a clock, if that is the last clock in the clock-domain, we
also turn off the clock-domain (I think).
Could it be that the clock-domain doesn't do any handshaking with modules,
and so turns off the clocks even though they are being used?

NeilBrown

--Sig_/EN0kda3g02SFo22xq=XCYCE
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTyxYzDnsnt1WYoG5AQLzcQ/8Dq67gZN1M+8AXPg/9e/2yNsasnxZFFtD
2QZDv/2G+XlB5BfQQPuFkRBiBUuARR8DAV77nplmfFbRcR/bjtDRmlyBapTyVEt2
YsK/XgG2eIgHRoHz2vhUpoqJUxRTTGZYZFrDptV9iFr/JYzd5jS/cv4ALWE5jmlY
3bsil+DLWNPnOiMI0ZTKdxCJZPg3lteiQg1AyDgvyiLKEoUXXBVPWnn4kEJLaOFF
TlYCUP+5QxykLvLsL0NCIaaZFl04iERK2yY3dASqkjatjVKcYz9VhfdJtqEQFwX8
yIjXmw3sWODgLQk403nW7DBlTfRG3FiNLvdMPfgUHmJ4xcuKXKMsnkJsJCYd+vqw
6OkhXOFaI3iEHalE8V1Yp2g+UVh28XCk5B99jre68KBSQY+lq9hF8wP7DxdiHxnb
4CgWsdZOjcZpeq7LNTzurYpYwmNrsibpVbhMprmdiyYQNa+N3A2b/Gx66ul+IX0C
RvXGpakvldbN70ORWegiCuRXEK/MMsvo6OYmyFDGnWgA8Md5OugACXz74Mtrc4BT
Tbehyn3iqlnEFP3VGTVmqYcnMve+IJMGlStpblp7JW7QzZ/k2aMsiWMrkQSqWSHd
y2BVJBLFgcyOK1jBqfLfz7o4zIZateTi7D+EoRt59tSNLCTWRc3iFJMC3zhsx9E0
VAluAQG4sNk=
=5+KD
-----END PGP SIGNATURE-----

--Sig_/EN0kda3g02SFo22xq=XCYCE--
