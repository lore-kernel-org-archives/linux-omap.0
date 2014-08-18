From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v7] 8250-core based serial driver for OMAP + DMA
Date: Mon, 18 Aug 2014 11:37:57 -0500
Message-ID: <20140818163757.GK9662@saruman.home>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
 <20140815181704.GH17769@csclub.uwaterloo.ca>
 <53EE5BF8.3010007@linutronix.de>
 <20140815202826.GC9239@atomide.com>
 <53F21885.605@hurleysoftware.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYjDATHXTWnytHRU"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53F21885.605@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

--zYjDATHXTWnytHRU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2014 at 11:15:17AM -0400, Peter Hurley wrote:
> On 08/15/2014 04:28 PM, Tony Lindgren wrote:
> > * Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140815 12:16]:
> >> On 08/15/2014 08:17 PM, Lennart Sorensen wrote:
> >>
> >>> Are you saying that with the new driver you have to respond to the RX
> >>> irq faster than before to avoid overflows?  It is not quite clear.
> >>
> >> Yes. The irq fires 46 bytes giving you 16 bytes buffer before overflow
> >> vs 63 bytes buffer the old one had.
> >>
> >>> I do think 40000 interrupts to handle 40000 bytes of date does seem a
> >>> tad inefficient, so dropping to 854 looks a lot nicer.  Was the omap
> >>> driver not using the fifo trigger levels at all?
> >>
> >> It configured the trigger levels to 1 for RX and 16 for TX.
> >=20
> > Hmm that weird RX trigger level is a workaround for lost characters.
> >=20
> > See commit 0ba5f66836 (tty: serial: OMAP: use a 1-byte RX FIFO
> > threshold in PIO mode :)
>=20
> That commit looks like it should have been specific to the silicon
> exhibiting the rx timeout bug.

yeah, I'll agree with that.

--=20
balbi

--zYjDATHXTWnytHRU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT8ivlAAoJEIaOsuA1yqRE9lAQAJCVcSUkGXurWEFy590wHY0v
r+8k7+Qd0aMWTXHzENSaZCi6IGvjN2NWj2FOoCazinPOoDbMVzl4rNIdNzzqiJTm
BbsReb4J1xR0KIN1vgkpwxwcqlre+GQY88i7o8BBaNJey0Rm68iSgCjgH1WQzbmG
I1CIDZbZMCKAYhOKZGvNVUVqif30KSCvDtr7DEubzIaq0ktU4DRhQOvZr2LX2VYC
aN4VEEmqTBeJ/mbkEnVKWVdoWi5hXsMYZAT9NCMuDm/xhARLBTsY4RyAu49UrIja
NaNTbbED8h0HfNxCto2IDTtIiNoDExm2BK1bIJ4tAs8Rl5UWbcozHJnrW4lEDdl1
6koGFUJL408mEzXrHuTNvE/yrKqRprP2L/o78lMN4eZlGdg4B4pdcozrqkDaLl5g
SHr/3FKcIK9Wem+O59JVsp6+K2p0o7nEdWfEeOjhLGWpCLGWgy/cQ7+R6eMbuWYM
SNSPW2GH2SRsN19tI9i1DGlf9tOayiMxKhV0WvEljOoIEdx+9vtO5fG0yJS2aPxs
BpUEZWqJKoB5iUSKh2Vi39MHZqiK/KMNKZNH7/p94IpKEmXCkpA0zVI3WtbK+773
F1E65SvW/Tl9na2mgzkL7rZdvL3PbYQvND8nE4rpr9oR/52TrmASLbAge180HObo
c3lloT7Xiv/y5nTlFZEI
=3I5x
-----END PGP SIGNATURE-----

--zYjDATHXTWnytHRU--
