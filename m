From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 2/2] Input: ads7846 - configure pendown gpio as input
Date: Thu, 3 Feb 2011 10:57:05 +0530
Message-ID: <AANLkTi=H6bJMv4_FnC9ZNXYFetttp1cOCA97+uJmnMi8@mail.gmail.com>
References: <1296660646-28168-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:52882 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750713Ab1BCF1t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Feb 2011 00:27:49 -0500
In-Reply-To: <1296660646-28168-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org

On Wed, Feb 2, 2011 at 21:00, Sourav Poddar <sourav.poddar@ti.com> wrot=
e:
> The ads7846 driver requests a gpio to detect pendown events,
> but does not configure its direction. Configure this gpio
> as an input after requesting it.
>

NACK to this patch too for similar reasons as in patch1 of this series.

> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
> =A0drivers/input/touchscreen/ads7846.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touc=
hscreen/ads7846.c
> index 036f245..c001ce5 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -962,6 +962,7 @@ static int __devinit ads7846_setup_pendown(struct=
 spi_device *spi, struct ads784
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 gpio_direction_input(pdata->gpio_pendown);
> =A0 =A0 =A0 =A0ts->gpio_pendown =3D pdata->gpio_pendown;
>
> =A0 =A0 =A0 =A0return 0;
> --
> 1.7.0.4
>
> --
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
