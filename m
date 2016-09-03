From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add PM QoS support for
 McBSP to prevent glitches
Date: Sat, 3 Sep 2016 18:08:36 +0200
Message-ID: <20160903160836.yvyucnp5oefuherq@earth>
References: <20160831141340.h24szdqjnicmt2ew@atomide.com>
 <20160831165959.3sldcjxaci3kdx6z@atomide.com>
 <eef88aa4-b829-1889-f083-eb0359c0dac6@ti.com>
 <20160831194107.wijnbmdns2jjvzkv@atomide.com>
 <5af44090-6902-2ade-be78-378843757a0a@ti.com>
 <20160901145006.xr3ux63cg6f5bh7p@atomide.com>
 <b3a254b2-948f-f04d-3289-fb8fb9f9ab23@ti.com>
 <20160902155437.GA4152@amd>
 <2ff0fe3b-d2a2-6186-1091-6aa802eb3596@ti.com>
 <20160902200922.getqf6xbiivvamj5@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4693698624104834754=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160902200922.getqf6xbiivvamj5@atomide.com>
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
Cc: "Kristo, Tero" <t-kristo@ti.com>, alsa-devel@alsa-project.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============4693698624104834754==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e7ogxms2hxkbuo4v"
Content-Disposition: inline


--e7ogxms2hxkbuo4v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 02, 2016 at 01:09:23PM -0700, Tony Lindgren wrote:
> > So it must be possible to reproduce it on BeagleBoard-xm...
> > I will try to get the PM working on it and let's see (hear).
>=20
> Yeah you can do that quite easily with current mainline or next with
> omap2plus_defconfig. Just use minimal modules and make sure *hci USB
> kernel modules are not loaded. So root on MMC, not NFS. The same goes
> for few other modules, at least hsi and isp used to block idle but I
> have not checked the recent status for those.

hsi should be fixed since 9c99e5e51988, which is part of 4.8.

> [...]

-- Sebastian

--e7ogxms2hxkbuo4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXyvWBAAoJENju1/PIO/qa8e4P/iRRtIdAF6xJg9dyR8c2is6T
h/Y00Xm9MXjomFYRipuB1RBzJySBKVfWjfqcCTcBXTMFpEVrc1xxhZz5ObsACYWk
8EEkJYmcYnTdCoY/J81Czc6BOUWU++KJt+3xZzBBhqgakkLa852SD4CSqDjmqLCi
H79d8ItxbGPKCaovB5mK31m7dGi0J0csj35KR0hhosyJm81dQSB1zaOniedseJTM
6TLjCzoc17jgvARSH2hRazWG5RGAJoVjuF/85BBciOWS7W3eRbuJy+k4Y9TUgAaX
/nXiwwnLDPz6SdSjUq9Y/TAOZ43zFowsW923jutbu7JehOMOhQHf0RzEqcNV128Z
/ASgvrBrAOlhVY2sEfwIFj6HK9zhYpmEQrViLM+cCwi39H3nmdEkB2eEVzf0zevs
2Azjy1cQoaCzstnDw1DrVlHMFNUn1ZJbSoHJqc4FhCQ2sgUdXZxNcbODD3PAjqIu
n3kokGFHjsl8QtOlDgS7Cy1v+aqzQC7nZ0PJ5O/NIvVRiYu/zd141tTt3KMvny8v
+P2jtcDCSJ7USXjjgt2Pq4l+07r/mCiys/QndeCl8CQgGIFgOmc1YNgENPCnPbpW
Tyf53HS2hTazRmNcqxSqx7M7C763twNNGuGPp5AofvO1/xqt0S89GyZiq9QjjU1x
UcUtFN0DKOFGvOp1aU+M
=EzLB
-----END PGP SIGNATURE-----

--e7ogxms2hxkbuo4v--

--===============4693698624104834754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4693698624104834754==--
