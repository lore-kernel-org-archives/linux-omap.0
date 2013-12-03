From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/4] mfd: DT bindings for TPS65218 PMIC
Date: Tue, 3 Dec 2013 09:36:37 +0000
Message-ID: <20131203093637.GE11828@lee--X1>
References: <1386053006-6480-1-git-send-email-j-keerthy@ti.com>
 <1386053006-6480-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1386053006-6480-2-git-send-email-j-keerthy@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, sameo@linux.intel.com, grant.likely@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> Add DT bindings for TPS65218 PMIC.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  Documentation/devicetree/bindings/mfd/tps65218.txt |   27 ++++++++++=
++++++++++
>  .../devicetree/bindings/regulator/tps65218.txt     |   22 ++++++++++=
++++++
>  2 files changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/tps65218.tx=
t
>  create mode 100644 Documentation/devicetree/bindings/regulator/tps65=
218.txt
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/tps65218.txt b/Doc=
umentation/devicetree/bindings/mfd/tps65218.txt
> new file mode 100644
> index 0000000..87cb7a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/tps65218.txt
> @@ -0,0 +1,27 @@
> +The TPS65218 Integrated Power Management Chips.
> +These chips are connected to an i2c bus.

                                   I2C

> +Required properties:
> +- compatible : Must be "ti,tps65218";
> +- interrupts : This i2c device has an IRQ line connected to the main=
 SoC

                       I2C

> +- interrupt-controller : Since the tps65218 support several interrup=
ts

                                               support(s) (hosts?)

> +  internally, it is considered as an interrupt controller cascaded t=
o the SoC.
> +- #interrupt-cells =3D <2>;
> +- interrupt-parent : The parent interrupt controller.

           Phandle to ...

> +Optional node:

            node(s):

> +- Child nodes contain in the tps65218.
> +  It supports a number of features.

Please re-phase the above two sentences to something decipherable.

> +  The children nodes will thus depend of the capability of the varia=
nt.

Please, go on ...

> +Example:
> +/*
> + * Integrated Power Management Chip
> + */
> +tps@24 {
> +    compatible =3D "ti,tps65218";
> +    reg =3D <0x24>;
> +    interrupt-controller;
> +    #interrupt-cells =3D <2>;
> +    interrupt-parent =3D <&gic>;
> +};

Perhaps it would be better to centralise the documentation inclusive
of the regulator contingent. Or at least provide a _full_ example in
each document.

> diff --git a/Documentation/devicetree/bindings/regulator/tps65218.txt=
 b/Documentation/devicetree/bindings/regulator/tps65218.txt
> new file mode 100644
> index 0000000..1ccf170
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/tps65218.txt
> @@ -0,0 +1,22 @@
> +TPS65218 family of regulators
> +
> +Required properties:
> +For tps65218 regulators/LDOs
> +- compatible:
> +  - "ti,tps65218-dcdc1" for DCDC1
> +  - "ti,tps65218-dcdc2" for DCDC2
> +  - "ti,tps65218-dcdc3" for DCDC3
> +  - "ti,tps65218-dcdc4" for DCDC4
> +  - "ti,tps65218-dcdc5" for DCDC5
> +  - "ti,tps65218-dcdc6" for DCDC6
> +  - "ti,tps65218-ldo1" for LDO1 LDO

Why aren't you using 'regulator-compatible'?

> +Optional properties:
> +- Any optional property defined in bindings/regulator/regulator.txt
> +
> +Example:
> +	xyz: regulator@0 {

Genuine question: Is the @0 meaningful?

> +		compatible =3D "ti,tps65218-dcdc1";
> +		regulator-min-microvolt  =3D <1000000>;
> +		regulator-max-microvolt  =3D <3000000>;
> +	};

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
