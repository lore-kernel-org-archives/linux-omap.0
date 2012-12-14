From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 1/1] ARM: OMAP3: igep0020: default boot status LED to On
 instead of Heartbeat
Date: Fri, 14 Dec 2012 19:23:09 +0100
Message-ID: <CAAwP0s2aTb5QzNopycuUMM=0Vj7OwDR9e1WaVCp5m+GvF-HHZA@mail.gmail.com>
References: <1353745771-29983-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1353745771-29983-1-git-send-email-javier.martinez@collabora.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, Nov 24, 2012 at 9:29 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> The IGEPv2 board uses an green GPIO LED to inform the user
> that the kernel could boot.
>
> The green status GPIO LED was default to Heartbeat but On
> is better to signal that is running correctly.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/mach-omap2/board-igep0020.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
> index 0f24cb8..e526228 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -313,7 +313,7 @@ static struct gpio_led igep_gpio_leds[] = {
>         },
>         [3] = {
>                 .name                   = "gpio-led:green:d1",
> -               .default_trigger        = "heartbeat",
> +               .default_trigger        = "default-on",
>                 .gpio                   = -EINVAL, /* gets replaced */
>                 .active_low             = 1,
>         },
> --

Please ignore this patch since another one was sent that supersedes it.

Thanks a lot and sorry for the noise.
Javier
