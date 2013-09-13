From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/4] arm: omap: display: Create omapdrm inside omap_display_init
Date: Fri, 13 Sep 2013 13:02:16 +0300
Message-ID: <5232E2A8.10409@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com> <1379063679-4869-2-git-send-email-archit@ti.com> <5232D9C8.9020809@ti.com> <5232DCFE.5050700@ti.com> <5232DD53.3010706@ti.com> <5232DF61.6000109@ti.com> <5232E00E.9040400@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="WFp2m7KW5eGtKLN6DgsGg6l95vMOxvRbF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56109 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755176Ab3IMKCU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Sep 2013 06:02:20 -0400
In-Reply-To: <5232E00E.9040400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, robdclark@gmail.com, devicetree@vger.kernel.org, Andy Gross <andygro@gmail.com>

--WFp2m7KW5eGtKLN6DgsGg6l95vMOxvRbF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/09/13 12:51, Archit Taneja wrote:

> The calls in omap_generic_init() check the machine type via
> of_machine_is_compatible(), even if it's a multiplatform image, the dtb=

> should be only of one platform. So it wouldn't be called at all.

Hmm. BeagleBone is "ti,am33xx". The "Generic AM33XX (Flattened Device
Tree)" machine definition uses omap_generic_init(). So if I'm not
missing something here, omap_generic_init() is called for BeagleBone.

 Tomi



--WFp2m7KW5eGtKLN6DgsGg6l95vMOxvRbF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSMuKoAAoJEPo9qoy8lh718d0P/RZD+bkCt5k5RSb1Ji9KlPYf
ltTn1FLncxWQ+dNFbrVI4RMN0SBvM93UC+QK4I6y4jOyxEZ4xUI6x89bKQY8k2V1
hsJY1nt5jvc+6vYukTZFxe1Oci7GA1ZiTY0oN5Nw1iu/PXvfYjPXukgRHMfRlc2U
/a232Aq4wkPqTfR7qE1+ygeleKO8tvtLhpHyE7r6L06PYn7Grqz/bK+ihxEOTpN0
Zb9efmuWDP8WkCpv0Ax1aUJkZFc1TAbVt2oAuz7Sokv3odeDij6hCobUK+F7VNfL
eqIgU+nxXt6XRYckp2YQy+gdPRaxaDKlphYWtkjkFKiE69A5lhNc5pRXfHrjyfEp
6yP6EVTLolAHXHt6jU/3sH0hRqglgTUCrQXkYzjevcWt+PWBfsXlgqw12+tSple/
9LuwLJBbgoiopRpSMgODf/fVg6dCg56p3xzdmlohEyG5Rr9HmqrAHQHsKnfdUsuU
zVhJVPAikJkdKTw0j2S8yjE271Y00aBLKtYOOXa0MFD7BHhi9QsGUZUr9l8wbDK8
MYiubK2TImSFIFEpRt3n0sOs8+vqVZw0affv+oZS2vz0nLt5b8AcE6NczC6ZQOM5
GVr56OVpi6WFR7Fq8A5HlP2Jzua7Y60t84H2XPCb1yNq2E5S72eSxwUb9kiTXZAg
gkdX4X4Rj7kC6RgHp4z3
=BqQo
-----END PGP SIGNATURE-----

--WFp2m7KW5eGtKLN6DgsGg6l95vMOxvRbF--
