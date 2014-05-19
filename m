From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 01/11] ARM: AM43xx: hwmod: add DSS hwmod data
Date: Mon, 19 May 2014 13:12:05 +0300
Message-ID: <5379D8F5.9030008@ti.com>
References: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com> <1399636579-8062-2-git-send-email-tomi.valkeinen@ti.com> <5379CDD2.6080807@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="WQ21H86vJHb5PT2eeUXRKo4wD3LK7bdOA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37747 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbaESKMk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 May 2014 06:12:40 -0400
In-Reply-To: <5379CDD2.6080807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Archit Taneja <archit@ti.com>, Sathya Prakash M R <sathyap@ti.com>

--WQ21H86vJHb5PT2eeUXRKo4wD3LK7bdOA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 19/05/14 12:24, Rajendra Nayak wrote:
> On Friday 09 May 2014 05:26 PM, Tomi Valkeinen wrote:
>> From: Sathya Prakash M R <sathyap@ti.com>
>>
>> Add DSS hwmod data for AM43xx.
>>
>> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 104 ++++++++++++++++++++=
+++++++++
>>  arch/arm/mach-omap2/prcm43xx.h             |   1 +
>>  2 files changed, 105 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mac=
h-omap2/omap_hwmod_43xx_data.c
>> index 5c2cc8083fdd..8c14db2e1e47 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
>> @@ -19,6 +19,8 @@
>>  #include "omap_hwmod.h"
>>  #include "omap_hwmod_33xx_43xx_common_data.h"
>>  #include "prcm43xx.h"
>> +#include "omap_hwmod_common_data.h"
>> +
>> =20
>>  /* IP blocks */
>>  static struct omap_hwmod am43xx_l4_hs_hwmod =3D {
>> @@ -415,6 +417,76 @@ static struct omap_hwmod am43xx_qspi_hwmod =3D {
>>  	},
>>  };
>> =20
>> +/* Display sub system - DSS */
>> +
>> +static struct omap_hwmod_dma_info am43xx_dss_sdma_chs[] =3D {
>> +	{ .name =3D "dispc", .dma_req =3D 5 },
>> +	{ .dma_req =3D -1 },
>> +};
>=20
> the dma info needs to come in from DT. Besides these are edma
> request lines and not sdma.

Right, the sdma information is not needed anymore.

>> +
>> +struct omap_dss_dispc_dev_attr am43xx_dss_dispc_dev_attr =3D {
>> +	.manager_count		=3D 1,
>> +	.has_framedonetv_irq	=3D 0
>> +};
>> +
>> +
> []..
>=20
>> +
>>  /* Interfaces */
>>  static struct omap_hwmod_ocp_if am43xx_l3_main__l4_hs =3D {
>>  	.master		=3D &am33xx_l3_main_hwmod,
>> @@ -654,6 +726,34 @@ static struct omap_hwmod_ocp_if am43xx_l3_s__qspi=
 =3D {
>>  	.user           =3D OCP_USER_MPU | OCP_USER_SDMA,
>>  };
>> =20
>> +static struct omap_hwmod_ocp_if am43xx_dss__l3_main =3D {
>> +	.master		=3D &am43xx_dss_core_hwmod,
>> +	.slave		=3D &am33xx_l3_main_hwmod,
>> +	.clk		=3D "disp_clk",
>=20
> Isn't l3_gclk that clocks the l3 OCP master port?

Hmm, possibly... dispc_clk looks a bit odd there. It's been very
difficult to figure out things like that, with the not-so-good am43xx
documentation.

The documentation mentions "L3 Fast Interconnect" and "LCDL3OCPIFCLK"
related to DSS's OCP master, but searching for those in the TRM doesn't
reveal much.

Would the l3_gclk match the "L3 Fast Interconnect" and l3s_gclk match
the "L3 Slow Interconnect".

 Tomi



--WQ21H86vJHb5PT2eeUXRKo4wD3LK7bdOA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTedj5AAoJEPo9qoy8lh71ahsQAIm7Ug4ov8aMeWKGSmMPFYPU
ypd9+i+lzY4vrmuYCGczXKvt6tL7jgUbg1q/hsA5HqUhx/TibQavyhBM3CUzEnBy
pvHnYiuB3ci2EKwclJymYqEbFmRPbs2zI99cCMkmPaYD+RqZVdFt8A6S7LfpqPQB
NV8OZ7V7U1sou8m7M8Eyf33hxsjnlJhdiugfJ+pxlQWb67qZ1y1iVB15734vDvhJ
Q/bsYWk0DsH6HEJVy4oDkc5DEGInv2w65VTABP7U6WPPsILpfv3ML7cgO6ktcgw/
FXn2fFfzRoBbXW3fd+sfbVEQjqLxjc2Y9tP5Rg2ohluI37ueyCQHYcdA4TSWPIcO
AqTVTRDG6srw9ZjWUnc6PMjySW9KYM1pMRChFICL4sg2UyvOwAQfaM/QFl1JzG19
IMLWDje68hWsZR+zsn34SwtHIsDnkDBvppqMwNL1AuxUCxlTnRwP5Rfqtr5uqQBL
pye0QBg+VWZ/OtnN0+rQhhJehVcmUGY66AGDDuTzivfO/D5/UCSF8Kw5BORPJ4eV
Lp1HVO8qvFAh+sgiaFCUHMi3N3R+/UbSy60UE9SGwktk2doX53tEl29DcO2EP/J7
/4VaN1+QTcAuiicpHC0M4O9A2pd+1rCuREAnXjUoXNFQrzHyYUNS3kjeuV0FPwIJ
4k1+9hUWa8V4RI/Jy3IH
=7o0K
-----END PGP SIGNATURE-----

--WQ21H86vJHb5PT2eeUXRKo4wD3LK7bdOA--
