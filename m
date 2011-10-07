From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 6/6 v3] usb: musb: Add support for ti81xx platform
Date: Fri, 7 Oct 2011 11:59:55 +0300
Message-ID: <20111007085953.GI10910@legolas.emea.dhcp.ti.com>
References: <1315576070-7618-1-git-send-email-ajay.gupta@ti.com>
 <1315576070-7618-7-git-send-email-ajay.gupta@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FK65GREB+Evh/hTL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:46970 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751754Ab1JGJAB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 05:00:01 -0400
Content-Disposition: inline
In-Reply-To: <1315576070-7618-7-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, tony@atomide.com, Ravi Babu <ravibabu@ti.com>


--FK65GREB+Evh/hTL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 09, 2011 at 07:17:50PM +0530, Ajay Kumar Gupta wrote:
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> new file mode 100644
> index 0000000..fb59e34
> --- /dev/null
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -0,0 +1,693 @@
> +/*
> + * Texas Instruments DSPS platforms "glue layer"
> + *
> + * Copyright (C) 2011, by Texas Instruments
> + *
> + * Based on the am35x "glue layer" code.
> + *
> + * This file is part of the Inventra Controller Driver for Linux.
> + *
> + * The Inventra Controller Driver for Linux is free software; you
> + * can redistribute it and/or modify it under the terms of the GNU
> + * General Public License version 2 as published by the Free Software
> + * Foundation.
> + *
> + * The Inventra Controller Driver for Linux is distributed in
> + * the hope that it will be useful, but WITHOUT ANY WARRANTY;
> + * without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> + * License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with The Inventra Controller Driver for Linux ; if not,
> + * write to the Free Software Foundation, Inc., 59 Temple Place,
> + * Suite 330, Boston, MA  02111-1307  USA
> + *
> + * musb_dsps.c will be a common file for all the TI DSPS platforms
> + * such as dm64x, dm36x, dm35x, da8x, am35x and ti81x.
> + * For now only ti81x is using this and in future davinci.c, am35x.c
> + * da8xx.c would be merged to this file after testing.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/pm_runtime.h>
> +
> +#include <plat/usb.h>

can you avoid using <plat/usb.h> ?? Then we can compile on all
architectures.

--=20
balbi

--FK65GREB+Evh/hTL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOjr+JAAoJEAv8Txj19kN19sEH/ArK8cDYOWxK4utDlHgYGCKc
5aAqy/iRxtsMenrWhAECoC81DIezWPKPPJIyH3KGuEQ5+XzDjTiGXGZcTMs8XQSO
k1akCpuNfD9keBhQDvFJt5wbWC2Mhi+hytxBi6yD8yYcLhWm3JaNg93AQjn8tX14
mYoSG9eka9AvyRa32ojhxJPDdw/TGklaCLN7SS+v9dDdWEUMxV0xzozGCVp0gnhC
P1IJaxf6CblSUMNqa1BX2BRovRe/8YIf8Bh+zIW2ffhUGMHnjNadLdIeWvZ6FhQh
Yd0ESeoGTxSJvR9wgsqU0tbZyvrxSf5iHoiMLckE61kJVKRjfd0ShD5A0/pyo/c=
=0uiB
-----END PGP SIGNATURE-----

--FK65GREB+Evh/hTL--
