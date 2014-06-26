From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 4/7] OMAPDSS: DSS: init dss ports cleanly
Date: Thu, 26 Jun 2014 15:16:56 +0300
Message-ID: <53AC0F38.8060400@ti.com>
References: <1401096492-1405-1-git-send-email-archit@ti.com> <1401864063-19196-1-git-send-email-archit@ti.com> <1401864063-19196-5-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="6JuuIfmFePPJa5hIWGdraLE2Hssun9C7x"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60713 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932493AbaFZMQ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2014 08:16:59 -0400
In-Reply-To: <1401864063-19196-5-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

--6JuuIfmFePPJa5hIWGdraLE2Hssun9C7x
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/06/14 09:41, Archit Taneja wrote:
> The init/uninit port functions are used to set up the DPI and SDI outpu=
ts under
> the dss platform device. A 'reg' property is used to determine whether =
the node
> is DPI or SDI for OMAP34xx DSS revision. For other DSS revisions, only =
DPI
> output exists.
>=20
> For multiple DPI output instances(introduced in DRA7xx DSS), we would u=
se the
> 'reg' property in dts to specify the DPI output instance.
>=20
> The current functions work fine if there is only one DPI output instanc=
e in
> DSS. For multiple DPI instances, it would get complicated to figure out=
 whether
> 'reg' is used to specify whether the output is SDI, or another DPI inst=
ance.
>=20
> We create a list of port types supported for each DSS rev, with the ind=
ex of the
> port in the list matching the reg id. This allows us to have a more gen=
eric way
> to init/uninit ports within DSS, and support multiple DPI ports.
>=20
> Also, make the uninit_port functions iterative since we will have multi=
ple DPI
> ports to uninit in the future.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---

> +#ifdef CONFIG_OMAP2_DSS_DPI
>  int dpi_init_port(struct platform_device *pdev, struct device_node *po=
rt) __init;
>  void dpi_uninit_port(struct device_node *port) __exit;
> +#else
> +static inline int __init dpi_init_port(struct platform_device *pdev,
> +		struct device_node *port)
> +{
> +	WARN("%s: DPI not compiled in\n", __func__);
> +	return 0;
> +}

If I'm not mistaken, this, and the SDI one, will be called if the DT
data contains DPI/SDI port, but the DPI/SDI support is not compiled in.
I don't think that's a reason to give a warning, there's nothing wrong
with leaving the DPI/SDI support out.

 Tomi



--6JuuIfmFePPJa5hIWGdraLE2Hssun9C7x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTrA84AAoJEPo9qoy8lh71KqoQAIWhwH7PWUN2pQwyG209Heui
Lo2/JdrvJ2JgavnPK7WksOM9IU6r1b3EcBbiggY+05NeDw9WME3him8en9Z6akiT
L039sNtxOKI57AU8l7Et9gYGv/eR5zPxfWVWwnNLKqm4O3sNATiksQq3x8PHE5nS
L4sTw5pU7P1N45TWKAsHL+IF3P3NZQjpIxOrmHw91u2OU5I+S1fDNP6nuLf+Ems/
abeIxAJW1bh46wKOFBYU78IpsetgtGOJNcUGv0Ld4R4yCl378+eMUcm4HFfUsesZ
BADI92YVUueokEswregRKrvNn3JRISfUWJZEX5RqwVi5Oy/UciV7DV+9Yu3aSaJp
NQE6LVKcEMXZhfqQw9wAoQjl8g+AAptjhIfGsQLhi7V+4TaVVJQUPjfYaKjD0p6S
sgHXRi8Ix4qZa8/vkqmk4xOxDw3BZhvfreoGB1nGhbrHsI6Ueb2GD34p2xSOocOd
qaGEsSTYxO38Atlgcv++mUfX6jvVCGrS9Dyn4tDK+oUnw2ua0MqOKlf33yp3VIwm
21gMgqogxrYAZTSUc5UROE6DSbRk6OoMWon/KimIqUiKNG/CHRPzPU2zXZHk57CY
aQaZUjq2WiopmEsgWas6z8beYRZXMN1TGFlwTuhutc08Wg589L+x0s6RWftrIHiM
UUFO5IPu2yPIqV8452Fx
=xEPE
-----END PGP SIGNATURE-----

--6JuuIfmFePPJa5hIWGdraLE2Hssun9C7x--
