From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 3/9] ARM: OMAP: board-am3517evm:
 Configure McBSP1 CLKR/FSR signal source
Date: Wed, 22 Aug 2012 20:12:05 +0100
Message-ID: <20120822191205.GJ7995@opensource.wolfsonmicro.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7139073195471427549=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1345124468-8876-4-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org


--===============7139073195471427549==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v3iGHXxT5ZJOqjki"
Content-Disposition: inline


--v3iGHXxT5ZJOqjki
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 16, 2012 at 04:41:02PM +0300, Peter Ujfalusi wrote:
> am3517evm board uses McBSP1 for audio with 4pin configuration.
> The CLKR/FSR signals need to be connected to CLKX/FSX pin of the SoC in
> this case.

Applied, thanks.

--v3iGHXxT5ZJOqjki
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNS7/AAoJEFJkBDiqVpZ4t6cP/25lmyBbM+oj17wPvV+Ms+hj
kOEyP3mMM5uDKj4cU00zYHqJhOESOG5iak0+HgcOVtZgOJB2NwjSM3pfeHeViAAC
KhlopQdKGT7pqsjtppJ39LIi6jqgczzaCChXWFOlFeHa+Wq1Sljy/Hrhqsaq1KTV
1SQZiso55iqNuQlTyT2xv6AbFbp/680GcM9KD/3pUE8IAS1TVtfYKnMSdh5gVDd6
xlH9mCQ8QfA5CSxIs2ZFyBt7t/bXDsU4a4hGt19dSCvTxhHtmXwxs1TH9MXjv8QD
T3PXkudMrfYU7EdIXlVjwjBDXJzN57hS3ojl164IyGgxGJnFTKoGerORgN0Dy9g7
i5tImnTRAVHgoGPrvh5ukuup8INK17HP3u/VYTTjMFzF2aaTXI2piu3hBYbxslZ1
e6gZOBYw+UdreQEF1Fyx0jXRKHmadh5kzw2L6MlLV8naGCVD+p0dSOSH53WjoeUJ
urssYpRbBk2Gx4ZhDXdIKG1Cohy1c6YuYXNdecWFtRgHaD2kkXh/V0gQvz5sntT6
i3MLcy68Mrza6ES7NBodq7Sgx776wUaKCiBg9g+J30uBvri/QWpbgVbyAXRTDX8m
iW2+a77n867FDfdgRlQw1wBlbPTcyxLjDvXKZsDObkGAznpDbXVhIj3nAHK4+//W
AguUUd/7NOZpdBcV3Fpy
=w4pa
-----END PGP SIGNATURE-----

--v3iGHXxT5ZJOqjki--

--===============7139073195471427549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7139073195471427549==--
