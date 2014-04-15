From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] ASoC: Allow Aux Codecs to be specified
	using DT
Date: Tue, 15 Apr 2014 13:14:32 +0100
Message-ID: <20140415121432.GY12304@sirena.org.uk>
References: <1396733753-9820-1-git-send-email-sre@kernel.org>
 <1396733753-9820-3-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3287065818251548246=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1396733753-9820-3-git-send-email-sre@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Sebastian Reichel <sre@ring0.de>, Pavel Machek <pavel@ucw.cz>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org


--===============3287065818251548246==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="apSYfA7d5AHMku3c"
Content-Disposition: inline


--apSYfA7d5AHMku3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 05, 2014 at 11:35:50PM +0200, Sebastian Reichel wrote:
> This patch adds support for specifying auxiliary codecs and
> codec configuration via device tree phandles.
>=20
> This change adds new fields to snd_soc_aux_dev and snd_soc_codec_conf
> and adds support for the changes to SoC core methods.

What binding is supposed to be implemented by this?

--apSYfA7d5AHMku3c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTSKkAAoJELSic+t+oim9/WsQAJbb5rAEXw99PNcgkQGDmK6p
OepYpcpMf8RO85qL3no2x8C+YjW7w44sljpozlFf8px/SDuee8FCjKUm9HN26htl
bcSX9DN80S/zMOcO3h74sdTLZrNYIrAgiEPzNs/IbMH67lLTHm23BjTlfUdFlldz
3H/FlXvJ86Hux5fwMcrhz5JSgCngQ8tnDAAA5C5/mbPLVchKpsm4/l4eiAf35YQe
bf33rMxLqDH9l97aTrjguDSRefnqI4PZmyMxg0VQONnLb5vadDo93ucYQyITbU7W
Rxf8HJvrJte41xbcZovltF9xtmGZ+yE+MMrruwaqLKUrIAz6tKUQXm+NHO27irUL
Jq+nZr0vyHg03uRTdJBrRWVq3yOmmQUCCjHlAQJ0CfZeK/sASbzouNXyK5JuL8SU
IRbANr4GqXBOEM3Tnmvoq/pktQgdVcNL2pJsJ/R8D6Y+nZTiqHCCT/djRQblQe5n
SOh8ExBeRVSoyyNGOs4+OEYZiYYol01dgU0cm7S5fJ3/IlvyuxZXnLBvf1v5NEC1
eX/fKR7/CVK3dz4/1bihW/2QYgX7XkUq+UmwIsaaYPTGZVAPPIJJWfq4N0DYdQ3J
NupACShR9v+iq8YPQAgZvb9JzzXhucQvXm21xQVdQtF5VFen18/t893q7IbpNsIO
FrdPDQeJAspFbSZd1nS5
=tQs2
-----END PGP SIGNATURE-----

--apSYfA7d5AHMku3c--

--===============3287065818251548246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3287065818251548246==--
