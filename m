From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/7] extcon: palmas: Drop IRQF_EARLY_RESUME flag
Date: Mon, 29 Feb 2016 11:22:08 +0900
Message-ID: <56D3AB50.2060502@samsung.com>
References: <1456501377-16871-1-git-send-email-grygorii.strashko@ti.com>
 <1456501377-16871-2-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1456501377-16871-2-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Grygorii,

On 2016=EB=85=84 02=EC=9B=94 27=EC=9D=BC 00:42, Grygorii Strashko wrote=
:
> Palams extcon IRQs are nested threaded and wired to the Palmas
> inerrupt controller. So, this flag is not required for nested irqs
> anymore, since commit 3c646f2c6aa9 ("genirq: Don't suspend
> nested_thread irqs over system suspend") was merged.
>=20
> Cc: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cc: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/extcon/extcon-palmas.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-p=
almas.c
> index 93c30a8..0a861b3 100644
> --- a/drivers/extcon/extcon-palmas.c
> +++ b/drivers/extcon/extcon-palmas.c
> @@ -266,7 +266,7 @@ static int palmas_usb_probe(struct platform_devic=
e *pdev)
>  				palmas_usb->id_irq,
>  				NULL, palmas_id_irq_handler,
>  				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
> -				IRQF_ONESHOT | IRQF_EARLY_RESUME,
> +				IRQF_ONESHOT,
>  				"palmas_usb_id", palmas_usb);
>  		if (status < 0) {
>  			dev_err(&pdev->dev, "can't get IRQ %d, err %d\n",
> @@ -304,7 +304,7 @@ static int palmas_usb_probe(struct platform_devic=
e *pdev)
>  				palmas_usb->vbus_irq, NULL,
>  				palmas_vbus_irq_handler,
>  				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
> -				IRQF_ONESHOT | IRQF_EARLY_RESUME,
> +				IRQF_ONESHOT,
>  				"palmas_usb_vbus", palmas_usb);
>  		if (status < 0) {
>  			dev_err(&pdev->dev, "can't get IRQ %d, err %d\n",
>=20

Applied it on extcon git.

Thanks,
Chanwoo Choi
