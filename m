From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH resend] omap: rx51: Add SI4713 FM transmitter
Date: Mon, 21 Feb 2011 13:10:59 +0530
Message-ID: <AANLkTikR5v9_G3oyRjVP1oCcBo=hU+ikywximd=VDbDd@mail.gmail.com>
References: <1298040354-1726-1-git-send-email-jhnikula@gmail.com> <1298270556-11571-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:39200 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751751Ab1BUHll convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 02:41:41 -0500
Received: by ywi6 with SMTP id 6so1097242ywi.3
        for <linux-omap@vger.kernel.org>; Sun, 20 Feb 2011 23:41:39 -0800 (PST)
In-Reply-To: <1298270556-11571-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org

On Mon, Feb 21, 2011 at 12:12, Jarkko Nikula <jhnikula@gmail.com> wrote=
:
> Add SI4713 FM transmitter supplies, platform data and setup to RX-51/=
N900.
> It is connected to line output signals of TLV320AIC34 codec A part.
> Driver can be either built-in or a module. It can be tuned with v4l2-=
ctl
> from ivtv-utils. Following examples illustrate the use of it:
>
> =A0 =A0 =A0 =A0v4l2-ctl -d /dev/radio0 --set-ctrl=3Dmute=3D0 (power u=
p)
> =A0 =A0 =A0 =A0v4l2-ctl -d /dev/radio0 -f 107900 (tune 107.9 MHz)
>
> =A0 =A0 =A0 =A0v4l2-ctl -d /dev/radio0 --set-ctrl=3Dmute=3D1 (power d=
own)
>
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
> Resend =3D forgot to cc LAKML.
> ---

<<snip>>

> +
> +static __init void rx51_init_si4713(void)
> +{
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 err =3D gpio_request_one(RX51_FMTX_IRQ, GPIOF_DIR_IN, "=
si4713 irq");
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Cannot request si4713 =
irq gpio. %d\n", err);

use pr_err instead of printk.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 rx51_si4713_board_info.irq =3D gpio_to_irq(RX51_FMTX_IR=
Q);
> + =A0 =A0 =A0 platform_device_register(&rx51_si4713_dev);
> +}
> +

<<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
