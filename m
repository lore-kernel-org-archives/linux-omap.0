From: NeilBrown <neilb@suse.de>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Tue, 7 Feb 2012 10:58:20 +1100
Message-ID: <20120207105820.367361c5@notabene.brown>
References: <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
	<alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
	<20120203150708.386951d2@notabene.brown>
	<alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com>
	<20120203205401.5ddf241d@notabene.brown>
	<CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
	<alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com>
	<CANOLnOPm-ZKRvu1PVs-jU2sceehRiwNPd=ysu2SDsLbarAPVbw@mail.gmail.com>
	<20120204163931.GH1275@n2100.arm.linux.org.uk>
	<EF62F09C0797D947AD4180A1043C0DF734934E36@DLEE10.ent.ti.com>
	<20120205160329.GO1275@n2100.arm.linux.org.uk>
	<EF62F09C0797D947AD4180A1043C0DF734934E9D@DLEE10.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/1QndOpipS7gKlhrfFZw4jRu"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50739 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754039Ab2BFX6f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Feb 2012 18:58:35 -0500
In-Reply-To: <EF62F09C0797D947AD4180A1043C0DF734934E9D@DLEE10.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, "R, Govindraj" <govindraj.raja@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

--Sig_/1QndOpipS7gKlhrfFZw4jRu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 5 Feb 2012 17:57:40 +0000 "Woodruff, Richard" <r-woodruff2@ti.com>
wrote:

>=20
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > Sent: Sunday, February 05, 2012 10:03 AM
> > To: Woodruff, Richard
>=20
> > On Sun, Feb 05, 2012 at 03:37:21PM +0000, Woodruff, Richard wrote:
> > > [x] What is acceptable depends is not black and white.  Is there some
> > > QOS mapping which can be set per channel which allows runtime PM to
> > > pick a best chose (which may allow for loss and frame issues)?.
> >=20
> > What you're asking is whether there's anything in the kernel which can
> > predict when the next character is to arrive.
>=20
> No, this was not the comment's intent.
>=20
> > But, the fact of the matter is that deriving the UART clocks from a PLL
> > which takes a finite time to lock, and the PLL is shut down during runt=
ime
> > PM _is_ _going_ _to_ _cause_ _problems_.  There is absolutely no getting
> > away from that.
>=20
> Yes this is one of the issues to be worked around.
>=20
> > Let's take your modem example.  Modems today would typically be used wi=
th
> > some IP based protocol, probably PPP based.  Incoming traffic on IP is
> > entirely unpredictable.  You wouldn't know when the next character would
> > be received.
> >=20
> > One solution to this is to transmit an 0xff character before your real
> > data to ensure that your end is awake and properly synchronized...
>=20
> This approach as you say has issues.  This is solved in different ways fo=
r modems.
>=20
> <sleep>My observation is modem software which many talk over ppp over ip =
over serial of some sort (might be uart, might be usb), will send a command=
 to the modem to go into a low power mode. Now you can cut clocks with out =
hurting modem and getting SOC power.
>=20
> <wake>When some event happens at modem or processor (timer near beacon or=
 other) the modem or apps processor can signal the other with some wake eve=
nt (maybe over gpio) which then puts system in a state where it can receive=
 data in trusted manner.
>=20
> The modem channel driver try's to inform kernel about entering/exiting mo=
des to set expectation.

I think the correct way to "inform the kernel" would be with the 'CREAD'
c_cflag in termios.  Clearing it indicates that we don't expect to read whi=
ch
would allow the UART to go to sleep.
When the GPIO interrupt arrives, we would use termios to set CREAD and then
start talking to the modem.

However it is easy to imagine situations where this wouldn't be enough.
A fairly obvious way to wake a sleeping serial connection is with a 'break'.
I have a GPS which can be put to sleep and then woken by sending a 'break'.
Similarly the OMAP uart can reliably receive a break when asleep, but cannot
reliably receive any other input.

Though maybe if BRKINT is set in c_iflag, then we could still receive a bre=
ak
even when CREAD is clear.  Then clearing CREAD would be enough to allow
low-power mode.

>=20
> > So, go ahead with having PM drop random characters if you want, but don=
't
> > expect anyone in their right mind to accept broken workarounds to the
> > kernel serial driver to try to drop maybe 16 characters or more at a ti=
me
> > on the floor when a framing error occurs just because the PM is broken.
>=20
> No character was dropped in modem example.  On the UART-to-Debug console =
it may be ok to drop a character.  Ether needs a coordination hook.

I don't think it is really OK to drop chars on the UART-to-Debug console.
However it is OK to drop the BAUD rate to 57600 where we can wake up in time
for to catch the first bit.  So if you want power saving, drop the console
buad rate.

So I would suggest:
 - remove the autosuspend timeouts
 - allow runtime_pm to shutdown the device when it is not open, or when
   rate is 57600 or below, or when 'CREAD' is clear
 - keep runtime_pm active whenever there are bytes in the output queue or
   fifo

The only case that wouldn't support is when a device will wake up the SOC by
sending a non-break character which it is OK to receive corrupted.  The tty
would have to be in !CREAD for that to happen, and then there would be no w=
ay
for the app to know that a non-break character was received.
Would it be reasonable to treat any input while CREAD is clear as a break?

NeilBrown

--Sig_/1QndOpipS7gKlhrfFZw4jRu
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTzBpHDnsnt1WYoG5AQJvYQ/9F3vBknf13yQY8ErmdDYvDsqqlHxO2PKs
gGhVaxsPJB1s5lzlvG8xl+duKvkQayJd1pSNNX+wDqt0DuMDn6U2keHkfvlI/u0t
mMK9LqzcdgKJTCJH64VLgQt7ixqMCd2SuJVwylPY6PWwM3B81XsYLXdNX3QePGmY
/IvD3F3UAbEbmM+hqnLAFjDHJVjPJgwH7ERAfRKw6G84a43RN1ZOezwNbFuexQO5
WgJyM11qCXUTF/yOBM1ZkL0WQvtuI5pxw1ysV0SiqUasQVCI83K2wDljL8Ov+kfv
GHZ+NIZgkOkYBkg9zKhaWLy9Mqo2uhOOE6E+WmRODU+BmUwc9TnyLBl+X2HoN7tl
yvqIIwZZYgnYVb5LZ38Fr80YkRu5f99K3efIalzvAxyoMTkNlk4pQUCdFHfYWD2y
c2sCKzqJMlIZp4BF8z856JXQjRPPugiZYLcNlc62zdP2sXycqYKMS0OxUm3gTzVg
nkZe9dnaljQL0bhwqo2xTpq/VNbBbnIRVda9yFBFVodLQN/CCd5EX/7njvEjgS8r
BGNFEhdHm9MXOnhtTpEasMBethBEF/9L1g1a24uF2YP/7XbkWvsp+CllVTlv9mna
Up2Y1HNUY1cTmkCXznOoW7f2ZCG89f9NnQzIHJXMCo+i1UeTledja6yM6L8PAY9F
2wj9+UvSngw=
=M72O
-----END PGP SIGNATURE-----

--Sig_/1QndOpipS7gKlhrfFZw4jRu--
