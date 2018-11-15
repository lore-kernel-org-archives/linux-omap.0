From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] ASoC: omap-mcpdm: Support for handling
	pdmclk
Date: Thu, 15 Nov 2018 14:30:12 -0800
Message-ID: <20181115223012.GR2089@sirena.org.uk>
References: <20181114124631.4586-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1875609445185744718=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181114124631.4586-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org


--===============1875609445185744718==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u3NPeJodHuZECfqv"
Content-Disposition: inline


--u3NPeJodHuZECfqv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 14, 2018 at 02:46:29PM +0200, Peter Ujfalusi wrote:

> I have separated the binding document update and the driver patch and also
> added the return value check for the clk_prepare_enable() as per Mark's comment.

I guess this depends on your other series for pm_qos - it's fine itself
but doesn't apply, I'm leaving the pm_qos series for a bit longer in
case there's more reviews.

--u3NPeJodHuZECfqv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvt83MACgkQJNaLcl1U
h9BCNwf/X0P+NNQozjA2zKEPie30BBUiBV6d9T2QyfKlKhuA8ZOCoYpzdvob2Bca
njFIWZpnhjBZvQ1X9rDP5Oru58oJZFCuVii0x/BwuL9NdktC3a75A2wGyo66Ilwd
inUl6mKwla+4X6ctBNjpCYqLbdIr1VpxBI656k1xmKRKiOZ0DXms4mmh0M8V8LEL
TOeU/t2Pud8MBW0jYMc7cPDt4KrzkfZhoPVo4QlOTHjmbtiFgBwMTVIZj6E3X9Sg
feS66/0yMXTZF71SFoAbrl1+cY/1HK/vU+8B9n5JgyYxUHoB2jKZb3G8YaSGVqLH
fikm31dhwc7jRMqezYOsg8zU4WF6fQ==
=tHNe
-----END PGP SIGNATURE-----

--u3NPeJodHuZECfqv--

--===============1875609445185744718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1875609445185744718==--
