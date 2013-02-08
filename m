From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V2 2/2] dmaengine: OMAP: Register SDMA controller with
 Device Tree DMA driver
Date: Fri, 8 Feb 2013 09:55:52 +0200
Message-ID: <20130208075552.GD21879@arwen.pp.htv.fi>
References: <1360285506-22354-1-git-send-email-jon-hunter@ti.com>
 <1360285506-22354-3-git-send-email-jon-hunter@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d9ADC0YsG2v16Js0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51839 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab3BHH4N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 02:56:13 -0500
Content-Disposition: inline
In-Reply-To: <1360285506-22354-3-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Vinod Koul <vinod.koul@intel.com>, Russell King <linux@arm.linux.org.uk>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Matt Porter <mporter@ti.com>, Felipe Balbi <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Balaji T K <balajitk@ti.com>

--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 07, 2013 at 07:05:06PM -0600, Jon Hunter wrote:
> If the device-tree blob is present during boot, then register the SDMA
> controller with the device-tree DMA driver so that we can use device-tree
> to look-up DMA client information.
>=20
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

single comment below, other than that:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/dma.c |    4 ++++
>  drivers/dma/omap-dma.c    |   37 +++++++++++++++++++++++++++++++++++--
>  2 files changed, 39 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
> index 5cd8d76..71dadff 100644
> --- a/arch/arm/mach-omap2/dma.c
> +++ b/arch/arm/mach-omap2/dma.c
> @@ -28,6 +28,7 @@
>  #include <linux/init.h>
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/of.h>
>  #include <linux/omap-dma.h>
> =20
>  #include "soc.h"
> @@ -304,6 +305,9 @@ static int __init omap2_system_dma_init(void)
>  	if (res)
>  		return res;
> =20
> +	if (of_have_populated_dt())
> +		return res;
> +
>  	pdev =3D platform_device_register_full(&omap_dma_dev_info);
>  	if (IS_ERR(pdev))
>  		return PTR_ERR(pdev);
> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
> index c4b4fd2..0067bd0 100644
> --- a/drivers/dma/omap-dma.c
> +++ b/drivers/dma/omap-dma.c
> @@ -16,6 +16,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/of_dma.h>
> +#include <linux/of_device.h>
> =20
>  #include "virt-dma.h"
> =20
> @@ -67,6 +69,8 @@ static const unsigned es_bytes[] =3D {
>  	[OMAP_DMA_DATA_TYPE_S32] =3D 4,
>  };
> =20
> +static struct of_dma_filter_info info;

Arnd also mentioned that since all fields belonging to this are
constant, you could statically initialize them here. He also mentioned
you should call this by a more descriptive name:

--=20
balbi

--d9ADC0YsG2v16Js0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRFK+IAAoJEIaOsuA1yqREgNgP/Rb2Ypsn1F2ziMvjxwtKrAw3
pWAGkYgoWtPOjH70i2VsGsnFPdn2S+uen19QfFI9MbOWiaNCpu62suUYDnSULXXX
efGgYfCEIFyyBa3cncoy0UGUtyzw4iuuvVSumOCS60ef5mobVvxBOkzbcIcvcmLG
BcpmX+y7MDRDxG6G2SsE1IEtOqErlMT/OszNP/uDH1S2pKyCmEhv+y7aQ04HgxFq
HRhMEj4/P0vPwepCbiS11OVqu9X6qZQMGxK3w6lEzP6vGhH3zaGsB/huej9KhtRD
Oa/ENbPSVoMvNk4dEvP9S5h8iLTLAGGoXqecUI/OlmDqOLXhHqrOpVWqce9J0nPc
qS91Qr/yTl493DG3sFSAfU9UQZgppehdNv5iXdTJiik8zOraR5rh+IrS+lgsvxqu
r4eD12DlaiLXkbGMstQ48/3RNJ6cTQBoAeBsBt9vBflwgV+9L21Tn6RwAShNCUwt
1IM8/SYd10Mda8s+Siry5X1KQFW+eXq/yLkII382mvPXPJ8NSX2pEhBrRia1JvPX
EB/0RRi2ZbAceP365Y8YshCFZKjN+qzLv09kcwG8SuVI1Ptq2IJtoF0ZBr4KOxw4
gRJHSqOOWSVuh8D1/T6k/wKqmVHOrEr8DuiVcBQt111Yxl0OjrppkOrRhhkjcMaR
G1ODYG7CceAqLUVszaYd
=knve
-----END PGP SIGNATURE-----

--d9ADC0YsG2v16Js0--
