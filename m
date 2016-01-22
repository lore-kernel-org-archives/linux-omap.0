From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] regulator: ltc3589: make IRQ optional
Date: Fri, 22 Jan 2016 16:26:10 +0000
Message-ID: <20160122162610.GZ6588@sirena.org.uk>
References: <1453292992-1788-1-git-send-email-LW@KARO-electronics.de>
 <1453292992-1788-2-git-send-email-LW@KARO-electronics.de>
 <20160120164258.GF6588@sirena.org.uk>
 <20160121080524.27af489f@ipc1.ka-ro>
 <20160121102015.GI6588@sirena.org.uk>
 <20160121112611.34e17cb2@ipc1.ka-ro>
 <20160121111115.GJ6588@sirena.org.uk>
 <20160121123311.5346e40d@ipc1.ka-ro>
 <20160121162646.GK6588@sirena.org.uk>
 <20160122064145.36b7f2b4@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S0bejtPoMQWM2IlW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160122064145.36b7f2b4@ipc1.ka-ro>
Sender: linux-kernel-owner@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--S0bejtPoMQWM2IlW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 22, 2016 at 06:41:45AM +0100, Lothar Wa=DFmann wrote:
> > On Thu, Jan 21, 2016 at 12:33:11PM +0100, Lothar Wa=DFmann wrote:

> > Your commit message (quoted above) claims that without this patch if no
> > interrupt is supplied then the unsupplied interrupt will somehow be left
> > screaming and make the system unusable.  This doesn't make sense, if
> > there is no interrupt there is nothing to scream.

> "Otherwise" meant the case where the IRQ is specified in DT as is
> currently required to get the driver loaded at all.

> > So, contrary to what you've been saying, the interrupt is actually
> > connected (and worse, connected to a NMI) but apparently not described
> > in DT.  Why is it sensible to make the driver poll (which will affect
> > all systems using this device, even those that don't care) and not just
> > describe the interrupt in DT so it can be handled promptly in the normal
> > fashion?  Presumably this will run into serious problems if the
> > interrupt actually fires at runtime since the NMI will scream, it's not
> > clear to me how the poll will manage to run successfully in that case.

> Currently the driver won't even load without an IRQ specified in DT.
> My patch makes it possible to use the driver without requiring an IRQ!

You're not just making the interrupt optional, you are also implementing
polling support.  That's really unusual and there's no clear reason for
it, your changelog seems to claim that it is needed to make the system
work but that seems at best very surprising and would need a more
detailed changelog.

You at least need to provide an understandable changelog, though it
seems it is more likely that there is a more sensible way of dealing
with this.

--S0bejtPoMQWM2IlW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWolghAAoJECTWi3JdVIfQ+bQH/0YgPkrUJsUzKwNBtYiNRKJX
V3ObffcF0e7/ppDLWuD4XzTPnsIEAaQIQi2mZ8RNtH4IhcQF2KK46ys2LBvbrAQi
o33QRzc/GHpxe160VEYkiaou1pX9xuNlRpJt8hcL++yeyNuiyEbs6/eTBMlGHAox
wq8Kb35kbHY7MkZ42D4k7TDWN1DRwZtc9gDCgJPefWdQhDikOrcnxzn2mL5qQ8vW
UPNPSFcMiArmX3iikOTDJ9JOOF0U4pfM20bxyTm3HO7VjXdHwle/ZpcqugNhGjg5
a7lodZ1Nvfgh/Hxukc2QSwq/WLGLRV1pUVTzwcWtUMHHN4WCFI9w5o99ZC96DQM=
=sWYC
-----END PGP SIGNATURE-----

--S0bejtPoMQWM2IlW--
