From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 10/13] tty: serial: omap: remove some dead code
Date: Thu, 24 Apr 2014 11:41:15 +1000
Message-ID: <20140424114115.51ab3f98@notabene.brown>
References: <1398265117-11793-1-git-send-email-balbi@ti.com>
	<1398265117-11793-10-git-send-email-balbi@ti.com>
	<5357DDA8.4040206@ti.com>
	<20140424084305.20c7f301@notabene.brown>
	<20140423230121.GC10924@saruman.home>
	<20140424101329.02e6a62f@notabene.brown>
	<20140424012100.GB13374@saruman.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/MyFDg_Y7ohVtZhnIDuTresh"; protocol="application/pgp-signature"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140424012100.GB13374-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/MyFDg_Y7ohVtZhnIDuTresh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Apr 2014 20:21:00 -0500 Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:

> I have no problem either way, just that unused code doesn't have to be
> sitting in the tree and I'm not entirely sure this GPIO should be
> handled by omap-serial.c, perhaps something more generic inside
> serial-core so other UART drivers can benefit from it.

Perhaps.  But there there are more people I need to convince :-)

>=20
> > On the other hand, if you can point out to me what I'm missing, and how=
 I can
> > solve my problem with any virtual GPIOs, I'm all ears.
> >=20
> > To make my problem simple and explicit:  I have a device attached to a =
UART
> > which has a separate regulator.  The regulator should be powered on if =
and
>=20
> So you're using DTR to power the GPIO and hoping that the regulator
> stabilizes quickly enough so that by the time your open() finishes you
> don't have to add nonsensical msleep() calls before writing to the
> device. Sounds a bit fragile to me.

The gpio_set call is synchronous, and the gpio-regulator driver could add a
delay (I think).


>=20
> > only if the /dev/ttyXX interface to the UART is open.  The device is a
> > bluetooth transceiver.
>=20
> considering this is a BTUART device, why didn't you do this at the ldisc
> level ? hci_uart_open() sounds like a good choice from a quick thinking.
>=20

I'll have a look into that, thanks.

NeilBrown


--Sig_/MyFDg_Y7ohVtZhnIDuTresh
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIVAwUBU1hruznsnt1WYoG5AQIoTxAAhZtt6b9GiMtK7g4jvMTBUXXlZ3k5XCK2
zDLI/LyVWwR9T+3fsWOGf6X/n57YWdOGlNNjlKw8TWXUOCquRI9j33LLF3XTO/8K
772Mffn4s1NcFzn1J4OqxcX4r4LiWnS0IH+mZKa/Hg/DLGr2tijLx+qlda8wzKTV
emq7cpHkosXpbEFFTF9seSehBiY16Xvd9iHi5La0rYFDma7nh14S6+PRjaSmmmDN
MI+2bdOH2veU7YEcngLzv21DrF4cAnF4wTCIfD86sENrJ4ezBKRD4+fFoaeh2CBq
jhjzC6FO9EqH//FoihiSuElEdZ22UHsaJNODdlID/tO+DjYCPzxGeimgYJbzV2eo
X/aMEzdrKUn/Hoeif8p21ayQ1jiAra6OLuTsrzg9ylezEfVk+KO3vsWrtoaDk4K2
q85BSzAD6SZSBCr+/vZt0ynUQLYSifG5ARbh+qWCbVkRpPWTnOIOQBvyC/+Mrkpz
eFwTouDDgMll5Iskn4oA38tgzFEck3bYb3pPjRhK+QT7uctvB5123w49qw4llTfD
0w2KeUWGFFLMyCEy/91I19x2qhMRBQqoLS73pVh74OGb5sfQFD/vfd0bJKmSzbsh
HJCiDg504o0ybFl47UkWFX8ZTshfFMUW9SCz0cbtPH53/fNfaagCERYbuYhNEj8Q
BU77UdEnt1c=
=YzD4
-----END PGP SIGNATURE-----

--Sig_/MyFDg_Y7ohVtZhnIDuTresh--
