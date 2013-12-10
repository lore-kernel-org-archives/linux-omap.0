From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 03/15] mfd: menelaus: Convert to threaded irq
Date: Tue, 10 Dec 2013 09:32:13 +0000
Message-ID: <20131210093213.GV12675@lee--X1>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
 <1386606085-26838-3-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1386606085-26838-3-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 09 Dec 2013, Felipe Balbi wrote:

> We don't need that extra workqueue when we have generic threaded irq
> handlers support. This patch just moves over to threaded irqs and
> deletes the unnecessary workqueue.
>=20
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/mfd/menelaus.c | 29 ++++-------------------------
>  1 file changed, 4 insertions(+), 25 deletions(-)

<snip>

> -		err =3D request_irq(client->irq, menelaus_irq, 0,
> -				  DRIVER_NAME, menelaus);
> +		err =3D request_threaded_irq(client->irq, NULL, menelaus_irq,
> +				IRQF_ONESHOT, DRIVER_NAME, menelaus);

devm_* managed resources please.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
