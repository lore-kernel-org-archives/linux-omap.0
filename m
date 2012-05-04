From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 24/25] OMAPDSS: DSI: improve DSI module id handling
Date: Fri, 04 May 2012 13:11:50 +0300
Message-ID: <1336126310.2701.31.camel@deskari>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
	  <1336053481-25433-25-git-send-email-tomi.valkeinen@ti.com>
	  <4FA39CBB.6010500@ti.com> <1336125229.2701.30.camel@deskari>
	 <4FA3A9E4.3040802@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-S0+foBYkKOAXmODd9moM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:43883 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753754Ab2EDKL4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 06:11:56 -0400
Received: by lagv3 with SMTP id v3so3476152lag.27
        for <linux-omap@vger.kernel.org>; Fri, 04 May 2012 03:11:52 -0700 (PDT)
In-Reply-To: <4FA3A9E4.3040802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-S0+foBYkKOAXmODd9moM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-05-04 at 15:35 +0530, Archit Taneja wrote:
> > This is only a problem with device tree, and I solved it so that I
> pass
> > a DSI module ID in the device tree data. So, with old pdata way I
> > initialize dsi->module_id from the pdev->id, but with DT I
> initialize
> > dsi->module_id from the DT data.
>=20
> Oh ok, so the code which decides how dsi->module_id is
> initialised(from=20
> DT or pdata) is not in this series right? And it would come later?
> Right=20
> now it's just set to dsidev->id in probe.
>=20
Yes, there's no DT code in this series, only cleanups to make adding DT
support easier.

 Tomi


--=-S0+foBYkKOAXmODd9moM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPo6tmAAoJEPo9qoy8lh71Wc4P/AmDlcUdgZ5hrwn4QC5F4XfU
9OhpJ/qsiMlfpWWwHYsKkddaCKRW2kWhqF3fqV2csltUKPoJWYW0EgpremsVNAIy
5swdhECgbRMphwPVWYg7oDbJrCSCRO9rvgEOCNH0hVhPh+AP+wyUSCUNqcKtgOi8
5Pga5SaWa859D6kv0OORilMtgeEXXz9ybyWU1W20M8PCEaL/zIT1AwCzSkyirOkD
bQXpW4kxeroKMZZeKbHB75ogHJ0KuWNnAdiTHSA/EIqcKjaSbvF0Dx7e2Ri7e/g3
VFYsG957/wuO8Ewt8g7vMhvwnJAQrRSOho2G4kd5cmbhKTBrA6C7Jfhk9aOC2BVI
bwCZfRMyBze6G4pnoYBV7Mb4+H7mcFLGpRdKIIFDDPg3IIFVMUYoLt+FWIXu0kr8
xMx8canHkgOfYhPU+Xla5toZj/+RAYKwcUsF0slEZpC5wPxDsp0JZ5ea1i5eL5ip
UrH5+GYX3hR4IMC7uozXaMbNnuxRfGR3DgEmDcUqRmdSgeO3j2/+5P3Pmi1/QZAi
hodhxqsWcQ/o2q1J8U871vdMbAv71frcRIHdGSGTAe7yIT1gg3jWW4u71CP/Uy/x
aH5veGTy5gxndVlFQOF9pADt1X1Ie4qPnWIrBD81YGwGtbJIrUCu8qUKT/erCL/m
CI+encCIrCHOXqIC4+Y1
=b9U6
-----END PGP SIGNATURE-----

--=-S0+foBYkKOAXmODd9moM--

