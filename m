From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH v5 00/12] Support for AM33xx PWM Subsystem
Date: Wed, 28 Nov 2012 15:21:01 +0100
Message-ID: <20121128142101.GB21042@avionic-0098.adnet.avionic-design.de>
References: <1354006097-25895-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1354006097-25895-1-git-send-email-avinashphilip@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Philip, Avinash" <avinashphilip@ti.com>
Cc: paul@pwsan.com, tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, hvaibhav@ti.com, anilkumar@ti.com, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, gururaja.hebbar@ti.com, vaibhav.bedia@ti.com
List-Id: linux-omap@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2012 at 02:18:05PM +0530, Philip, Avinash wrote:
> In AM33xx PWM sub modules like ECAP, EHRPWM & EQEP are  integrated to
> PWM subsystem. All these submodules shares the resources (clock) & has
> a clock gating register in PWM Subsystem. This patch series creates a
> parent PWM Subsystem driver to handle access synchronization of shared
> resources & clock gating from PWM Subsystem configuration space.
> Also Device tree nodes populated to support parent child relation
> between PWMSS, ECAP & EHRPWM submodules.
> In addition EHRPWM module requires explicit clock gating from control
> module & is handled by patch #6 & 7.
>=20
> As suggested by  Thierry for handling clock gating for PWM submodules
> should handle with a global function. This requires config space
> handling done independent from driver and is done at parent driver.
>=20
> So the parent<->child relation adopted to handle
> 1. pm runtime synchronization
> 2. PWM subsystem common config space clock gating for PWM submodules.
>=20
> Patches supports
> - Driver support for parent child relation handled patch #1
> - HWMOD data correction in EPWMSS at patch #2
> - Parent child in HWMOD relation handled at patch #3
> - Optional EHRPWM tb clock in patch #6
> - Support for TBCLK clock gating at patch #7.
> - Device tree binding support handled in patch #4,8=20
> - Pinctrl support in patch #5 & 9.
> - DT node populated in patch #10 ,11 & 12.
>=20
> This patch series based on omap_dt/for_3.8/dts_part2 and tested
> on am335x-evm & am335x-evmsk.
>=20
> This patch series will come under 3 subsystem basically. But sent
> it in single patch series to have a clearer picture of why the
> OMAP subsystem changes required.
>=20
> Patches come under PWM (1,4,5,7,8,9)
> Patches come under OMAP (2,3,6)
> Patches come under DT (10,11,12).
>=20
> It depends on [1]
> 1. https://gitorious.org/linux-pwm/linux-pwm/commit/83af24027b3df1af5c5a9=
aa9adcdcfeb3429d3be
> pwm: Device tree support for PWM polarity
>=20
> Changes since v3:
> 	- Rebased on top of omap_dt/for_3.8/dts_part2
> 	- Add pwm backlight for am335xevm_sk
> 	- Moved tipwmss.h to pwm-tipwmss.h
>=20
> Philip, Avinash (12):
>   PWMSS: Add PWM Subsystem driver for parent<->child relationship
>   ARM: OMAP: AM33xx hwmod: Corrects PWM subsystem HWMOD entries
>   ARM: OMAP: AM33xx hwmod: Add parent-child relationship for PWM
>     subsystem
>   pwm: tiecap: Add device-tree binding
>   pwm: pwm-tiecap: pinctrl support
>   ARM: AM33XX: clk: Add clock node for EHRPWM TBCLK
>   pwm: pwm-tiehrpwm: Adding TBCLK gating support.
>   pwm: tiehrpwm: Add device-tree binding
>   pwm: pwm-tiehrpwm: pinctrl support
>   ARM: dts: AM33XX: Add PWMSS device tree nodes
>   ARM: dts: AM33XX: Add PWM backlight DT data to am335x-evm
>   ARM: dts: AM33XX: Add PWM backlight DT data to am335x-evmsk

Patches 1, 4, 5, 7, 8 and 9 applied, with a minor fixup to the subject
line of patch 1. Thanks.

Thierry

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQth3NAAoJEN0jrNd/PrOhXKkP/j4DH3rMhDb4W6uMjlxktpMC
pSvhJgOeSDkD15MPmu3k9E6gBbA13GBrsk2V2DWBoRgn2FI4GXhj66u4Oxxme/Wl
TN8zbkXlPkjw8svVIbjwqFu98U7/1xVPP53b+pY1KALhEPVFPgv/lSWWaEefk5qT
vBAo/6SptYrhYQXj9C/hClD5EdDWAncrCTN+T22tkfAtsGsFeNWnwEx1MTSVdqhn
lJrWBsSiX7I/okcQT6euC5HexZ9JR6MUUsERTz7/dowl4ZTA2JElXRVpLLuPjfwp
oeFs6ZVgJgHE9ohL6XXfvTGW1AC6eEUNtoPphSCf72yWDornSnP3is42glr64ytB
Gs5VL23pSiV853l+RJKtqnDYzm7Ta8k8v0+evxwfwxwGaOWHWULXfqsjE1ETWd4j
70LR8mmGWqUuGVWkYXa6AHHYBfqCuCvwJD7HRsXV6UDToeSlWnKnsssRyP0gU+fQ
90kgyrcND6qIP6hAF7lkueYnZ0X9mriQnPOMnr4Gpz53o8MdNLdt+8b//s8qTOOj
nbo2ve40yiUdKQAYPyJwHnTU3urSPsuRUjZog5Cfr+mujPCRBcvM83GNnRmVWEXQ
42qGyVNtpNQNkdk8KWZ8hWXXUoJ7/TaZoNlnvST6ILcmTve9/WnGbGlGsGMIMDL9
p2fTpOT/KS7WusGTy24q
=6/Du
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
