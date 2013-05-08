From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2: gpmc: fix compilation warning
Date: Wed, 8 May 2013 15:26:39 -0700
Message-ID: <20130508222639.GM32546@atomide.com>
References: <1367839093-13033-1-git-send-email-v-stehle@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1367839093-13033-1-git-send-email-v-stehle@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent =?utf-8?Q?Stehl=C3=A9?= <v-stehle@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org
List-Id: linux-omap@vger.kernel.org

* Vincent Stehl=C3=A9 <v-stehle@ti.com> [130506 04:24]:
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
>  arch/arm/mach-omap2/gpmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index ed946df..3cd7074 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1474,7 +1474,7 @@ static int gpmc_probe_generic_child(struct plat=
form_device *pdev,
>  	ret =3D gpmc_cs_remap(cs, res.start);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "cannot remap GPMC CS %d to 0x%x\n",
> -			cs, res.start);
> +			cs, (unsigned)res.start);
>  		goto err;
>  	}

You should just change the format for dev_err instead of the casting.

Regards,

Tony
