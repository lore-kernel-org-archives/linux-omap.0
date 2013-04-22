From: Felipe Balbi <balbi@ti.com>
Subject: Re: Multiple issues with omap4 panda es in linux next
Date: Mon, 22 Apr 2013 10:49:31 +0300
Message-ID: <20130422074931.GH10536@arwen.pp.htv.fi>
References: <20130419171318.GK10155@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzX0AQGjRQPusK/O"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47246 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754645Ab3DVHuC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Apr 2013 03:50:02 -0400
Content-Disposition: inline
In-Reply-To: <20130419171318.GK10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Luciano Coelho <coelho@ti.com>, Roger Quadros <rogerq@ti.com>, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Ravi Babu <ravibabu@ti.com>, Ruslan Bilovol <ruslan.bilovol@ti.com>

--NzX0AQGjRQPusK/O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 19, 2013 at 10:13:19AM -0700, Tony Lindgren wrote:
> 2. MUSB fails with legacy booting and DT on panda es
>=20
> With both legacy and DT booting I get something like:
>=20
> HS USB OTG: no transceiver configured
> musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status -517

well, enable a transceiver :-p

--=20
balbi

--NzX0AQGjRQPusK/O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRdOuLAAoJEIaOsuA1yqRESuYP/3bAmMlFl20JMRqhVZn8KdTB
EtIy/K8xU8aGQTaxNOSDm5U/4YdisDkfiJkTcsJ1y4kAPITpf4cZjVZKKPdLbF6u
wlSh7fkV6oKYxSoq4bWctA+KjdjcFZxCpRD/qcf7kS/b/RKvNQ8jfTM4Vr6WOEP2
VJcELYHlWlFyzAk92fxV0njaN2/a3ZfzgIv/i7mwmKgxYp84H7tV8CEcbgYQqww7
MhRk1YjkjxskFWLhgb7TgzC6MQJWELnUazd6Tl1z4hF+sHtBRTOuSSHMuy8R+i/f
T/0uJ0kI2kJ0hYPMM04GUNXyzxma4O7sR7l4D6AMopBtO7X78XPdAW/gjrgqs6e1
XzY0T4zvI3+S+nn8P9J6kvCGlqp557snPotG1JFdHpH4opij4Oe1abyjdv+vplWU
I5R9+5p9ResLwpwM/FahmsTQVPA0ZWToqoYcIHu4jzYia09RgG5L26Jfnu6Bw4lj
Dxf1oxvovBYlXDNxQy0rpwd2vACeDgTX0Gux8fq4oq7dkSz82OBKYFTIdks/RJ6e
i52dumZ6ZMvso2QuetyiAeIhumEBd2ULWCqrxMXJDxzcdC/z9JhKvXJX5qQ2lURt
yvbPyN1jbTvH1zKjCvtPfO2J81EtlrZFdMJk4MH/r7oIA/pETAH/VX6f8//tTHKu
/ZSXbkGbXOwUcRXSCibp
=zICf
-----END PGP SIGNATURE-----

--NzX0AQGjRQPusK/O--
