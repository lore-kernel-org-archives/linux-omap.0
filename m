From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/2] Fix omap serial early crash during hwmod _setup()
Date: Thu, 11 Jul 2013 16:28:18 +0300
Message-ID: <20130711132818.GE30970@arwen.pp.htv.fi>
References: <1373539986-27272-1-git-send-email-rnayak@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="47eKBCiAZYFK5l32"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51066 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab3GKN3G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jul 2013 09:29:06 -0400
Content-Disposition: inline
In-Reply-To: <1373539986-27272-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: tony@atomide.com, khilman@linaro.org, linux-omap@vger.kernel.org, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, mpfj-list@newflow.co.uk, sourav.poddar@ti.com, paul@pwsan.com, balbi@ti.com

--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2013 at 04:23:03PM +0530, Rajendra Nayak wrote:
> This series should fix the issue with the early serial crash seen
> during hwmod _setup() as reported by [1]
>=20
> The issue was reported on a am33xx device and was not seen on omap4
> or omap5 devices as the hwmod data for both omap4 and omap5 had
> statically defined HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET for
> uart3 which happens to be the debug console used on omap4 panda and
> omap5 uevm boards.
>=20
> The series reverts the patch which stubbed out omap_serial_early_init()
> for DT boot and gets rid of the static flags in omap4 and omap5 hwmod
> data.
>=20
> This series along with the patch posted by Felipe [2] should fix the
> issue reported by [1] completely and boot to prompt on a am33xx device
> with LL_DEBUG enabled.
>=20
> I have boot tested this series (along with [2]) on a omap4 panda es and
> a am335x boneblack.
>=20
> [1] http://comments.gmane.org/gmane.linux.ports.arm.omap/100628
>=20
> [2] http://marc.info/?l=3Dlinux-omap&m=3D137353783912736&w=3D2
>=20
> Rajendra Nayak (2):
>   Revert "ARM: OMAP2+: Fix serial init for device tree based booting"
>   ARM: OMAP4+: Get rid of the HWMOD_INIT_NO_IDLE and
>     HWMOD_INIT_NO_RESET flags for uart

boot tested on omap4-panda rev a3. Console still works and it suspends
and resumes fine after setting a proper timeout.

Tested-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR3rLyAAoJEIaOsuA1yqREqtMP/2ZMsg8NK+CpB5i48rkWT2Vk
0TBX9YGfybb58ju65lxvOpQst5JQNrKAtVYTywGAA0tg6Nhpb2q4bTamJo1bYubq
4A6WIAbLXkKMaRPu+FeaqWAj9wVqpRjl2FD1nCs7BkIkViES9P3lPbza5EkPh0GX
kwa7f/IOo+IuAaTI6S2zoczEswIOCcqZxpTjm86zoP6Glm29ZTBfwUB9CrNNmZtn
fCFr8ZQiIuS7osN96UOCH9eSqJQ8vXhQEzQVk5DDqb0CRC025FSmGNViLI05+T1J
pxiejkGqp4hvK+sb1WrnCAcXWsqLPpbcHKhsY1NjkP0aljeMl5Lvx/f8HlMjiJyJ
seiOA5pGT1XZF5s5dKppejpjT9o7yBYTFgQvCFpbu/Vh3BDaa9OU3FiAy50oT9FH
tw1iAV/pQHILbQUwF7K6cFwrQC0PqKQSgNLWMmZa96gkwInDNIeR0w9Ult/tnqL3
CdDOnTaW/sJdYfdC9PXYiHmgxsEGJzHNQ6PoKipUSUs5XuId12eDKp8s6ipVjdAW
VpaTUjfK9S8lpK0rLSp0eOzRDuCmM1FSIM8mhW7+F1pPxFNuPZOyxJSHqcCGYukS
7UfYdDWdIn2S7fvOD99o7aFjCXSb41pggffjio5rWQhn2nVlEoWB502ie2tXwrMM
s4E9yZyu+5Id8PMGWwQY
=0wJh
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--
