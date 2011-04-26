From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 09/15] OMAP: GPIO: consolidate IRQ status handling, remove #ifdefs
Date: Tue, 26 Apr 2011 18:13:12 +0530
Message-ID: <BANLkTikqNN0-eW79a6weS_Us1c2WK5MSuQ@mail.gmail.com>
References: <1303513327-14532-1-git-send-email-khilman@ti.com> <1303513327-14532-10-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:59903 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754093Ab1DZMnx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Apr 2011 08:43:53 -0400
Received: by mail-iy0-f178.google.com with SMTP id 12so599302iyi.37
        for <linux-omap@vger.kernel.org>; Tue, 26 Apr 2011 05:43:52 -0700 (PDT)
In-Reply-To: <1303513327-14532-10-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Kevin,

On Sat, Apr 23, 2011 at 04:32, Kevin Hilman <khilman@ti.com> wrote:
> Cleanup IRQ status handling by by passing IRQ status register offsets
> via platform data.

Typo: by by

>
> Cleans up clearing of GPIO IRQ status and GPIO ISR handler.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---

<<snip>>

> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-o=
map/include/plat/gpio.h
> index 268bccd..aedd732 100644
> --- a/arch/arm/plat-omap/include/plat/gpio.h
> +++ b/arch/arm/plat-omap/include/plat/gpio.h
> @@ -180,6 +180,8 @@ struct omap_gpio_reg_offs {
> =A0 =A0 =A0 =A0u16 dataout;
> =A0 =A0 =A0 =A0u16 set_dataout;
> =A0 =A0 =A0 =A0u16 clr_dataout;
> + =A0 =A0 =A0 u16 irqstatus;
> + =A0 =A0 =A0 u16 irqstatus2;

Would it be appropriate to name them as (irqstatus1 & irqstatus2)
or (irqstatus & irqstatus1)?

-V Charulatha

> =A0};
>
> =A0struct omap_gpio_platform_data {
> --
> 1.7.4
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
