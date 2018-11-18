From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] MAINTAINERS: update OMAP MMC entry
Date: Sun, 18 Nov 2018 21:21:11 +0100
Message-ID: <CAMuHMdVCWLmyS+rFEQBHFGTpkw2=xk+Ub9VCnaobA+L9vGLOHw@mail.gmail.com>
References: <20181106222750.12939-1-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181106222750.12939-1-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Andrew Morton <akpm@linux-foundation.org>, ext Tony Lindgren <tony@atomide.com>, jarkko.lavinen@nokia.com, "open list:TI ETHERNET SWITCH DRIVER (CPSW)" <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, j.lavinen@samsung.com
List-Id: linux-omap@vger.kernel.org

Hi Aaro,

CC Jarkko (from his last patch)

On Tue, Nov 6, 2018 at 11:29 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Jarkko's e-mail address hasn't worked for a long time. We still want
> to keep this driver working as it is critical for some of the OMAP boards.
> I use and test this driver frequently, so change myself as a maintainer
> with "Odd Fixes" status.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
>  CREDITS     | 4 ++++
>  MAINTAINERS | 4 ++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
>         v2: Add Jarkko to CREDITS.
>
>         v1: https://patchwork.kernel.org/patch/10369861/
>
> diff --git a/CREDITS b/CREDITS
> index 5befd2d714d0..84cbec4c6211 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -2138,6 +2138,10 @@ E: paul@laufernet.com
>  D: Soundblaster driver fixes, ISAPnP quirk
>  S: California, USA
>
> +N: Jarkko Lavinen
> +E: jarkko.lavinen@nokia.com

If this address hasn't worked for a long time, what's the point of adding
it to CREDITS?

> +D: OMAP MMC support
> +
>  N: Jonathan Layes
>  D: ARPD support
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f4855974f325..1c2badfec2ec 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10793,9 +10793,9 @@ F:      drivers/media/platform/omap3isp/
>  F:     drivers/staging/media/omap4iss/
>
>  OMAP MMC SUPPORT
> -M:     Jarkko Lavinen <jarkko.lavinen@nokia.com>
> +M:     Aaro Koskinen <aaro.koskinen@iki.fi>
>  L:     linux-omap@vger.kernel.org
> -S:     Maintained
> +S:     Odd Fixes
>  F:     drivers/mmc/host/omap.c
>
>  OMAP POWER MANAGEMENT SUPPORT

Seems like Jarkko himself tried to update his address a long time ago,
but the patch was never applied?
https://lore.kernel.org/lkml/1380886987-20517-1-git-send-email-j.lavinen@samsung.com/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
