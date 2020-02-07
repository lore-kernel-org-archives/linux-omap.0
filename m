From: Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: Nokia N900 on 5.4 and 5.5
Date: Fri, 7 Feb 2020 17:48:00 +0100
Message-ID: <da14d6bb-f241-2dd4-8e94-886217a40ed7@wizzup.org>
References: <79b91017-b52a-8aff-4b9c-913ae655f7bf@wizzup.org>
 <185CD173-C13C-4D56-B3DE-9A8D7784963C@goldelico.com>
 <20200207163623.GA64767@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CcysjkJIKAfYQvmSBLK7sfhhhx6TCpuTD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from a80-127-99-228.adsl.xs4all.nl ([80.127.99.228]:33768 "EHLO
        hetgrotebos.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726874AbgBGQrL (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 7 Feb 2020 11:47:11 -0500
In-Reply-To: <20200207163623.GA64767@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kees Cook <keescook@chromium.org>, Nicolas Pitre <nico@fluxnic.net>, Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, "Arthur D." <spinal.by@gmail.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CcysjkJIKAfYQvmSBLK7sfhhhx6TCpuTD
Content-Type: multipart/mixed; boundary="7b9zVA0EQZJSiek98bzU9TIp1ZvGA8Ckq"

--7b9zVA0EQZJSiek98bzU9TIp1ZvGA8Ckq
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 07/02/2020 17:36, Tony Lindgren wrote:
>=20
> Looks like there's a regression in general for appended dtb booting tha=
t
> was caused by commit 9f671e58159a ("security: Create "kernel hardening"=

> config area"). With that change we now get STACKPROTECTOR_PER_TASK
> selected by default with Kconfig.
>=20
> Merlijn, care to try to disable STACKPROTECTOR_PER_TASK in your
> .config to see if that helps?

Yes, this makes the kernel boot.

Cheers,
Merlijn


--7b9zVA0EQZJSiek98bzU9TIp1ZvGA8Ckq--

--CcysjkJIKAfYQvmSBLK7sfhhhx6TCpuTD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCXj2UwAAKCRAGN09rynK8
WhLdAQDVsEenlBecHkjL6TQOt3ECsZhffueLvIMrj2pDuHxC5QEAtGLVgfx7ao9c
MvWnlbL6dRENEtCs0u2fwShOB12gfQE=
=uQe8
-----END PGP SIGNATURE-----

--CcysjkJIKAfYQvmSBLK7sfhhhx6TCpuTD--
