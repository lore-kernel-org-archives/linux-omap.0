From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] pwm: Add PWM polarity flag macros for DT
Date: Thu, 11 Jul 2013 08:36:00 -0700
Message-ID: <20130711153559.GB2198@dhcp-172-17-186-34.nvidia.com>
References: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1373553468-6564-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:60228 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755885Ab3GKPgJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jul 2013 11:36:09 -0400
Content-Disposition: inline
In-Reply-To: <1373553468-6564-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Boris BREZILLON <linux-arm@overkiz.com>, Tomasz Figa <t.figa@samsung.com>, Philip Avinash <avinashphilip@ti.com>, Tony Prisk <linux@prisktech.co.nz>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, linux-pwm@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2013 at 04:37:48PM +0200, Laurent Pinchart wrote:
[...]
> diff --git a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt b/Do=
cumentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> index de0eaed..be09be4 100644
> --- a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> @@ -4,9 +4,9 @@ Required properties:
>  - compatible: should be "atmel,tcb-pwm"
>  - #pwm-cells: Should be 3.  The first cell specifies the per-chip index
>    of the PWM to use, the second cell is the period in nanoseconds and
> -  bit 0 in the third cell is used to encode the polarity of PWM output.
> -  Set bit 0 of the third cell in PWM specifier to 1 for inverse polarity=
 &
> -  set to 0 for normal polarity.
> +  the third cell is used to encode the polarity of PWM output. Set the
> +  PWM_POLARITY_NORMAL flag for normal polarity or the PWM_POLARITY_INVER=
SED
> +  flag for inverted polarity. PWM flags are defined in <dt-bindings/pwm/=
pwm.h>.
>  - tc-block: The Timer Counter block to use as a PWM chip.
> =20
>  Example:

I'd prefer for the original text to stay in place and the reference to
the dt-bindings/pwm/pwm.h file to go below that block. The reason is
that perhaps somebody will look at an older version of a given DT (with
the numerical value) and not have access to the include and therefore
not know which flag was being set by just looking at the documentation.
I'm also not sure about what the plans are with respect to shipping
device trees in a separate repository and if they are, whether that
repository would ship the includes as well.

Another issue might be that people without access to recent versions of
DTC won't be able to use the new #include feature, so keeping the
documentation backwards compatible seems like a good idea.

Perhaps the include file should even only be mentioned in the general
PWM binding documentation.

Perhaps Grant and Rob (Cc'ed) can comment on how they want to handle
this.

> diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt b/Docu=
mentation/devicetree/bindings/pwm/pwm-samsung.txt
> index ac67c68..bece18b 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> @@ -24,8 +24,9 @@ Required properties:
>       - phandle to PWM controller node
>       - index of PWM channel (from 0 to 4)
>       - PWM signal period in nanoseconds
> -     - bitmask of optional PWM flags:
> -        0x1 - invert PWM signal
> +     - bitmask of optional PWM flags as defined in <dt-bindings/pwm/pwm.=
h>:
> +        PWM_POLARITY_NORMAL - normal polarity
> +	PWM_POLARITY_INVERSED - inverted polarity

This part mixes spaces and tabs for indentation. Please stick to spaces.

> diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentatio=
n/devicetree/bindings/pwm/pwm.txt
> index 06e6724..38c357a 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> @@ -43,13 +43,15 @@ because the name "backlight" would be used as fallbac=
k anyway.
>  pwm-specifier typically encodes the chip-relative PWM number and the PWM
>  period in nanoseconds.
> =20
> -Optionally, the pwm-specifier can encode a number of flags in a third ce=
ll:
> -- bit 0: PWM signal polarity (0: normal polarity, 1: inverse polarity)
> +Optionally, the pwm-specifier can encode a number of flags (defined in
> +<dt-bindings/gpio/gpio.h>) in a third cell:
> +- PWM_POLARITY_NORMAL: use the normal PWM signal polarity
> +- PWM_POLARITY_INVERSED: invert the PWM signal polarity

You'd have a hard time finding those in the GPIO header. =3D)

> diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
> new file mode 100644
> index 0000000..f82be30
> --- /dev/null
> +++ b/include/dt-bindings/pwm/pwm.h
> @@ -0,0 +1,15 @@
> +/*
> + * This header provides constants for most PWM bindings.
> + *
> + * Most PWM bindings can include a flags cell as part of the PWM specifi=
er.
> + * In most cases, the format of the flags cell uses the standard values
> + * defined in this header.
> + */
> +
> +#ifndef _DT_BINDINGS_PWM_PWM_H
> +#define _DT_BINDINGS_PWM_PWM_H
> +
> +#define PWM_POLARITY_NORMAL			(0 << 0)
> +#define PWM_POLARITY_INVERSED			(1 << 0)
> +
> +#endif

I think this should go into a patch separate from the DT changes above
because they'll likely go in via different trees. Or maybe they won't,
but it'd still be good to introduce the header first and only then
change the DTS files.

> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
[...]
>  enum pwm_polarity {
> -	PWM_POLARITY_NORMAL,
> -	PWM_POLARITY_INVERSED,
> +	PWM_POLARITY_NORMAL =3D 0,
> +	PWM_POLARITY_INVERSED =3D 1,

That's what the enum values will be by default, so there's no need to be
explicit here.

Thierry

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJR3tDfAAoJEN0jrNd/PrOh6tMP/12mmN+pajUf3ikGnJYeJHol
0eZF7EWGFYP6lg+NWaUsc4GvFByvCgD53d71qpYYTMXbFqZX/lw31O6v+eOCt7XY
WvVkJq+NvAtV6PcaFRr/UGoWLJZ4QvtT7rLcQsixvbl7e7B7mL4w3Ag7YZqrXCJV
1qVEssmHJjNG99MrlSYutrTTrEqDodfprFHT/JtqWBPvihu0x+1u5P/cLSxfFDk+
lUPCVdLtipHKKSo1eKMDytP0tqkWK108zxu7+B+johetRsV1vAHdChZ4dUkkyKDm
+ZrsEizNQ4EYfsM7e2m6Hta1ySMEhDtBvGna1IOnI5CW5OnC/p8EdytpfImBUDXl
0zCMDfSFlCVwcqzYJ6XHI86ryvuEVg8p7TeNFLJEfhgNds6qXrXFjnadY/Gxx7qB
RtKXIDSY0MiXGzXPIf1ES7MslRB3yR5uznu4Wu0TfB7cM/MhnflyoHk1LfoSKVs9
jcx6mHgV24a5NpFmeGkdB8xgOVEhzhVcPtYA56K1icCBPI3xVsMzxRito+Guuic3
sBtTiYGcgi6rVRnQSK53Ps1ngGaI8C8osyD5MQ5hxw7GkuXToDqfgKvFA3OFSTEz
ENZZN9Jxkzn9PUeLH03oZatojOVB3nbb7fdaJrSeDBttdJjzyBqXi3njfRcUFK+x
RruuYigIqd87+VkiHp44
=VSBG
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
