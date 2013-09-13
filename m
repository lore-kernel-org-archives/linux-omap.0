From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/4] arm: omap: display: Create omapdrm inside omap_display_init
Date: Fri, 13 Sep 2013 13:24:34 +0300
Message-ID: <5232E7E2.7050606@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com> <1379063679-4869-2-git-send-email-archit@ti.com> <5232D9C8.9020809@ti.com> <5232DCFE.5050700@ti.com> <5232DD53.3010706@ti.com> <5232DF61.6000109@ti.com> <5232E00E.9040400@ti.com> <5232E2A8.10409@ti.com> <5232E63E.9020804@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="AMvBR26jA79qW5tnMXlOdtu1Nv7jx5SEc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43228 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754767Ab3IMKYi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Sep 2013 06:24:38 -0400
In-Reply-To: <5232E63E.9020804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, robdclark@gmail.com, devicetree@vger.kernel.org, Andy Gross <andygro@gmail.com>

--AMvBR26jA79qW5tnMXlOdtu1Nv7jx5SEc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/09/13 13:17, Archit Taneja wrote:
> On Friday 13 September 2013 03:32 PM, Tomi Valkeinen wrote:
>> On 13/09/13 12:51, Archit Taneja wrote:
>>
>>> The calls in omap_generic_init() check the machine type via
>>> of_machine_is_compatible(), even if it's a multiplatform image, the d=
tb
>>> should be only of one platform. So it wouldn't be called at all.
>>
>> Hmm. BeagleBone is "ti,am33xx". The "Generic AM33XX (Flattened Device
>> Tree)" machine definition uses omap_generic_init(). So if I'm not
>> missing something here, omap_generic_init() is called for BeagleBone.
>=20
> I was talking about the calls within omap_generic_init() :
>=20
> omap_generic_init(void)
> {
>     ...
>     if (of_machine_is_compatible("ti,omap4-panda")) {
>         omap4_panda_display_init_of();
>         legacy_init_ehci_clk("auxclk3_ck");
>=20
>     }
> }
>=20
> omap4_panda_display_init_of() would be called only if a panda board dtb=

> was used. Are you talking about these display calls, or something else?=


Ah, right. I was looking at the DSS DT branch. There we have
omapdss_init_of() call from omap_generic_init(). So that is a problem,
but not in the mainline.

You're right, the current mainline doesn't call the DSS init function on
am33xx. But it does create omapfb and omapdrm devices, as you noted.

Well, those devices don't do any actual harm, but I agree that they
shouldn't be there. It's probably best to move the device creation into
display.c, as you did. Just include omapfb also, and maybe remove the
DMM creation as a first patch.

 Tomi



--AMvBR26jA79qW5tnMXlOdtu1Nv7jx5SEc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSMufiAAoJEPo9qoy8lh71yPoP/A8cCcxEGTuKW5io7r9Kevot
5C7tZW7UUTXsqWIcCuwIp9Tvb1WbG8PBsw0uik6IVhUBRT5hbvDxb/cNdQrkQnHT
4koQxoirim2RE3cmY/RElLy3mkceM7pt1/+lkogxXYM1wo2AL8k8EC2YNvzBk/xe
sOqEstiRmEEIvjrJZ/dXbIbNtBuFaIRZJN8hbGeTCEqnk8keX8Sb6KwQ3J1mJaTe
g5ke2CyJqGjDIHtIvV+kl4kZNBswiugwRfupAW5cw9Ku05yVOVfxdLC7Q3vM1r9f
/y5EaK3LE6/SbdR+bmfSNO003pdGDorSqOAZyxV2AgJ38oMj/XHpeU9SGaArVYxY
0jCh2Ip1mhtipu0H7+mZv+ikCX61XGShWfy6HUK1HZIu+zOU73gmkpFDhUi6JQA4
Q435o1xMTvL3YD/ldqfLBhSwWO9MEp9ikDGRar624W69tomBQ8d/A/TYfYltKbpy
Ay6i+KxB2T+K1n8R1cjFXdMQugVkkV/Ac3i96Kns42d8wMEkSdZ4wUZ6C+nBlwmq
LxYBwn4MoqRlzqgybFaoZMq1CqC+IvcSjQQkSudq7C5gpmVgQGmghijUlM0eTqPC
Fp4aTgZJ5CvsMSvuN+Nu6U5CaUoYI1fGFhwfcyN6gIJY4kcXwjPXGm180Pr7Yj0q
JnvLXwHJ8Z/ACy3JJSgt
=be3n
-----END PGP SIGNATURE-----

--AMvBR26jA79qW5tnMXlOdtu1Nv7jx5SEc--
