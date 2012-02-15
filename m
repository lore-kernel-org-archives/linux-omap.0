From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: HACK: Ensure DSS clock domain gets out of
 idle when HDMI is enabled
Date: Wed, 15 Feb 2012 14:51:57 +0200
Message-ID: <1329310317.1892.60.camel@deskari>
References: <1328854552-30714-1-git-send-email-archit@ti.com>
	 <1329220678.1845.68.camel@deskari>  <4F3A5A5D.4020906@ti.com>
	 <1329225311.1845.109.camel@deskari> <4F3A61EF.4030803@ti.com>
	 <4F3A809E.3070508@ti.com> <4F3B9E8F.1020002@ti.com> <4F3BA6A2.60604@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-OhWczY3OnVcl7+s59Wul"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:58889 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754807Ab2BOMwD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 07:52:03 -0500
In-Reply-To: <4F3BA6A2.60604@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-fbdev@vger.kernel.org


--=-OhWczY3OnVcl7+s59Wul
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-02-15 at 13:35 +0100, Cousson, Benoit wrote:

> I think that changing the device creation to change the dev->parent=20
> should be pretty straightforward.

That's not possible with the current kernel, right?

We are now using omap_device_build() (in arch/arm/mach-omap2/display.c)
to build the dss devices. Looking at the omap_device.c, the parent will
always forcibly set to omap_device_parent. It'd be nice to be able to
construct the device child-parent relationship the same way with both DT
and non-DT cases.

Or can I create only the dss_core with omap_device_build(), and create
the rest normally with platform device functions, and make dss_core the
parent of the rest? But are the hwmods then handled correctly?

 Tomi


--=-OhWczY3OnVcl7+s59Wul
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPO6ptAAoJEPo9qoy8lh71QcEP/0YbsHMjCuEawnj16uxcL3cr
Uj5kfgbYoL/qmzirRndZGOlAOFRydB7US5GXmIZ3jRbwMVa2OtjPeBzfBilivuzP
D4xfpqr/0zqQ505C1KA4rkoho8S03ScODogbH/NYRTowTkro7JuD4B/LGxWgAnbW
59/VNfni8acByv6Qi+pkUBDTfzaMzwOOjh334UuXjVHx2ONcWVaDWqcD8IeZYgTP
/jMbYaKvkeLpGbKz24r8y/hu5gfq7RjZW6Q+kYxq7dkC0IMjPCpO3YnJjxZ+kAAf
/Vrr9Kql4nGCPhR6J4rJYKRUprOPMWlzdjZo9XkqC2s6JEkL/vqwINM6e6T7BAik
+LpTIZxe9IOz/9bFmDDCVE5t0YyTxj+KjKXM1AKtUcXdqfM7dM5JQbl1GjB6gQuN
x5vGW3CuVhGb5ic31Olr823kvBmeiZJNdCCamQrMAda/Mc9tSevu9FDuF3nEVohj
TuJx6ibZv0PzZczV3rsM9wwbdtD4yyzB0Ua0x2yyUo02AtDq2gO3fuJtqH5OAHM0
GZxnwNo7dNRkruwhAXw4JO2M8f14aN1c9Bmg+3mW/4OYM8q9nDR1V1XOx9+HvwRc
jLSplGTGUQ0sdkAL+67JYv72iZR6Yzr5g2EQ8O4uS5rf4ONWfz6LBf9MlTIkD/3k
sLrj4fofpf83S6V55oPt
=xiFZ
-----END PGP SIGNATURE-----

--=-OhWczY3OnVcl7+s59Wul--

