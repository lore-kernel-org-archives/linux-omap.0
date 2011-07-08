From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] twl4030_charger: fix warnings
Date: Fri, 8 Jul 2011 17:08:54 +0400
Message-ID: <20110708130854.GC29056@oksana.dev.rtsoft.ru>
References: <1307101391-10898-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1307101391-10898-1-git-send-email-notasas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.de>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 03, 2011 at 02:43:11PM +0300, Grazvydas Ignotas wrote:
> Fix warnings emitted by some versions of gcc:
> drivers/power/twl4030_charger.c:490: warning: overflow in implicit co=
nstant conversion
> drivers/power/twl4030_charger.c:498: warning: overflow in implicit co=
nstant conversion
>=20
> While at it, also fix module_param permissions and a typo in my name.
>=20
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---

Applied, thanks.

I also added Jean's sign-off for the module_param persmissions
fix.

>  drivers/power/twl4030_charger.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_=
charger.c
> index 92c16e1..54b9198 100644
> --- a/drivers/power/twl4030_charger.c
> +++ b/drivers/power/twl4030_charger.c
> @@ -62,7 +62,7 @@
>  #define TWL4030_MSTATEC_COMPLETE4	0x0e
> =20
>  static bool allow_usb;
> -module_param(allow_usb, bool, 1);
> +module_param(allow_usb, bool, 0644);
>  MODULE_PARM_DESC(allow_usb, "Allow USB charge drawing default curren=
t");
> =20
>  struct twl4030_bci {
> @@ -425,7 +425,7 @@ static int __init twl4030_bci_probe(struct platfo=
rm_device *pdev)
>  {
>  	struct twl4030_bci *bci;
>  	int ret;
> -	int reg;
> +	u32 reg;
> =20
>  	bci =3D kzalloc(sizeof(*bci), GFP_KERNEL);
>  	if (bci =3D=3D NULL)
> @@ -486,7 +486,7 @@ static int __init twl4030_bci_probe(struct platfo=
rm_device *pdev)
>  	}
> =20
>  	/* Enable interrupts now. */
> -	reg =3D ~(TWL4030_ICHGLOW | TWL4030_ICHGEOC | TWL4030_TBATOR2 |
> +	reg =3D ~(u32)(TWL4030_ICHGLOW | TWL4030_ICHGEOC | TWL4030_TBATOR2 =
|
>  		TWL4030_TBATOR1 | TWL4030_BATSTS);
>  	ret =3D twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, reg,
>  			       TWL4030_INTERRUPTS_BCIIMR1A);
> @@ -495,7 +495,7 @@ static int __init twl4030_bci_probe(struct platfo=
rm_device *pdev)
>  		goto fail_unmask_interrupts;
>  	}
> =20
> -	reg =3D ~(TWL4030_VBATOV | TWL4030_VBUSOV | TWL4030_ACCHGOV);
> +	reg =3D ~(u32)(TWL4030_VBATOV | TWL4030_VBUSOV | TWL4030_ACCHGOV);
>  	ret =3D twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, reg,
>  			       TWL4030_INTERRUPTS_BCIIMR2A);
>  	if (ret < 0)
> @@ -572,7 +572,7 @@ static void __exit twl4030_bci_exit(void)
>  }
>  module_exit(twl4030_bci_exit);
> =20
> -MODULE_AUTHOR("Gra=C5=BEydas Ignotas");
> +MODULE_AUTHOR("Gra=C5=BEvydas Ignotas");
>  MODULE_DESCRIPTION("TWL4030 Battery Charger Interface driver");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:twl4030_bci");
> --=20
> 1.7.0.4
>=20

--=20
Anton Vorontsov
Email: cbouatmailru@gmail.com
