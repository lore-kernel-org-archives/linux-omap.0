From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 6/7] ASoC: omap-mcbsp: sidetone: Use the new callback
 for iclk handling
Date: Mon, 2 May 2016 11:42:13 +0100
Message-ID: <20160502104213.GD6292@sirena.org.uk>
References: <1461927202-17677-1-git-send-email-peter.ujfalusi@ti.com>
 <1461927202-17677-7-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461927202-17677-7-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, jarkko.nikula@bitmer.com, paul@pwsan.com, lgirdwood@gmail.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 29, 2016 at 01:53:21PM +0300, Peter Ujfalusi wrote:
> The McBSP sidetone (in OMAP3 McBSP2 and 3 module) is working with the
> module's interface clock. When the sidetone is enabled the iclk must not
> idle because it will result in choppy sidetone.

Acked-by: Mark Brown <broonie@kernel.org>

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXJy8EAAoJECTWi3JdVIfQis0H/AuTWwMoioY55G4h3vyLSj97
mJV7WNkV/CMOBQr6m0cdvkkEUdrNO5Vczx4ltWUwqH0CTt2qHWDbjT2oQBXAiXWT
8Mf4sJTzkGilfCLxcDQT+KMurd/VKYjiXnQGOZ6JMayzFDbkEeXFlifXUvdCCLRm
tH5OwiDQXHRijSTKGftsmLwVCrn2kqE8FV6QN5HN7Od6PBV+pgmXh8nJgVVsCBC6
yIWMAz/cDI/KRzxrl0pjvqErCpUHE7PxO2cRST3nEnQ8V33Fiikkeu2sCeMLmaHX
mEoDidMhb0gfy5b8QGhtfuD7VSDLRmOQLieuL66USOjMaaveNNQnxAtGfc2jbcY=
=EFya
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
