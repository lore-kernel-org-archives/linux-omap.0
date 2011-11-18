From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] staging: tidspbridge: request dmtimer clocks on init
Date: Fri, 18 Nov 2011 16:16:56 -0600
Message-ID: <CAB-zwWiGc86oYHX4uyoOvBmQXUKEcBG8p3WHiATiORGUwqZfoQ@mail.gmail.com>
References: <1321653256-11601-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:39147 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752166Ab1KRWQ6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Nov 2011 17:16:58 -0500
Received: by mail-ey0-f182.google.com with SMTP id 10so4833082eyd.41
        for <linux-omap@vger.kernel.org>; Fri, 18 Nov 2011 14:16:57 -0800 (PST)
In-Reply-To: <1321653256-11601-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org

Hi Greg,

On Fri, Nov 18, 2011 at 3:54 PM, Omar Ramirez Luna <omar.ramirez@ti.com=
> wrote:
> diff --git a/drivers/staging/tidspbridge/core/dsp-clock.c b/drivers/s=
taging/tidspbridge/core/dsp-clock.c
> index 3d1279c..1ba10ae 100644
> --- a/drivers/staging/tidspbridge/core/dsp-clock.c
> +++ b/drivers/staging/tidspbridge/core/dsp-clock.c
> @@ -54,6 +54,7 @@
>
> =A0/* Bridge GPT id (1 - 4), DM Timer id (5 - 8) */
> =A0#define DMT_ID(id) ((id) + 4)
> +#define DM_TIMER_CLOCKS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A05

:/ typo, please ignore this patch there are only 4 clocks for the dsp.

I'll send v2 instead.

Thanks,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
