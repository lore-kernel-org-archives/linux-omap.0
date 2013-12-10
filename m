From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 15/15] mfd: menelaus: Use devm_request_threaded_irq()
Date: Tue, 10 Dec 2013 09:30:42 +0000
Message-ID: <20131210093042.GU12675@lee--X1>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
 <1386606085-26838-15-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1386606085-26838-15-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 09 Dec 2013, Felipe Balbi wrote:

> By using devm_request_threaded_irq() we can drop a few extra lines of
> code and rely on device managed resources layer to free our IRQ for u=
s.
>=20
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/mfd/menelaus.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
> index bffe978..b87c2bd 100644
> --- a/drivers/mfd/menelaus.c
> +++ b/drivers/mfd/menelaus.c
> @@ -1271,8 +1271,8 @@ static int menelaus_probe(struct i2c_client *cl=
ient,
>  	/* Set output buffer strengths */
>  	menelaus_write_reg(m, MENELAUS_MCT_CTRL1, 0x73);
> =20
> -	err =3D request_threaded_irq(client->irq, NULL, menelaus_irq,
> -			IRQF_ONESHOT, DRIVER_NAME, m);
> +	err =3D devm_request_threaded_irq(&client->dev, client->irq,
> +			NULL, menelaus_irq, IRQF_ONESHOT, DRIVER_NAME, m);

No need for a separate patch here. Convert straight from request_irq()
to devm_request_threaded_irq() in patch 3.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
