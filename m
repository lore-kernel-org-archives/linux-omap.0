From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv4 1/4] dt-bindings: sound: add motorola,
	cpcap-audio-codec
Date: Mon, 19 Feb 2018 13:25:28 +0000
Message-ID: <20180219132528.GD32761@sirena.org.uk>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
 <20180214220741.28306-2-sebastian.reichel@collabora.co.uk>
 <20180216113008.GB5886@sirena.org.uk>
 <20180216132537.lkd4wzfg7uuoyx7k@earth.universe>
 <20180216134448.GI5886@sirena.org.uk>
 <20180216141237.rd75sbix7bopi7zu@earth.universe>
 <20180216151609.GK5886@sirena.org.uk>
 <20180216155837.e57lt4dhc7wlryq6@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1369315446907799424=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180216155837.e57lt4dhc7wlryq6@earth.universe>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org


--===============1369315446907799424==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Content-Disposition: inline


--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 16, 2018 at 04:58:37PM +0100, Sebastian Reichel wrote:
> On Fri, Feb 16, 2018 at 03:16:09PM +0000, Mark Brown wrote:

> > It's not just other operating systems, it's also other versions of
> > Linux we have to think about here. The most obvious issue with audio is
> > the clocking where the division between ASoC and clock APIs is not super
> > obvious and could easily change in the future.

> Which does not change my argument. Other handling in Linux is
> basically equal to other operating system. We don't loose anything
> by having a compatible available.

It's bad practice to do it - we need to remember we're designing ABIs
here and try to do the best job we can of them.

--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqK0EcACgkQJNaLcl1U
h9DNPAf/XNoLoMTpjX2ygbW/XlY1u8PS5wMLRIFzuGFXu7KLw4lCwX+yc7m8Ct+N
RZn3nss4v71fIUvx9T03/MTLZQfyrnhFNkcMSqrabnryxjZTimWSGpktiv7wqEAA
gayEEtJpBrZCY2/LwgFTMMwyn43clGy6buttIE3gJsOFtfZrQ/h72pFyurS8Jyhx
WhKJ1titVUq1WXchL154tjNLql/yMe4cCaKA3r4Kqe+LKNEDTGv5b6k0xv1V/As6
Q6iJODdeb8vDVqzppUwDRqjxVzIwLgj4uX7DKezPH8dfty00L1HN7U2051F7llr/
NftlkfzL0WiEcrOgTU46wWCxwai8Ag==
=JKIr
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--

--===============1369315446907799424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1369315446907799424==--
