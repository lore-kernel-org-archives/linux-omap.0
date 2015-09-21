From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v4 3/8] ASoC: hdmi-codec: Add
 hdmi-codec for external HDMI-encoders
Date: Mon, 21 Sep 2015 10:18:23 -0700
Message-ID: <20150921171823.GY30445@sirena.org.uk>
References: <20150921093107.GF21098@n2100.arm.linux.org.uk>
 <56000900.3070404@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9012289225446264356=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <56000900.3070404@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, peter.ujfalusi@ti.com, moinejf@free.fr, airlied@linux.ie, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tony@atomide.com, tomi.valkeinen@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============9012289225446264356==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+9WMDU/RdULAIC7Q"
Content-Disposition: inline


--+9WMDU/RdULAIC7Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 21, 2015 at 04:41:20PM +0300, Jyri Sarha wrote:
> On 09/21/15 12:31, Russell King - ARM Linux wrote:

> >The device may accept 32 bit I2S, but it would have to be truncated to
> >24 bit before transmitting it to the sink.  This should be mentioned
> >somewhere.

> There is ".sig_bits = 24" in hdmi_i2s_dai, but I can add an explicit comment
> about it.

> We needed 32bit format in practice until Peter got 24_LE properly working
> with McASP. I just thought the may still be some platforms out there that
> can not produce 24bit i2s samples for some reason, but work just fine with
> 32bit samples. Those platforms would be limited to less than 24bit precision
> without 32bit formats. But as said, it is not critical to us any more and I
> can drop the 32bit formats as well.

Yes, this is currently a bit messy - we should really be able to allow
S24_LE and S32 to interoperate better without drivers having to know
about it since physically they are essentially compatible in memory.
I'm pretty much OK with it for now since even with that framework
support it should be harmless.

--+9WMDU/RdULAIC7Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWADveAAoJECTWi3JdVIfQQmsH/0zk2wceghIe8zLAV97hlifQ
DVL6jXaV3pUZHsJcS5vX/aVJ8ZIrPaedTguxfIrMeHMCgZpkJRyGaNRwKd50Kgn4
pNRIt9Td6fbb07TF4Rn95u/sga30qRZrsCjs7s1as+Zzr/aPjvvMAn3lj83Zxq8x
suQVfjwx+V2sPbE4XRW8SOh0GgX5mRt737gsAAQMSYVRCz+diTajsYCoM8FRxt5v
ruUZA2L01fF5rwUppwW4A+CGkdSll63+c0XwBe+xzhmY6fOA7DTI4dvNYAEJvB44
nNKLyqK+Kt5wSXMghuXQeV92SB0d2MK3S2MXHZn/K8q414gwX2O33CaV/47Ux9I=
=h6py
-----END PGP SIGNATURE-----

--+9WMDU/RdULAIC7Q--

--===============9012289225446264356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9012289225446264356==--
