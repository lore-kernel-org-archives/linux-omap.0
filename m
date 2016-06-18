From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/4] ASoC: tpa6130a2: Add support for
	multiple instances
Date: Sat, 18 Jun 2016 23:33:47 +0200
Message-ID: <20160618213346.GB5510@earth>
References: <cover.1466218805.git.helen.koike@collabora.co.uk>
 <20160618104038.GB31665@earth>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1758155730589654205=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20160618104038.GB31665@earth>
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


--===============1758155730589654205==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 18, 2016 at 12:40:38PM +0200, Sebastian Reichel wrote:
> On Sat, Jun 18, 2016 at 12:26:27AM -0300, Helen Koike wrote:
> > The current tpa6130a2 driver supports only a single instance.
> > This patch series add support for multiple instances by removing
> > the global variable that holds the instance. This is performed by
> > using the component API, regmap, the snd_soc_{info,put,get}_volsw
> > API and DAPM.
>=20
> yay! *stroking cleanup of the driver from my todo list*
>=20
> > This patch series also touches code from the Nokia RX51 which I
> > didn't tested (as I am testing the tpa6130a2 in another board, that
> > is not upstream). I would appreciate is if someone who possesses
> > the Nokia RX51 (n900) could please test the code.
>=20
> I had a look at the rx51 parts and will test later/tomorrow.

Ok, here are some notes (I used the git branch you provided). First
of all kernel messages contain:

[    4.217163] ALSA: Control name 'TPA6130A2 TPA6130A2 Headphone Playback V=
olum' truncated to 'TPA6130A2 TPA6130A2 Headphone Playback Volu'

Next here is a amixer output diff:

root@n900:~# amixer > amixer.old (v4.7-rc [without your patches])
root@n900:~# amixer > amixer.new
root@n900:~# diff -u amixer.old amixer.new
--- amixer.old	2016-06-18 23:08:57.478027343 +0200
+++ amixer.new	2016-06-18 22:26:13.878102558 +0200
@@ -480,11 +480,12 @@
   Capabilities: pswitch pswitch-joined
   Playback channels: Mono
   Mono: Playback [off]
-Simple mixer control 'TPA6130A2 Headphone',0
-  Capabilities: pvolume pvolume-joined
+Simple mixer control 'TPA6130A2 TPA6130A2 Headphone Playback Volu',0
+  Capabilities: volume volume-joined
   Playback channels: Mono
-  Limits: Playback 0 - 42
-  Mono: Playback 0 [0%] [-59.50dB]
+  Capture channels: Mono
+  Limits: 0 - 63
+  Mono: 0 [0%]
 Simple mixer control 'b ADC HPF Cut-off',0
   Capabilities: enum
   Items: 'Disabled' '0.0045xFs' '0.0125xFs' '0.025xFs'

If I remember correctly, the reduced playback limit up to 42 is
important on N900, since hardware can be destroyed. It may have been
another control, though. Also the capture channel looks wrong.

Last but not least: Audio output doesn't work, but works on a kernel
without these changes.

-- Sebastian

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXZb44AAoJENju1/PIO/qa/lYQAJg5iDIh5yLOK78gjkeE9lrX
65DmD6qhVdYnhVJ3UzGsInk4K74aPMXhA2RCRFY4XhIkKoiuvl1HlXyVV8SU/W+h
+cE0K4MEJQKksfuoTZBvS0AWTYM3KitM4jwsY3ExL2YtDk01qibvi13QekREdl6A
ugLPHT5/oky70AkIeMUB5TNP8MqYoBDe60DlvyNXCpXoC41uMBCoqyt78ZA3DRM0
v4ihkQLCaBceKdy4uFuGmYzMNKLn36IWHV65yUQVF3Z+QSy5Dr4wkVWHKltYxNlX
d8zdmTjPI69mxscUcprVthFBKgPn6JJ5iSSbZ7A2a9b2M4hW6kBKJqWbDdp6Dl60
X9x4elyZ7C2UdIEs5Kmg0r8BkIOatjZHzwr8mABB3IomVUG3RkXOa74OENkYg+VB
ZvX2RLt3ymyXn+eXfXiptjwBS26Iycc00lEt4HuqTrl75rdRPqP5oPML2eWcrLit
9DafRYcY8mgl4i6NIcfLc2tN7RgKkLsrEqgDyi51mSTwxnRkx8B5dQCdnsZrG1hU
L1dScDC90i8+cFyFfjN3h318leXW7odP7JN7DXAsFDh5VTE0uvVkIHNHYLEZr9ot
leyo/e96hcUk7zl/KI4Zz4/w9WWpzhiRI/EO3u2USaSssk8vQURxpPBE8QIf1ihm
/Tk1dm2LyZORyf6N9ICm
=i8Lm
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--

--===============1758155730589654205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1758155730589654205==--
