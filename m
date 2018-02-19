From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv4 1/4] dt-bindings: sound: add motorola,
	cpcap-audio-codec
Date: Mon, 19 Feb 2018 13:05:14 +0000
Message-ID: <20180219130514.GC32761@sirena.org.uk>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
 <20180214220741.28306-2-sebastian.reichel@collabora.co.uk>
 <20180216113008.GB5886@sirena.org.uk>
 <20180216132537.lkd4wzfg7uuoyx7k@earth.universe>
 <20180216134448.GI5886@sirena.org.uk>
 <20180216141237.rd75sbix7bopi7zu@earth.universe>
 <20180216151609.GK5886@sirena.org.uk>
 <20180216155706.GS6364@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9007305722250155169=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180216155706.GS6364@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org


--===============9007305722250155169==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Content-Disposition: inline


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 16, 2018 at 07:57:07AM -0800, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [180216 15:17]:

> > It's not just other operating systems, it's also other versions of
> > Linux we have to think about here.  The most obvious issue with audio is
> > the clocking where the division between ASoC and clock APIs is not super
> > obvious and could easily change in the future.

> Yeah let's stick to describing how the hardware is wired in the
> dts files. In this case it's really only the routing to the SoC,
> right?

The SoC and anything else on the board like external amps and so on.

> One advantage of using a compatible property for the pmic subdevices
> though is that it leaves out a dependency between various device
> drivers things happen automagically. The mfd core driver can be
> minimal and just implement interrupt handling and regmap. So no need
> to to parse the child nodes in the pmic mfd driver :)

There's no need to do that anyway - with a MFD the child devices can
assume that they're part of the MFD and reference their parent.

> So personally I'd prefer the option that requires least amount
> of custom code if compatible vs no compatible property is the
> only issue here.

It's a few lines of code to register the child devices from code rather
than the DT, and keeps it out of the ABI.

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqKy4kACgkQJNaLcl1U
h9B1lQf/a8TZDsqEBvQtJkGu5qETjBBmD3NKFPciTMSDiDjESniZiUpr9iqEp8i+
agilWO/k3bTnMokOJbA099mqFI9i0gMc/VrdcTwdURkDnxc6/UN+iUD2rLLjZ0XD
I+twFE0vEt8JAJZABYcspfHqogrwz0E3wHKwRnwJugf931HzzQqb1lyi1VYa1u4Q
f/voPWQT87XIYpt5l04X3RGlgpKEk7mnyOFkyQUfsuIPr7FZlORRDuhNrypGBvHq
/7E6x/X2JFPV0Ri9uFTjq+WsIeHMPztFiE28CKbgJC1XJFdji0uR7zH/3ZtD9TAn
P4KmKZS2g8RozgPdo7K0uN6/IW+oUw==
=u1LI
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--

--===============9007305722250155169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9007305722250155169==--
