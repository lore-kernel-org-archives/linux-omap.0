From: NeilBrown <neilb@suse.de>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Sat, 4 Feb 2012 07:44:27 +1100
Message-ID: <20120204074427.5091fef5@notabene.brown>
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
	<CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
	<alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/q0_BmtT6M3f8HWPjRMvA6ah"; protocol="application/pgp-signature"
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com>
Sender: linux-serial-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Greg KH <gregkh@suse.de>, greg@kroah.com, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--Sig_/q0_BmtT6M3f8HWPjRMvA6ah
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Feb 2012 12:42:22 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrot=
e:

> On Fri, 3 Feb 2012, Grazvydas Ignotas wrote:
>=20
> > On Fri, Feb 3, 2012 at 11:54 AM, NeilBrown <neilb@suse.de> wrote:
> > > On Thu, 2 Feb 2012 22:45:53 -0700 (MST) Paul Walmsley <paul@pwsan.com=
> wrote:
> > >> On Fri, 3 Feb 2012, NeilBrown wrote:
> > >>
> > >> > then CPUIDLE enters lower states and I think it uses less power bu=
t I
> > >> > sometimes lose the first char I type (that is known) but also I so=
metimes get
> > >> > corruption on output.
> > >>
> > >> I don't see any output corruption on 35xx BeagleBoard, either with or
> > >> without these patches. =C2=A0So this is presumably a 37xx-centric pr=
oblem, and
> > >> unrelated to these patches, I would guess.
> > >
> > > Maybe it is 37xx specific. =C2=A0I think this is a DM3730.
> >=20
> > Not sure if it's the same problem but with 3530 on 3.2 with
> > sleep_timeout set, I usually get first char dropped (as expected) but
> > sometimes I get corrupted char instead too. Corrupt char seems to
> > almost always happen if I set cpufreq to powersave, on performace it's
> > almost always ok, so maybe it's some timing problem,
>=20
> OK so let's distinguish between two corruption situations:
>=20
> 1. The first character transmitted to the OMAP UART in a serial console=20
> when the UART powerdomain is in a non-functional, low power state (e.g.,=
=20
> RET or below) is corrupted.  This is not actually output corruption, this=
=20
> is input corruption.
>=20
> 2. Characters are corrupted while the OMAP UART is transmitting data, but=
=20
> there has been no recent data sent to the OMAP.
>=20
> Case 1 is expected and is almost certainly not a bug.  As Neil mentioned=
=20
> it should be bps-rate dependent.  It occurs when the first character=20
> transmitted to the OMAP wakes the chip up via I/O ring/chain wakeup.
> I/O ring/chain wakeup is driven by a 32KiHz clock and is therefore=20
> relatively high-latency.  So this could easily cause the first character=
=20
> or first few characters to be lost or corrupted, depending on the exact=20
> sequence of events, the low power state that the chip was in, etc.

A 32KiHz cycles every 30mSec.
At 115200 bps, there is one bit every 8.7 microseconds.

When I type "return" - which looks like 0101100001111... on the wire,
I see '0xC3' which looks like 011000011111... on the wire.
So we lost exactly 2 bits, or a delay around 17 microseconds.

I find it hard to reconcile that delay with the cause being a 32KiHZ clock.

If the first char I type is a space (0x20 or 0000001001111111) then
the character received is 0x90 (0000010011111) which is exactly 1 bit missi=
ng,
so an 8 or 9 usec delay.
If the first char I type is 'o' (0x6f, or 0111101101111111) then the charac=
ter
received is 0xfb (01101111111111) which misses 5 bits.
I think it misses the first bit, then waits for a start bit (0), then takes
the next 8 bits.

At 230400 bps, I always lose at least 2 bits.
At 460800 bps, I seem lose at least 3 bits.
(above there, nothing works at all ... could be my USB/serial cable at faul=
t).

So it looks a lot like a delay which is a small number of microseconds.
Could be the wake-up latency in the I/O ring/chain, but doesn't look like t=
he
32 KiHz clock :-)

>=20
> Case 2 is not expected.  That is likely a bug somewhere.  Neil, this is=20
> what I understood that you are experiencing.  Is that correct?

Correct.

Thanks,
NeilBrown

>=20
> Gra=C5=BEvydas, are you seeing case 1 or 2 (or something completely diffe=
rent=20
> ;-) ?
>=20
>=20
> - Paul


--Sig_/q0_BmtT6M3f8HWPjRMvA6ah
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTyxHKznsnt1WYoG5AQLtYQ/8Du/t18JyRe/OiFOwFXatHcpZ3gFOFbij
Hume9cHD1+FHnvUT5nVUUulayqPrswJGAI1pubCDcu1MCoHPNiLuP1f8Y39zC5/z
/1P+/jvL5ZEh9YFpj/76mkh3ZzbTSzJiHP676+VnOW71th98NpRVut25QJPTKvUw
BmCLH5o6rHMaB8Ne+GAsla+hLEojUZLZjjOUmHwR26La8Ji9JQQuWwGzAujhMDH0
zQk9+n78IvpzP2foaFMdqU/hgyh7mqHwloWY7Mhv1Y8TH6Bj/XVpM7Td55IsLjt8
FB5c+GcYx7mkh3mfnXpZE74GZlsdsDtovi6Ybm6tEynuyzCWtT/n5PxvqUJVv3gj
4SzHHLBSLc8SeAlLerC334tU56zDE1jeEMKEWaH1BnPd5lxgpe7A8kgug1xjo89k
90nhWK6XBPGdmUrHDyIqXunWW6q5ZHNH87pshtmiBvVg6R5tNiumuTiAP9ZssVfC
LhBJHo2OzgZd8WgxGj5y4n7GUU8gy7rXFN7NopaKYx2xsU0ZILRLt5MY2kMXj+Q5
epp6XSmstiVkEf6RVmIioJImHuM4/VwdgtCuuXubpWs51Kz/YYCWG5io3OqnytU7
iRe31yfsQXZ+Ec2p0Q/OSDV8bEzSODDiYUMCvwrphZoC8sNbbnOn4MINOZ7WPDPg
26poQ4RJfRo=
=qg76
-----END PGP SIGNATURE-----

--Sig_/q0_BmtT6M3f8HWPjRMvA6ah--
