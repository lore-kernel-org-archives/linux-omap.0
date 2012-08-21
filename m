From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] ASoC: snd_soc_jack for HDMI audio: does it
	make sense?
Date: Tue, 21 Aug 2012 14:18:19 +0100
Message-ID: <20120821131818.GE7995@opensource.wolfsonmicro.com>
References: <5032E8A5.8070108@ti.com> <1345528867.15491.12.camel@lappyti>
 <CAO8GWq=B8wa1tWOiT5ja80T2VrxHiSKSp4U6fHydV9iyOg=+Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9206209195728891061=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CAO8GWq=B8wa1tWOiT5ja80T2VrxHiSKSp4U6fHydV9iyOg=+Zg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Clark, Rob" <rob@ti.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Ricardo Neri <ricardo.neri@ti.com>, DRI development list <dri-devel@lists.freedesktop.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org


--===============9206209195728891061==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T6xhMxlHU34Bk0ad"
Content-Disposition: inline


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 21, 2012 at 07:39:55AM -0500, Clark, Rob wrote:

> Does ASoC support 'hotplug' of audio devices?  If so, maybe it makes
> some sense to have some support in drm core.  At least all the edid
> parsing stuff to determine if the display supports audio should be
> generic and not driver specific.

Not really (except on a card level), and it'd probably confuse most
userspaces.  What I'd expect to happen currently is that the current
state of the connector would get reported via extcon.

--T6xhMxlHU34Bk0ad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM4qMAAoJEFJkBDiqVpZ4HpQP/Rii3kkUeHmfnWh0mTPPS/1J
2EV9dYOt69AKOi31M3GGxuIg9AqlW/tVDnCi9vkkuTt+F6PR8A5QUTEMlcHzEcX3
ySgkcXdB0gWoFJqkr8Iuqa/EXqcswcLvmS4lMgqWGhoa6p7BO1pHdXTQrXCWcODo
jvTAEhgf44R8jgDeP/NXKt0OtAb3t22IRkdIQkOoIS71v/lrPwZiUtPD5HiklQTE
sh3lOI+8SriCEX6l1Ll9s3CmJ0pjzHoaUAIcMitaBnpX82qPT/KjYvw8nr/Belbt
Qbvaz9EqkGzJOuFcRwQOgqOeQn2tk2b+rESqLuPCom7ap1FslHIT/akjJ6vL9wNA
b/bqWXGuRkXczliAdqv5oxX/Hry8RXqwMDG6MzrxO+zqNkRmx/VqOuf7uT1F0f1a
bHMP3U+nOhddLq3P0zLZpV843dvn5O2amXAC7kM2PAFKrwcYKjn4UqQEUKaF6Ch1
1t3R9GuHol8Z3vxZS+TX9QfqfuLucjtcoYJQ4ill5qsqohlxuoL1gjqjvNcU6Ae8
tmE/BoWHRwT7UD49ykLvYpHquOt1wy08MsXfukNyA3PEAoqcy6KkSVWwKOUsVzj7
ynx5P26w/KLXasF/TTxciE1Xu8E5WF8sBYts8+599u9d7sz+A8rFP9gJ+Uj3BYsp
hHYYkUXkBPpyWnh9MlWl
=8jMu
-----END PGP SIGNATURE-----

--T6xhMxlHU34Bk0ad--

--===============9206209195728891061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9206209195728891061==--
