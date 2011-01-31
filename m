From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH] arm: Fix possible memory leak
Date: Mon, 31 Jan 2011 10:31:27 +0530
Message-ID: <AANLkTi=iqgCG_ZyzZ-EoPu6OGxtnJc0CRrLDPHOQZ90-@mail.gmail.com>
References: <1296415587-4524-1-git-send-email-weil@mail.berlios.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1296415587-4524-1-git-send-email-weil@mail.berlios.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Weil <weil@mail.berlios.de>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Acked. Will make sure there is no Memory Leak issue in Smartreflex Driv=
er.

On Mon, Jan 31, 2011 at 12:56 AM, Stefan Weil <weil@mail.berlios.de> wr=
ote:
> sr_info was allocated and needs a kfree before returning.
>
> This error was reported by cppcheck:
> arch/arm/mach-omap2/smartreflex.c:837: error: Memory leak: sr_info
>
> To: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Stefan Weil <weil@mail.berlios.de>
> ---
> =A0arch/arm/mach-omap2/smartreflex.c | =A0 =A03 ++-
> =A01 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/=
smartreflex.c
> index af39d17..07324607 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -832,7 +832,8 @@ static int __init omap_sr_probe(struct platform_d=
evice *pdev)
>
> =A0 =A0 =A0 =A0if (!pdata) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "%s: platform data=
 missing\n", __func__);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_devinfo;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0)=
;
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>


--=20
Thanks,
Regards,
Shweta
