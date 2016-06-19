From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 4/4] ASoC: tpa6130a2: Add DAPM support
Date: Sun, 19 Jun 2016 11:39:15 +0200
Message-ID: <57666843.2020604@metafoo.de>
References: <cover.1466218805.git.helen.koike@collabora.co.uk>
 <2aed60529eea206f2192a7236f2d80386a73f2ee.1466218805.git.helen.koike@collabora.co.uk>
 <20160618232131.GF5510@earth>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7265928433589657001=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160618232131.GF5510@earth>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Reichel <sre@kernel.org>, Helen Koike <helen.koike@collabora.co.uk>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, k.kozlowski@samsung.com, lgirdwood@gmail.com, peter.ujfalusi@ti.com, broonie@kernel.org, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============7265928433589657001==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ECqn3XmgfkV6ebxCSNkUbkHE6Xcw6eBDp"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ECqn3XmgfkV6ebxCSNkUbkHE6Xcw6eBDp
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 06/19/2016 01:21 AM, Sebastian Reichel wrote:
> Hi,
>=20
> On Sat, Jun 18, 2016 at 12:26:31AM -0300, Helen Koike wrote:
>> Add DAPM support and updated rx51 accordingly.
>> As a consequence:
>> - the exported function tpa6130a2_stereo_enable is not needed anymore
>> - the mutex is dealt in the DAPM
>> - the power state is tracked by the DAPM
>=20
> This breaks headphone on N900. So far I only checked, that
> tpa6130a2_power_event() is not called. I guess the DAPM
> graph is wrong.

Can you try with

+	{"TPA6130A2 HPLEFT", NULL, "LLOUT"},
+	{"TPA6130A2 HPRIGHT", NULL, "RLOUT"}

being replaced with

+       {"TPA6130A2 LEFTIN", NULL, "LLOUT"},
+       {"TPA6130A2 RIGHTIN", NULL, "RLOUT"},

Thanks,
- Lars



--ECqn3XmgfkV6ebxCSNkUbkHE6Xcw6eBDp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXZmhKAAoJEOj3aLScRbOZ1+EP/jwQj/N9qQZA7KJ1xETgzWn8
MVhRgzAok3jw+Xnf3gQTLd5CphAuQYlT+V0/muzuvV1ohJXyojgehRKB+MwwMdI7
bOrhvXwW5WeLnWvlaAc0Ux/Ae2jetQsnqkh7cpXojPKHTL+n7obsgeJD3I59rQYI
B9Nbf1bllx+JEfp8bHqkMUL3Xo4eZSPQS63OqpBYDIkqXx6A1p2Dw7O0Rn1EGtEZ
Idq4dl11gkcwUFgg9FBVzfCcIYjC3e7GuxYOCY5IIR6IHltrDD47im/umDoyLKMR
Oee8VCO5vq5N04agemgLVLaHymosTki/CQYONRxofmzmY+PYO5qgQL0ZUMLJoosE
K9lxJP81yBpo7Yh2PZWtm4RVQ6ukQZkjBtoDOocrmS8VxK4LhIk6wIZC8QaOl4eS
UdPb1/roYBw13U7hT6LObaYP1VADezdAi8EVYuQ3LD+QD68bRgxS62djUDaOiAJ7
HHsDDzfDxFm5cA2J5mcxXzGzS7riUIHz3oowAbwG+vgEOXRCyPf/U7rdEA30EiFm
3iOPXscctHpJLK1zgCeVH+6WlKATsis5mz6ZkFTl31aYQoqvLZmi9pNh1X0fpsh+
Pf4G09ewMR49du5OVnpovCadIbaIxoyR6mHkwZyXTbCPl3AsYLQdiMxlh19CuGfg
BTw1Nuw05GWAcM+fkTSF
=Q/7I
-----END PGP SIGNATURE-----

--ECqn3XmgfkV6ebxCSNkUbkHE6Xcw6eBDp--

--===============7265928433589657001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7265928433589657001==--
