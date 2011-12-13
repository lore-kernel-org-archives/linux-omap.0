From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Trying to boot Panda with DT
Date: Tue, 13 Dec 2011 15:24:38 +0200
Message-ID: <1323782678.1877.77.camel@deskari>
References: <1323781385.1877.75.camel@deskari>  <4EE750FE.5040302@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-hhePQA2XhfYY0pMGZV+q"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:51597 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750942Ab1LMNYm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 08:24:42 -0500
Received: by mail-lpp01m010-f44.google.com with SMTP id h2so1830938laa.31
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 05:24:41 -0800 (PST)
In-Reply-To: <4EE750FE.5040302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, linux-omap mailing list <linux-omap@vger.kernel.org>


--=-hhePQA2XhfYY0pMGZV+q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-12-13 at 18:49 +0530, Rajendra Nayak wrote:
> On Tuesday 13 December 2011 06:33 PM, Tomi Valkeinen wrote:
> > Hi,
> >
> > I'm trying to boot Pandaboard ES with DT, but failing. I've debugged th=
e
> > problem enough to see that the bootloader properly loads the DT blob,
> > and passes it to the kernel, but the kernel sees only garbage at that
> > address, and the devtree->magic check fails in setup_machine_fdt(). I
> > presume something overwrites it.
> >
> > I'm using Pandaboard ES (so omap 4460), Benoit's
> > "for_3.3/1_omap_dt_i2c_twl_test" branch, u-boot from Linaro
> > (git://git.linaro.org/boot/u-boot-linaro-stable.git master). My u-boot
>=20
> I used the u-boot from here and it worked fine for me, not sure if its
> any different.
> git://git.secretlab.ca/git/u-boot devicetree/linaro-stable

That tree looks quite different than the linaro's one. But appending the
DT blob to the uImage seems to work fine for me, so I'll take that to
use.

 Tomi


--=-hhePQA2XhfYY0pMGZV+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO51IWAAoJEPo9qoy8lh71kqAP/jNpLm3CSbbyZeCU4oYxQZ8+
9Ds8endL2oXVjZbjpUGjMbSOafWMWE7LjCMp7nNKFmTo1PC65JGmCtqCCN2xR+6A
H4PSdm4EE4pdd6JMskK9mde/MKlNzZkoWu1IY7DCU/IS8P1s6RK9mksWQMN3vgSu
bNdbJLXBTj71NhQLVSJoxa3oTrZVExfGKetahykKRRLP0rqQdxO+sVkP5MJ0+k3k
kpYbhiydrUUGRpVUchJsPTRiMPTNxP0Jtw2yx/moLFjdDaipSk1+QWEIf2HqcfYU
pevzlwfbcZBcGRqyFIj7c/6gaNPSYrVklmdT20dEk8IGihAHkDjCpPvk7GxzzA8M
w+VkJ46gbVbqTpQWE6a8iRgcKoea+66Q6kU09KOZYqiE11hcZxQ5ZFLVzAKrF2Fo
aX4labxNEHcMB7F19ZkEVgW4xUgkbH3q524CqfA/PxgWo6TREh4OQ+qFqBCvaH9u
fxTKevA3qxmf7qI3Wpw/tfAwRl2Lr4g6nnoBRkFLDrELY/qBaRuurGTcNqJ6JRTt
WrHn/l713u0dPs6C25xJBIQlLVdrVs3vdnQNxUooeCd0BuNRW5J4+aSo/VsIihZ/
Dlp+qnyusVRfCkJhd6Z6bl2rZNiRvKmK1CwwvSgpeLhCoDdQck0CbaZwcAlTF/Ta
54zHmjCrvIVwIB/bB6/v
=O/9x
-----END PGP SIGNATURE-----

--=-hhePQA2XhfYY0pMGZV+q--

