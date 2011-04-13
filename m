From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: Re: [PATCH] rtc-twl: Switch to using threaded irq
Date: Wed, 13 Apr 2011 13:11:47 +0530
Message-ID: <BANLkTinp8M4nndDC5Sfm=PzCiL-vGEqELg@mail.gmail.com>
References: <1300291634-17884-1-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:55640 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756789Ab1DMHls convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Apr 2011 03:41:48 -0400
Received: by mail-vw0-f51.google.com with SMTP id 20so356791vws.24
        for <linux-omap@vger.kernel.org>; Wed, 13 Apr 2011 00:41:47 -0700 (PDT)
In-Reply-To: <1300291634-17884-1-git-send-email-ilkka.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Cc: a.zummo@towertech.it, tony@atomide.com, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org

On Wed, Mar 16, 2011 at 9:37 PM, Ilkka Koskinen
<ilkka.koskinen@nokia.com> wrote:
>
> The driver is accessing to i2c bus in interrupt handler.
> Therefore, it should use threaded irq.

Acked-by: Balaji T K <balajitk@ti.com>

>
> Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
> ---
> =A0drivers/rtc/rtc-twl.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
> index ed1b868..2715b96 100644
> --- a/drivers/rtc/rtc-twl.c
> +++ b/drivers/rtc/rtc-twl.c
> @@ -475,7 +475,7 @@ static int __devinit twl_rtc_probe(struct platfor=
m_device *pdev)
> =A0 =A0 =A0 =A0if (ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out1;
>
> - =A0 =A0 =A0 ret =3D request_irq(irq, twl_rtc_interrupt,
> + =A0 =A0 =A0 ret =3D request_threaded_irq(irq, NULL, twl_rtc_interru=
pt,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQF_T=
RIGGER_RISING,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_na=
me(&rtc->dev), rtc);
> =A0 =A0 =A0 =A0if (ret < 0) {
> --
> 1.7.0.4
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
