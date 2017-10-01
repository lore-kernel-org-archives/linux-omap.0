From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH 1/7] dt-bindings: bus: Minimal TI sysc interconnect
 target module binding
Date: Sun, 1 Oct 2017 15:11:52 +0200
Message-ID: <20171001131151.loanjnvarkihbhik@earth>
References: <20170929223411.9691-1-tony@atomide.com>
 <20170929223411.9691-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2133110773349224471=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170929223411.9691-2-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Sakari Ailus <sakari.ailus@iki.fi>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============2133110773349224471==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hgrfrvn44kd4ggkr"
Content-Disposition: inline


--hgrfrvn44kd4ggkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 29, 2017 at 03:34:05PM -0700, Tony Lindgren wrote:
> With the recently introduced omap clkctrl module binding, we can start
> moving omap hwmod data to device tree and drivers from arch/arm/mach-omap=
2.
>=20
> To start doing this, let's introduce a device tree binding for TI
> sysc interconnect target module hardware. The sysc manages module clocks,
> idlemodes and interconnect level resets. Each interconnect target module
> can have one or more child devices connected to it.
>=20
> TI sysc interconnect target module hardware is independent of the
> interconnect. It is used at least with TI L3 interconnect (Arteris NoC)
> and TI L4 interconnect (Sonics s3220). The sysc is mostly used for
> interaction between module and PRCM. It participates in the OCP Disconnect
> Protocol but other than that is mostly indepenent of the interconnect.
>=20
> As all the features may not be supported for a given sysc module, we
> need to use device tree configuration for the revision of the interconnect
> target module.
>=20
> Note that the interconnect target module control registers are always
> sprinked at varying locations in the unused address space of the first
> child device IP block. To avoid device tree reg conflicts, the sysc device
> provides ranges for it's children.
>=20
> For a non-intrusive transition from static hwmod data to using device
> tree defined TI interconnect target module binding, we can keep things
> working with static hwmod data if device tree property "ti,hwmods" is
> specified for the the interconnect target module.
>=20
> Note that additional properties for sysc capabilities will be added
> later on. For now, we can already use this binding for interconnect
> target modules that do not have any child device drivers available.
> This allows us to idle the unused interconnect target modules during
> init without the need for legacy hwmod platform data for doing it.

DT backwards compatibility is about booting an old DT file with a
newer kernel. Since old DT file does not contain a "ti,sysc-omap*"
node you don't need to add "ti,hwmod =3D *" support to it. Instead a
DT file, that uses ti,hwmod in the device node and does not have a
"ti,sysc-omap*" at all should still work.

IMHO we should break DT ABI for OMAP at some point, so that we can
get rid of the hwmod database. My suggestion would be, that
simple-bus checks if any child device is !=3D "ti,omap-sysc*" and
does panic("please update DT!").

-- Sebastian

--hgrfrvn44kd4ggkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnQ6ZQACgkQ2O7X88g7
+prHiw//YSsx0mNysbLBMjTXKRwW27pjGwb5fI1qAcYVArG8nBw26M2Wc9UH3G0l
+XWsSQpNMwaZD7t2Z/AuiyG+E5LoN8vqsikFDXSU0CDVVMovZga/FMtFGUZejt/G
SBd3ofW+Ti8WCUjKCKQ8PwTskXrsKezusx5J3EEf5+xnmgqqSKzdup7PJN7UkTR1
uTcd6SzrHuDiApWk8rVkN92bkTQvNpBOFhQNZx1Vp7mHqAuSyspqpG48/ReLjFPC
O82GCztCBl+AQGfBR++xTkVctpz4ADKGJItoKHIqDKiPX2nnYBdlMERvolIAtFZj
CyWdN2MMBJ3yeVWMPhOH5Utm+Ax2Y7PSdYfw1jiO8PIg0FEAdA91oJbdhJwACZiz
jc0jCo0LCYj3UR+u/HUHJnE673DAkTyx+ccN7bZbMX8+q70ZcHNN1CPZB2hRzmgJ
Nl69xze8zkfsb+K2OO9aZjJOzeNDn0QvpdUxfrC7ZbJWKKEs5j+iCoi3zm1AOL9c
gF1LzzQZ6d3M0Q2PNFYQb45cm17b6SQwF4KSUECbA9OsgB5UHQ25nvnnAslU7U4/
vw/ENSDGoqsvwRcS0ovtxlmRL4nLX+O4XEVPdNFsW7u1BAtP9HrfdTWUF77fwwNM
x3EONwg/1OaskBMITmpodmCl+WriZcd0p+tqhkYcHcavyBga25E=
=2qMU
-----END PGP SIGNATURE-----

--hgrfrvn44kd4ggkr--


--===============2133110773349224471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2133110773349224471==--
