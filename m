From: Felipe Balbi <balbi@ti.com>
Subject: Re: omap2430 regression due to "usb: musb: fix incorrect usage of
 resource pointer"
Date: Fri, 26 Jul 2013 13:20:08 +0300
Message-ID: <20130726102008.GE2970@radagast>
References: <20130726191445.1b2aaef7@notabene.brown>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yb+qhiCg54lqZFXW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54629 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983Ab3GZKUV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Jul 2013 06:20:21 -0400
Content-Disposition: inline
In-Reply-To: <20130726191445.1b2aaef7@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Felipe Balbi <balbi@ti.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>, linux-omap@vger.kernel.org

--Yb+qhiCg54lqZFXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2013 at 07:14:45PM +1000, NeilBrown wrote:
>=20
> Hi,
>  the commit:
>=20
> commit 09fc7d22b024692b2fe8a943b246de1af307132b
> Author: Felipe Balbi <balbi@ti.com>
> Date:   Wed Apr 24 17:21:42 2013 +0300
>=20
>     usb: musb: fix incorrect usage of resource pointer
>    =20
>     We can't simply pass the resource pointer from our
>     device down to our children, otherwise module
>     reinsertion will not work as the resource will
>     continue to be marked as busy.
>    =20
>     Fix it by building a proper struct resource for
>     our child musb device.
> =20
>=20
> (even with the subsequent compile fix applied) breaks my USB-OTG port on =
my
> GTA04.
>=20
> I must admit that I don't see the point of the patch at all.
> Instead of passing one array to platform_device_add_resources()
> which will copy it into malloced space, it copies bits of the array onto
> the stack on passes that for platform_device_add_resources to copy.
> What is the value of the second copy??

if you don't do that, the resource will already be busy and ioremap will
fail on second modprobe.

> But that isn't the real problem.  The real problem is that in omap2430_pr=
obe,
> on my board at least, pdev->num_resources =3D=3D 3.  But only the first 2=
 entries
> in the array are copied.
>=20
> If I make the array one entry larger and copy the extra entry it works.  =
Of
> course that might break for someone else who only has 2 resources to copy=
=2E...
>=20
> Can we go back to just leaving it to platform_device_add_resources to do =
the
> copying it have I missed something?  (I can't see where the new old code
> would mark something as 'busy' that the new code won't mark as busy...)

patches already in Greg's queue

--=20
balbi

--Yb+qhiCg54lqZFXW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR8k1YAAoJEIaOsuA1yqREeC8P/0offQa8wYuJJZAcn8+hxk0R
tDNJBFg+NzK2PhIHGHSL1srWiq3DhuPE5KJcMcb7J/JyWJlBGDKs/ShqzDAxLLf7
fYyX1lnoZdAw9c2qD2oKzKNZGQJs+Zf/hOHGJgsOXYniwlA+5AeBcG5GcHddRzMB
i1GXkyGqiU8R78SpBgyHNlRVDCWDJUoOrHto741VXkqpICmFxUOFGoqUrGsvnSYK
PmdoEqyEIOO56CpLJEMwDEYLFtdqC30CManRU9BTWhiH6rHW9t19H39q2LjVIrV1
hTBTSGkO2zoK0pFVjdCHn05JVODF+71cA3OQLETsA2VuTKsZ80dssTS42w12/RnU
ynj/LuDK//r5KVMkGS5zwjFZppxiOt1fItt9nrxwsduHcEUlJ/mm1j3NyxSizFg1
6jeITPycf7qD0tp2Wc9mlGR54RbzCnM4oKPspeJt+9Z/S1hIXY7ySpxOzytLhkY4
9VwGYaJZK+REeK3ujLLhT1Gq1F02FlPxvQc16I657dQQdWZ1W1jDo4/ObUIsKOms
Jlow1t0+f1HUFNU4Xmkj+YEJ4oQr4Ibz+dDjykHwL7ftf5j8WsvQ9oDDfv/7uYFD
zu8f4ski40jBix9wObUO7O2g6PYgAhM4xS9vzokJtybRLa33IRNM7zpwmj9haf83
JmL9Ri1znCh33lZkfwfh
=4KPN
-----END PGP SIGNATURE-----

--Yb+qhiCg54lqZFXW--
