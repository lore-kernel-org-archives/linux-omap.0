From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv4 1/4] dt-bindings: sound: add motorola,cpcap-audio-codec
Date: Fri, 16 Feb 2018 15:16:09 +0000
Message-ID: <20180216151609.GK5886@sirena.org.uk>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
 <20180214220741.28306-2-sebastian.reichel@collabora.co.uk>
 <20180216113008.GB5886@sirena.org.uk>
 <20180216132537.lkd4wzfg7uuoyx7k@earth.universe>
 <20180216134448.GI5886@sirena.org.uk>
 <20180216141237.rd75sbix7bopi7zu@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rnP2AJ7yb1j09OW/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180216141237.rd75sbix7bopi7zu@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--rnP2AJ7yb1j09OW/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 16, 2018 at 03:12:37PM +0100, Sebastian Reichel wrote:
> On Fri, Feb 16, 2018 at 01:44:48PM +0000, Mark Brown wrote:
> > On Fri, Feb 16, 2018 at 02:25:38PM +0100, Sebastian Reichel wrote:

> > > While it looks empty in the DT binding file, it's actually not empty
> > > once some standard properties are added to support audio-graph-card.

> > This tells me you're missing something in the binding defining the
> > DAIs and...

> Well it is described by the following document:

> Documentation/devicetree/bindings/sound/audio-graph-card.txt

You still need to say which DAIs exist on the device and how they are
identified - if there's only one DAI it's obviously easy but if a device
has multiple DAIs then there's some naming to do.

> > ...that still doesn't require a compatible here.

> I agree, that it's not required. Also the node is not required.
> Everything could be dumped into the main node. Many things are
> not required, but they make implementations easier and help in
> regards to DT readability and consistency. Having the compatible
> means, that all sub-functions _can_ be handled equally by the
> operating system. Not having the compatible means you _always_
> need special handling for the audio codec. This basically makes
> the codec node different for the simple purpose of "because it is
> not strictly required". If we have a compatible node, other
> operating systems can still decide to ignore it, right?

It's not just other operating systems, it's also other versions of
Linux we have to think about here.  The most obvious issue with audio is
the clocking where the division between ASoC and clock APIs is not super
obvious and could easily change in the future.

--rnP2AJ7yb1j09OW/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqG9bgACgkQJNaLcl1U
h9DNMAf9H7GcnGs/G4OlpnokwAudl2Uu5fmmOrtocEShD2M27kg7Xy+yFHxw/hP5
NFntlCoM7ctaz3qW49nmcD7mgvXOVNiTRXvJGnH5j1n3iSHiBk2PRLt6OG4UdYod
5iGTyz65gpUXEbeQ7iJEGhQJd9gYsiMQMGiWGe0eiVGiqiCvfclFlBkP7mILBvTu
pdn2FGvD/BpYQ5LH538ocQLVJCSpXK/tyqJAC/fTTw1WPCBpLGuEJ0RqbUUny6F/
+jfYvCq6RhtiOnxrAQKyByblZ7vmbVx0cgirvEDIC5qDDQ328VQJkWm5qzvwtlFe
6CfbmZaqLpkt0At0H9yQ+ZQdn4iKFA==
=xZoD
-----END PGP SIGNATURE-----

--rnP2AJ7yb1j09OW/--
