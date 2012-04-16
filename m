From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH] ARM: OMAP: serial: Fix the ocp smart idlemode handling bug
Date: Mon, 16 Apr 2012 15:35:38 +0530
Message-ID: <CAMrsUdLMugSaq74ke+1pdu9sUbAd7av61sB+hywTiZiOoxy-zQ@mail.gmail.com>
References: <1334339704-4554-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:56395 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752042Ab2DPKGA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Apr 2012 06:06:00 -0400
Received: by obbwd20 with SMTP id wd20so2006223obb.3
        for <linux-omap@vger.kernel.org>; Mon, 16 Apr 2012 03:05:59 -0700 (PDT)
In-Reply-To: <1334339704-4554-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

On Fri, Apr 13, 2012 at 11:25 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> The current serial UART code, while fidling with ocp idlemode bits,
> forget about the smart idle wakeup bit even if it is supported by
> UART IP block. This will lead to missing the module wakeup on OMAP's
> where the smart idle wakeup is supported.
>
> This was the root cause of the console sluggishness issue, I have bee=
n
> observing on OMAP4 devices and also can be potential reason for some
> other UART wakeup issues.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Govindraj.R <govindraj.raja@ti.com>

Acked-by: Govindraj.R <govindraj.raja@ti.com>

Adding to git://gitorious.org/linux-3-x/omap-serial.git  for_3.4/uart_f=
ixes

> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
> =A0arch/arm/mach-omap2/serial.c | =A0 =A08 +++++++-
> =A01 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seria=
l.c
> index c9503a7..b28aae1 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -108,8 +108,14 @@ static void omap_uart_set_noidle(struct platform=
_device *pdev)
> =A0static void omap_uart_set_smartidle(struct platform_device *pdev)
> =A0{
> =A0 =A0 =A0 =A0struct omap_device *od =3D to_omap_device(pdev);
> + =A0 =A0 =A0 u8 idlemode;
>
> - =A0 =A0 =A0 omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLE=
MODE_SMART);
> + =A0 =A0 =A0 if (od->hwmods[0]->class->sysc->idlemodes & SIDLE_SMART=
_WKUP)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 idlemode =3D HWMOD_IDLEMODE_SMART_WKUP;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 idlemode =3D HWMOD_IDLEMODE_SMART;
> +
> + =A0 =A0 =A0 omap_hwmod_set_slave_idlemode(od->hwmods[0], idlemode);
> =A0}
>
> =A0#else
> --
> 1.7.5.4
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
