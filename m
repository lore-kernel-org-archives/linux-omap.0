From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/4] ASoC: tpa6130a2: Add support for
	multiple instances
Date: Sun, 19 Jun 2016 22:14:14 +0200
Message-ID: <20160619201413.GC15429@earth>
References: <cover.1466218805.git.helen.koike@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2272149252706949631=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <cover.1466218805.git.helen.koike@collabora.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Helen Koike <helen.koike@collabora.co.uk>
Cc: k.kozlowski@samsung.com, lars@metafoo.de, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, broonie@kernel.org, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org


--===============2272149252706949631==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 18, 2016 at 12:26:27AM -0300, Helen Koike wrote:
> The current tpa6130a2 driver supports only a single instance.
> This patch series add support for multiple instances by removing the glob=
al
> variable that holds the instance.
> This is performed by using the component API, regmap, the
> snd_soc_{info,put,get}_volsw API and DAPM.
>=20
> This patch series also touches code from the Nokia RX51 which I didn't te=
sted (as
> I am testing the tpa6130a2 in another board that is not upstream).
> I would appreciate is if someone who possesses the Nokia RX51 (n900) coul=
d please
> test the code.
>=20
> This patch series is based on git://git.kernel.org/pub/scm/linux/kernel/g=
it/broonie/sound.git for-next
> Available at https://git.collabora.com/cgit/user/koike/linux.git/log/?h=
=3Dsound/review/tpa6130a2

Locking at the resulting tpa6130a2.c I suggest to add a patch
removing the useless "goto err_gpio" in tpa6130a2_probe().

Also switching to gpiod_get() safes some more lines of code.
It may make sense to postpone this to 4.9, though (this change
involves removing the gpio from the platform data and the rx51
will become DT only in 4.8).

-- Sebastian

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXZv0NAAoJENju1/PIO/qafIcP/3zx1X1jmNrwh3LOukvBS4EW
tcCs/kMXXxG7U+6yxOrXmbUmnz5BzQ4Dzs2fxmt/NfyS9GMqUo6PptYHQQLnc6gX
CA0HZDdoQS7tjPsgMPPeLO0Oiosh5YVXAAc1DrS7pW5RQrRvMwFe8kBThP9kYovH
JppnH7iLJ0ehPm4Q//HVkUsIOvc4mHds2pqAIS2hZbc7fySWCXENLfFi8ZpkJpv4
Pu6trR1RQ/elmrCz1xEiln2StePh4dIlhFDaGJp2UbpjrWEX29M/iF9p2ExQZIb6
nKKzrbwGfxOQMA0ooQrbgXlB6mMUDIH7TcoHtZCKQqnxduvWNsNtRCsKr/SCqNs9
0coHQ2o723pwh2IdfrFZlSi/hk/Wi3N4EyWUTcGijRMMibU0UZpjoFHB7j5tVZb8
0ResxlVvdqwRp2G8O7WVUNfqNTKQH5GYe6lzhFfL0LwP3KmCF0P3SS+RTuq1ZBtC
8wwpOlkCO4Y4HGtuSilGIU6cztmfZVcRQRKVJabU9R/3oQf/A/Fbyo/aDuvpTe0+
YPurBsCEU6V7Jv9n9F0aoVxcKkNBaDFDyN5nQNMU+9c3Struvg1rGNc+ELM6jEXo
XkLgY4cjkkKK/OAgKd47+eHKheP2o03CqmGLYReuGEs+7MqvLiKrPZJUvMEkXeLL
RgQMa1fgOU9Be0F9xJxu
=ZCaa
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--

--===============2272149252706949631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2272149252706949631==--
