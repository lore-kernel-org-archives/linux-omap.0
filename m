From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH, v2] ARM: omap2: gpmc: fix compilation warning
Date: Thu, 16 May 2013 10:39:24 -0700
Message-ID: <20130516173923.GA5600@atomide.com>
References: <20130508222639.GM32546@atomide.com>
 <1368552043-3764-1-git-send-email-vincent.stehle@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:47055 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752873Ab3EPRj0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 May 2013 13:39:26 -0400
Content-Disposition: inline
In-Reply-To: <1368552043-3764-1-git-send-email-vincent.stehle@laposte.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@laposte.net>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent =?utf-8?Q?Stehl=C3=A9?= <v-stehle@ti.com>, trivial@kernel.org

* Vincent Stehl=C3=A9 <vincent.stehle@laposte.net> [130514 10:26]:
> From: Vincent Stehl=C3=A9 <v-stehle@ti.com>
>=20
> Fix the following compilation warning:
>=20
>   arch/arm/mach-omap2/gpmc.c: In function 'gpmc_probe_generic_child':
>   arch/arm/mach-omap2/gpmc.c:1477:4: warning: format '%x' expects arg=
ument of type 'unsigned int', but argument 4 has type 'resource_size_t'=
 [-Wformat]
>=20
> Signed-off-by: Vincent Stehl=C3=A9 <v-stehle@ti.com>
> Cc: trivial@kernel.org
> ---
>=20
> Tony wrote:
> > You should just change the format for dev_err instead of the castin=
g.
>=20
> Hi,
>=20
> Sorry for the late answer; it seems this is a bit more complicated af=
ter all,
> as res.start can be 32b or 64b in LPAE. The common solution seems to =
be: cast
> to long long in all cases and print accordingly. Would you like this =
better?

Oh OK. In this case the GPMC is always within the 32-bit address space.

But considering that similar issue will be there for other code with
LPAE, how about add something generic to arch/arm/include/asm/io.h like=
:

#define PHYS_ADDR32(x)	((__force u32)(x))
#define PHYS_ADDR64(x)	((__force u64)(x))

Or maybe something like that already exists.

Regards,

Tony

>  arch/arm/mach-omap2/gpmc.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 6c4da12..e74501e 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1473,8 +1473,8 @@ static int gpmc_probe_generic_child(struct plat=
form_device *pdev,
>  	 */
>  	ret =3D gpmc_cs_remap(cs, res.start);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "cannot remap GPMC CS %d to 0x%x\n",
> -			cs, res.start);
> +		dev_err(&pdev->dev, "cannot remap GPMC CS %d to 0x%llx\n",
> +			cs, (long long)res.start);
>  		goto err;
>  	}
> =20
> --=20
> 1.7.10.4
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
