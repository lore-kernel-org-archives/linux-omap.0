From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Thu, 15 May 2014 11:41:57 +0300
Message-ID: <53747DD5.2030406@ti.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com> <1398815562-24113-4-git-send-email-tony@atomide.com> <5369EAE7.3030705@ti.com> <20140507150343.GA9502@atomide.com> <536A5920.1020908@ti.com> <20140507175919.GH9502@atomide.com> <20140508233300.GI2198@atomide.com> <536C924E.5000307@ti.com> <20140509153008.GC17814@atomide.com> <20140513212639.GA18001@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="SsUm9rS4DJ36L9sMqlrDuekCF3WUNRM6P"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42391 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbaEOIma (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2014 04:42:30 -0400
In-Reply-To: <20140513212639.GA18001@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

--SsUm9rS4DJ36L9sMqlrDuekCF3WUNRM6P
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14/05/14 00:26, Tony Lindgren wrote:

> +	/* lcd MO */
> +	ddata->mo_gpio =3D sharp_ls_get_gpio_of(&pdev->dev, 0, 1, "mode");
> +	if (PTR_ERR(ddata->mo_gpio) =3D=3D -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
> +	if (!IS_ERR(ddata->mo_gpio))
> +		if (gpiod_get_raw_value_cansleep(ddata->mo_gpio))
> +			ddata->flags |=3D SHARP_LS_QVGA;

Shouldn't there be an explicit flag in the DT data for this? If the
panel's MO pin is hardwired to, say, pull up, then the mode-gpios won't
have MO gpio, right? So something like:


mode-gpios =3D <0					/* high, lcd MO */
	      &gpio1 2 GPIO_ACTIVE_HIGH		/* gpio2, lcd LR */
	      &gpio1 3 GPIO_ACTIVE_HIGH>;	/* gpio3, lcd UD */

vga-mode;	/* MO hardwired high */



Btw, the gpio.txt has each gpio inside <>:

chipsel-gpios =3D <&gpio1 12 0>,
		 <&gpio1 13 0>,
		 <0>, /* holes are permitted, means no GPIO 2 */
		 <&gpio2 2>;

Is that equivalent to having all gpios inside <>?

 Tomi



--SsUm9rS4DJ36L9sMqlrDuekCF3WUNRM6P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTdH3cAAoJEPo9qoy8lh711CoP/1tEqKBs9xgEFxLAR6pcLyQ/
0flFxJYLzxsnbncbxkjNEWdrXveVRDdENbx/cOOY615uwewE1z0ulH50ba8/PyMp
hZuKB5LkymnMwWFy+yJW8vib73ohDHMki2eE5qbvbGJGqkaSLr6m4fuclhriQG6O
23/3+fgghwmyohhZiWG2Pk3ZGBD2qmYrgjBmEY/UkfJcSphargCSio926L9oESdU
X4fXTGNj/cmhTdU3yyfV4lkv3zs6+4yaq4uzfOcIYN+fgH+J7awSP9yDG1I/MlRC
InFxQvAs9Qv3VytB69mTg6mcrQlAOe4EpQJrpFz32J2Ik/kdCAXrywdWZGsImbZi
EfLt3C5QNQ4GEK6gXXyAu/OgJBGHEdHBsqEocznoufLEB80zOSeydTfkbK7gAa1i
vyU6Res4iej9Jbm6E80bli4PMU+jIBs7OCIRrtD5AzYFAgEy9lxZre0b/MY045jT
uBL+T1I8LCGcjlwIKUDwuFjLASjiKSga4s/DxtaScQKqmdOTdtQIyCxW8AWDclq+
VvJpZt1WPltr88FrEHJ+/HrbFzJBmyG2V0D6IA/xkaDUniWwpcEAoT9jDHK0LmkC
TFI870Go75yexUjaZZYGLhEwvug8M//88Z2fsP6EfOb+Up25b28zn9Bhymvy3s1A
MiG/o0w5k8iOkuTRSAXw
=BWjN
-----END PGP SIGNATURE-----

--SsUm9rS4DJ36L9sMqlrDuekCF3WUNRM6P--
