From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ARM: OMAP2+: twl-common: Fix compile time
 error when omap-twl4030 audio is not enabled
Date: Thu, 23 Aug 2012 15:39:43 +0100
Message-ID: <20120823143943.GC7995@opensource.wolfsonmicro.com>
References: <1345703701-27283-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8153577186576456791=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1345703701-27283-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: Brian Austin <brian.austin@cirrus.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-next@vger.kernel.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============8153577186576456791==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="12mfjY/2IcLDkfPj"
Content-Disposition: inline


--12mfjY/2IcLDkfPj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 23, 2012 at 09:35:01AM +0300, Peter Ujfalusi wrote:
> Fixes:
> CC      arch/arm/mach-omap2/twl-common.o arch/arm/mach-omap2/twl-common.c=
:562: error: conflicting types for =E2=80=98omap_twl4030_audio_init=E2=80=99
> arch/arm/mach-omap2/twl-common.h:62: error: previous declaration of =E2=
=80=98omap_twl4030_audio_init=E2=80=99 was here
> make[1]: *** [arch/arm/mach-omap2/twl-common.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2

Applied, thanks.

--12mfjY/2IcLDkfPj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNkCmAAoJEFJkBDiqVpZ4b9YP/3Vkt1jQOL2oS8u5mObNoWKX
vi5naBhFSY70MMByAotV38KG/GQQjQOElTdzrr7yT+78q82PmKaHzAu8tGbUWbgV
9Opg56dboKHt+bXcjaVPvkb44omCQBPuuRY+kpH1QZN1DoQ+X/DvYe7nvaOJPIBq
rEcRmq8NrQHCmi995AZX8d4mDzkrCLRVaVM5Xok9Bno4Mej4Byvai/dIXRHA0++A
TieXvlyBlkD1V+xbLlWv/KlPC9fTW6oLmgwYmIcSu9Wenbm3pjeAscGNpIhMKLnZ
9uoDDjmZUxcy1EwF26NAcmWdjcvdcKavnh6vBxCSj5x24rqvbvVPw5qVSR/JyBYl
3QAxNvXCVebO03LZGftjBWxtQWftJA8nVBCORusFcKS4QH2VDYdw9MTSaIF7akHW
kHQn8hMSUj9i7o/ZfrnUuuSewQG4IlpMk+/X0fURT3yMquYg/gmLMpO5/MOimKSL
PJEE+1bCE3CfTzc8jReN7I9EnxZaBglh3yTWu+avJyr4ez56fqorUPE3US7HCvJ3
ayoBjMhWUp20VONBtYuc4A/NghrtI1VG1tGzSkcQaYHVWKu7n1Jpp/92NUW6qNuV
xMGfyRJhITZcs2q/xL/YInpa/yAAgVkQNSJSc89T2+bESSYlE5sS1uuSn+bI9Blw
PjpRwe/ua+B9qNucp1Q+
=RLTd
-----END PGP SIGNATURE-----

--12mfjY/2IcLDkfPj--

--===============8153577186576456791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8153577186576456791==--
