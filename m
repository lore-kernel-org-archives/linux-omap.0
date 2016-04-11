From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 11/20] mfd: rdc321x: Use devm_mfd_add_devices() for
 mfd_device registration
Date: Mon, 11 Apr 2016 10:31:20 +0100
Message-ID: <20160411093120.GB7994@x1>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
 <1460054594-32325-12-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460054594-32325-12-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Florian Fainelli <florian@openwrt.org>
List-Id: linux-omap@vger.kernel.org

Applied, thanks.

On Fri, 08 Apr 2016, Laxman Dewangan wrote:

> Use devm_mfd_add_devices() for MFD devices registration and get
> rid of .remove callback to remove MFD child-devices. This is done
> by managed device framework.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Florian Fainelli <florian@openwrt.org>
>=20
> ---
> Changes from V1:
> - Convert mfd to MFD.
> - Fix checkpatch --strict error on patch.
>=20
>  drivers/mfd/rdc321x-southbridge.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/mfd/rdc321x-southbridge.c b/drivers/mfd/rdc321x-=
southbridge.c
> index 6575585..2bd8c5b 100644
> --- a/drivers/mfd/rdc321x-southbridge.c
> +++ b/drivers/mfd/rdc321x-southbridge.c
> @@ -85,14 +85,10 @@ static int rdc321x_sb_probe(struct pci_dev *pdev,
>  	rdc321x_gpio_pdata.sb_pdev =3D pdev;
>  	rdc321x_wdt_pdata.sb_pdev =3D pdev;
> =20
> -	return mfd_add_devices(&pdev->dev, -1,
> -			       rdc321x_sb_cells, ARRAY_SIZE(rdc321x_sb_cells),
> -			       NULL, 0, NULL);
> -}
> -
> -static void rdc321x_sb_remove(struct pci_dev *pdev)
> -{
> -	mfd_remove_devices(&pdev->dev);
> +	return devm_mfd_add_devices(&pdev->dev, -1,
> +				    rdc321x_sb_cells,
> +				    ARRAY_SIZE(rdc321x_sb_cells),
> +				    NULL, 0, NULL);
>  }
> =20
>  static const struct pci_device_id rdc321x_sb_table[] =3D {
> @@ -105,7 +101,6 @@ static struct pci_driver rdc321x_sb_driver =3D {
>  	.name		=3D "RDC321x Southbridge",
>  	.id_table	=3D rdc321x_sb_table,
>  	.probe		=3D rdc321x_sb_probe,
> -	.remove		=3D rdc321x_sb_remove,
>  };
> =20
>  module_pci_driver(rdc321x_sb_driver);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
