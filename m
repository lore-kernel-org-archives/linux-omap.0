From: Felipe Balbi <balbi@ti.com>
Subject: Re: [balbi-usb:i2c-transferred-bytes-on-NACK 7/9]
 drivers/media/i2c/adv7604.c:406:9: warning: initialization makes integer
 from pointer without a cast
Date: Wed, 24 Oct 2012 16:36:08 +0300
Message-ID: <20121024133608.GE21735@arwen.pp.htv.fi>
References: <5087e56f.wwcO2kZCKDOco89b%fengguang.wu@intel.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WK3l2KTTmXPVedZ6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46064 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934752Ab2JXNlv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Oct 2012 09:41:51 -0400
Content-Disposition: inline
In-Reply-To: <5087e56f.wwcO2kZCKDOco89b%fengguang.wu@intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

--WK3l2KTTmXPVedZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 24, 2012 at 08:56:15PM +0800, Fengguang Wu wrote:
> Hi Shubhrajyoti,
>=20
> FYI, there are new compile warnings show up in
>=20
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git i2c-t=
ransferred-bytes-on-NACK

can you *not* test this branch ? Specially since it has nothing to do
with USB. I just used kernel.org to backup those patches for me :-)

Besides, I already got a report related to this and the fixes are just
waiting to be sent to mainline :-)

cheers

ps: thanks for the great work guys.

--=20
balbi

--WK3l2KTTmXPVedZ6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQh+7IAAoJEIaOsuA1yqREgucP/38Y+CMA/MB2eo7blcQ3rwpy
rwXjclnymCIIWeimn9Rl68oEDRFxCWpJ750zvvkZsbuyJ41C3YOq7VuZKXdnLlPi
QpZ+SPKEBUGqBVnXgLJve2WCBCM+qwxSLIXdgx7SkKBo7pMW6yrORF+Ho/Jkq+0l
jbYyU2c4pgXnyuHtdzYuSqUrE9wcgV6p29lnFXQX7oINkewYTjQ3igcyHUyaJiCH
WzUFerx2JY93ruVV73tTqWMwg+zH7rvu8s+BLJU24SiRq2E3uuTy44jki0YoOsoh
GZeuImWEXLcTiJjf7vFI+zdH6W2rcEgGAWoZlVdDmxFlxbnLUfeoG0b/q070Z1GN
gqgpQePx6/Tr7qwwfB856tj5hL7wI0Ltl2nygNDDXodUF2T0aEFgcg39XaadmlzY
KvOlJsTTB0nGQBRrwrxOiqAbGlbZOy3eVSNmTWX5ALYtfLakVs+po7m+ES0Kw3tD
Ih8Nt4XEZ3UDj2AiaSue4DGmW1Ikp+814/iDNXErWXRG6wDQh1rsQFw/YBS3b33x
V8/8rmHMIcYyRqdnIqeKDh1jTmP8vAGMCn5Twt8kFViw/cmaiwM3U7JNXUhqGnNU
W109zyrhfxuwSzijbLissHi/r3c+LRgLGv4lkM4AnVYboRh5CQWNsdAcRY0pVUpM
xTZjJtOVCvKnq8S3xYyl
=fwyV
-----END PGP SIGNATURE-----

--WK3l2KTTmXPVedZ6--
