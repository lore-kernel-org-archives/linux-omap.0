Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643DB3AC0E7;
	Fri,  9 Oct 2026 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556019; cv=none; b=XbEn55LTDvNwX6ZnFqtdzdr4YvVXCeLvUXp4CItbG8WEddVJg9qVXGnqs6yHMU3cJ/mQlxnNi64UQ1EPITbGXdVgpne4PZs4B5eJztSTHa1tGZm0VXDIc4wzEu+VokPIpLSz6zBrYjJUjmdL0Hp0WR1zTBfqEPuduVuzrzOE/D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556019; c=relaxed/simple;
	bh=syM0OUMWPXQcDE8x9lp/8dtlUj/0yaPmKQrzVckgg/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lY44PFH6O9tXDktdXbq0+z09AdAlNLzSLSasLoTV03hQp6ossCADbOOXl8yWaanygwnp7t1lv3UnJX2fCo0Ez85qAGOvqdd8ehfKO4Dm+LziA4pNDJVw+PPgwK0An+/kq5mN7CkBfJoSTryE/Fr6sJW+kncJgdz3Ah4eIuNURBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNm8swsx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNm8swsx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BE31F00898;
	Fri,  9 Oct 2026 14:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791556017;
	bh=1J9ACYh971c62D3Ot0EcBKcdhV3VuspaHio7POj5giA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZNm8swsxdOSsxEDKtft7Uby7TFWtkpmBuYHHOAElBTWMXR2Xc+uAVGAl2+OzLsjIp
	 KUv3pss5WxBaikBO+wbXwQkvMcY4FcehT//dArnpKhDXLl9WR9P3rwbBSdR/SMf0cf
	 JfC0m6731yr51Wg7UxuxtjIKGcOW0EtFTWSL3H160rdJCW3XDm/Up3B1r6Dtlsj3q3
	 LBNPk/uop1CKoRWp3mPwa/AFJp35VsXX4Z8zFDbV0DNnD30FTUD7FQ2C8aWpWRS6Vf
	 nA1RYQrh+2l0U3Yt5/p4rLs6F/KH/lgIJaKD++mg4OrU7UEqSsUYxAyKXoHNE1Cp+r
	 oZso9ri1Dhzwg==
Date: Fri, 9 Oct 2026 15:25:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: ti,tpd12s015: Convert to DT
 schema
Message-ID: <20261009-2f34bbada2c463c78b2c05a7@squawk>
References: <20261009105601.301891-1-quchaosheng000406@163.com>
 <20261009105601.301891-2-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V6w0Wu673xJltLHL"
Content-Disposition: inline
In-Reply-To: <20261009105601.301891-2-quchaosheng000406@163.com>

--V6w0Wu673xJltLHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2026 at 06:55:59PM +0800, Quchaosheng wrote:
> From: Chaosheng Qu <quchaosheng000406@163.com>
>=20
> Convert the TPD12S015 HDMI level shifter binding to DT schema.
>=20
> The TI TPD12S015 is an HDMI companion chip that combines a level shifter
> and ESD protection circuitry. Document the two ports it exposes between
> the HDMI transmitter and the connector.
>=20
> The tpd12s016 is software compatible with the tpd12s015 and is listed as
> a fallback compatible by am57xx-idk-common.dtsi, so accept it as a
> fallback of "ti,tpd12s015". The driver matches on "ti,tpd12s015" only, so
> a board using the tpd12s016 must list both compatibles.
>=20
> Assisted-by: LLM
> Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>

No idea if the sashiko reply is valid, because I have no clue if
providing a subset of the gpios is functional. Really this should have
multiple different gpios properties, but this binding is really old and
not worth changing IMO.
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> ---
>  .../bindings/display/ti/ti,tpd12s015.txt      | 44 ---------
>  .../bindings/display/ti/ti,tpd12s015.yaml     | 90 +++++++++++++++++++
>  2 files changed, 90 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12=
s015.txt
>  create mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12=
s015.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.tx=
t b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
> deleted file mode 100644
> index 26e6d32e3f20..000000000000
> --- a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -TPD12S015 HDMI level shifter and ESD protection chip
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -
> -Required properties:
> -- compatible: "ti,tpd12s015"
> -
> -Optional properties:
> -- gpios: CT CP HPD, LS OE and HPD gpios
> -
> -Required nodes:
> -- Video port 0 for HDMI input
> -- Video port 1 for HDMI output
> -
> -Example
> --------
> -
> -tpd12s015: encoder@1 {
> -	compatible =3D "ti,tpd12s015";
> -
> -	gpios =3D <&gpio2 28 GPIO_ACTIVE_HIGH>,	/* 60, CT CP HPD */
> -		<&gpio2 9 GPIO_ACTIVE_HIGH>,	/* 41, LS OE */
> -		<&gpio2 31 GPIO_ACTIVE_HIGH>;	/* 63, HPD */
> -
> -	ports {
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -
> -		port@0 {
> -			reg =3D <0>;
> -
> -			tpd12s015_in: endpoint@0 {
> -				remote-endpoint =3D <&hdmi_out>;
> -			};
> -		};
> -
> -		port@1 {
> -			reg =3D <1>;
> -
> -			tpd12s015_out: endpoint@0 {
> -				remote-endpoint =3D <&hdmi_connector_in>;
> -			};
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.ya=
ml b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> new file mode 100644
> index 000000000000..1927da3bd736
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/ti/ti,tpd12s015.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI TPD12S015 HDMI level shifter and ESD protection chip
> +
> +maintainers:
> +  - Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> +
> +description: |
> +  The TPD12S015 is an HDMI companion chip that combines a level shifter =
and
> +  ESD protection circuitry. It sits between an HDMI transmitter and the =
HDMI
> +  connector, and provides control over the level shifter enable and the
> +  hot-plug detect signals.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: ti,tpd12s015
> +      - items:
> +          - const: ti,tpd12s016
> +          - const: ti,tpd12s015
> +
> +  gpios:
> +    description:
> +      The CT CP HPD, LS OE and HPD GPIOs, in that order. The first contr=
ols
> +      the level shifter, the second enables the level shifter outputs and
> +      the third reads the hot-plug detect line.
> +    maxItems: 3
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: HDMI input from the transmitter.
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: HDMI output to the connector.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    encoder1 {
> +        compatible =3D "ti,tpd12s015";
> +
> +        gpios =3D <&gpio2 28 GPIO_ACTIVE_HIGH>,    /* 60, CT CP HPD */
> +                <&gpio2 9 GPIO_ACTIVE_HIGH>,    /* 41, LS OE */
> +                <&gpio2 31 GPIO_ACTIVE_HIGH>;    /* 63, HPD */
> +
> +        ports {
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            port@0 {
> +                reg =3D <0>;
> +
> +                tpd12s015_in: endpoint {
> +                    remote-endpoint =3D <&hdmi_out>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg =3D <1>;
> +
> +                tpd12s015_out: endpoint {
> +                    remote-endpoint =3D <&hdmi_connector_in>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> --=20
> 2.43.0
>=20

--V6w0Wu673xJltLHL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasj5YAAKCRB4tDGHoIJi
0i6QAQC7TbianbWVZj38NRXyqg/Sle+Ok3VUON4sFzkFO75j7gEA/RfSN5wQ2f+I
hWNAgc/Li10HouwRRA/JdfRg6z2oug8=
=32kq
-----END PGP SIGNATURE-----

--V6w0Wu673xJltLHL--
