From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH 0/6] N900 DTS additions for 3.14
Date: Wed, 29 Jan 2014 16:03:28 +0100
Message-ID: <20140129150328.GA25527@earth.universe>
References: <1389475023-11616-1-git-send-email-sre@debian.org>
 <20140120155950.GB17118@earth.universe>
 <52DE612E.2080205@baylibre.com>
 <20140121132653.GA8964@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:53797 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888AbaA2PDc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Jan 2014 10:03:32 -0500
Content-Disposition: inline
In-Reply-To: <20140121132653.GA8964@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sat, Jan 11, 2014 at 10:16:57PM +0100, Sebastian Reichel wrote:
>Here are a couple of additions for the Nokia N900 Device Tree
>Source file. All related drivers changes are queued for 3.14
>(except for the tpa6130a2, which got merged into 3.13).
>
>I may have some more additions if the driver changes for the
>accelerometer, the touchscreen or the wireless lan chip will be
>queued up.

Ping. If I'm not mistaken the merge window will probably be closed
at the weekend (2014-01-19 + 2 weeks = 2014-02-02).

P.S.: Accelerometer, Touchscreen and WLAN driver changes haven't
made it into 3.14, so the patchset I mailed is complete.

-- Sebastian

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS6RhAAAoJENju1/PIO/qasEEP/AlS4l0x0H5B2sAHcn8zxtWI
XJVwyJUQUzlfwfJfjwPbWYfUZKi9TtCQbh5uWJR91UkKE+aUW41DD8ziG0Pt4Y1W
NriQIdxA/n5IO2M7fTRMQuO2iJLYOXeyN3dlHh1K6fzeKJGQAtiqNTVP9hyBOuhK
D1ToOKUI1WZQ0cMdFBRWrFWDBqFwgfy3ZR1W1Q2do1ehwJW+sqirpG4QAK0dsSfB
vEQnuUV9SjDFsvrLK56cUwCFU6a8IVj9RCwyjA4vpw/C5cnn6ODF2u4pOybLQHYa
e9GMZqaW2oSp6ntmOFncRW8HrZtJPBgjn39JvzZkZZSL12Bm5DNRAl/7uT+7SpbC
Q8HQXvUVr+qFzUygVvJdDqg0I73elEc7kOCXDZk1HgpoUZudfxf+e89+55pLtYLj
2UNSL7X8oJYXFOtX3CQMIlCdp2d8TICaCy10esnlOmnJUkVRVBncm+5bvJMtaSsA
L1dbrDCbk4J82cKH174Bev2qLEjc+yTazhhDJl/dOEBRAOuMPizSN9C77hh5qZAd
PPGk0zdVEm7W2wn1foMX0Me3+sSWUAEQ/RxKVGYuYxjDERtJ6/ZoTc5+6bPUI9Ub
R2d5bhBXnerIaVEOtg9YK8JSU9Lz0etxPJAT9Nd/S2mQPyJYQ9aZGDN2tKF3CN5h
6/NqCpNLL9sDCU02J16q
=IkPr
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
