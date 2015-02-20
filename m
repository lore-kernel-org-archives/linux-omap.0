From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 9/9] RFC: ARM: DRA7: enable DSS_DESHDCP_CLKEN
Date: Fri, 20 Feb 2015 13:46:42 +0200
Message-ID: <54E71EA2.3030803@ti.com>
References: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>	<1423840286-18377-10-git-send-email-tomi.valkeinen@ti.com> <CAGo_u6p89ot-eNwK65otoYsLM6NXeh929=SBG6uKAsX8Tnd_RQ@mail.gmail.com> <54DE1B7E.10505@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="AMA3f9FWndenupEW0nbUXnWfuBrADVUOi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49022 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbbBTLrL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2015 06:47:11 -0500
In-Reply-To: <54DE1B7E.10505@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

--AMA3f9FWndenupEW0nbUXnWfuBrADVUOi
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13/02/15 17:42, Tero Kristo wrote:
> On 02/13/2015 05:25 PM, Nishanth Menon wrote:

>> I would probably wait for control module to become syscon and probably=

>> model this as syscon clk - I thin we should be seeing a series
>> sometime soon.
>=20
> Yeah, I will be posting a series in a bit, just running some final test=
s
> on it.

I did the above with Tero's series. Adding the DES HDCP clock works ok.

However, I'm not able to do this in HWMOD framework. To enable the DSS
IP block I need to enable both the DSS func clock and the DES HDCP
clock, but the HWMOD framework only allows one mainclock.

I added the HDCP clock as an opt clock, but those are not enabled
intially by the HWMOD framework, and the call in omap_hwmod.c:_enable()
to soc_ops.wait_target_ready(oh) calls fails.

So... Any ideas how to proceed?

 Tomi



--AMA3f9FWndenupEW0nbUXnWfuBrADVUOi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU5x6iAAoJEPo9qoy8lh71WVYP/2du6S0wjG5xOR7Eo7kE0/lY
1AUmqn7IVl554X3BJB8yqkhZNm5vSOZquE5Pisl2RBEC6R1H3SWGJlaIbfThI8GC
DFp5LM7eVDCzVfGrSPbdeFl4AyhxqdMdn9MUz9wQIG3PptVrUevFQSg3IF98CBn1
LV06Rt3nlliJ7V0zcgQdk/KE0CKIBfBKZ+X24CHS3juiKdbwTk2b4bztZDFKUdLW
u7MaWrYc2iO7/nQ6YtfMscjF2qum7BlLaLTrst6a+lQIU3lrvKO7twHsP3VFRSep
BPVRO0ZyZG2Pz7acO3YxmhXh1KUFVOYNEbnUvt52PTHifO5lRTy9zwKLt0ZbGSzO
QR6ADnajxNkceTE6Xcr7f/r7E4QJrfMNC9iolAwIccY7SomARTZyrxnLU+hMFJBi
HWwILT1e/gqXZdtCZ7ZY2iVpd8F8+CTlxueiA0MFvUXy2bn41xtlfqkTsYpTKqpJ
+D+FS0zTrbyCeJs6TFI8TfwuxJ7k5Lut+ikLF4AZcVel6AWfU4lWciHAqJ62BRf/
zXL1kH+3Zjj8zakI3gmsaLUMgg+MPlESu4Rq9erdNgUTjvHSMVHyXU+Kqx8TNz6H
tyXfHr4vM0hdhOqi7qya/w5cDPibjxsmPIuV+pyGMYexgV8m1We8dgxrynYTljNv
3K0hEzx83ePoObklay9r
=C2+C
-----END PGP SIGNATURE-----

--AMA3f9FWndenupEW0nbUXnWfuBrADVUOi--
