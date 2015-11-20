From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/1] usb: phy: omap-otg: do not write to unallocated memory
Date: Fri, 20 Nov 2015 15:02:38 +0900
Message-ID: <564EB77E.3040000@samsung.com>
References: <1447976581-12666-1-git-send-email-xypron.glpk@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1447976581-12666-1-git-send-email-xypron.glpk@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Felipe Balbi <balbi@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

The same patch was already reviewed and applied on usb.git repository[1=
]
[1] https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?=
h=3Dtesting/fixes&id=3D2c2025b41aeff57963f9ae2dd909fea704c625ab

Thanks,
Chanwoo Choi

On 2015=EB=85=84 11=EC=9B=94 20=EC=9D=BC 08:43, Heinrich Schuchardt wro=
te:
> The current coding writes to memory before allocating it.
>=20
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  drivers/usb/phy/phy-omap-otg.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/phy/phy-omap-otg.c b/drivers/usb/phy/phy-oma=
p-otg.c
> index 1270906..8bbf121 100644
> --- a/drivers/usb/phy/phy-omap-otg.c
> +++ b/drivers/usb/phy/phy-omap-otg.c
> @@ -105,12 +105,13 @@ static int omap_otg_probe(struct platform_devic=
e *pdev)
>  	extcon =3D extcon_get_extcon_dev(config->extcon);
>  	if (!extcon)
>  		return -EPROBE_DEFER;
> -	otg_dev->extcon =3D extcon;
> =20
>  	otg_dev =3D devm_kzalloc(&pdev->dev, sizeof(*otg_dev), GFP_KERNEL);
>  	if (!otg_dev)
>  		return -ENOMEM;
> =20
> +	otg_dev->extcon =3D extcon;
> +
>  	otg_dev->base =3D devm_ioremap_resource(&pdev->dev, &pdev->resource=
[0]);
>  	if (IS_ERR(otg_dev->base))
>  		return PTR_ERR(otg_dev->base);
>=20
