From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/1] ARM: OMAP3: igep0020: simplify GPIO LEDs dependencies
Date: Thu, 20 Dec 2012 15:05:19 +0100
Message-ID: <CABxcv=k6wypYO+JOV1rWyuGtR-seNQ2PFqym7QsAdkC+mC7P8g@mail.gmail.com>
References: <1355505428-24302-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1355505428-24302-1-git-send-email-javier.martinez@collabora.co.uk>
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
Cc: Ezequiel Garcia <elezegarcia@gmail.com>, Russell King <linux@arm.linux.org.uk>, Matthias Brugger <matthias.bgg@googlemail.com>, Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 14, 2012 at 6:17 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> The IGEPv2 board has two user GPIO LEDs and one of them is
> default to "on" to tell the user that the board booted correctly.
>
> But to use these LEDs the config options CONFIG_LEDS_GPIO,
> CONFIG_LEDS_TRIGGERS and CONFIG_LEDS_TRIGGER_DEFAULT_ON have to
> be enabled.
>
> Since only the default-on and default-off triggers were used
> anyway, it is better to just use .default_state instead of
> .default_trigger and not depend on CONFIG_LEDS_TRIGGER_*
>
> Also, this is consistent with IGEPv2 Device Tree that uses
> default-state instead of linux,default-trigger for the leds
> device nodes. The LED names also have been updated to use the
> same names used on omap3-igep0020.dtb.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/mach-omap2/board-igep0020.c |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
> index 0f24cb8..1921541 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -300,20 +300,20 @@ static struct omap2_hsmmc_info mmc[] = {
>
>  static struct gpio_led igep_gpio_leds[] = {
>         [0] = {
> -               .name                   = "gpio-led:red:d0",
> -               .default_trigger        = "default-off"
> +               .name                   = "omap3:red:user0",
> +               .default_state          = 0,
>         },
>         [1] = {
> -               .name                   = "gpio-led:green:d0",
> -               .default_trigger        = "default-off",
> +               .name                   = "omap3:green:boot",
> +               .default_state          = 1,
>         },
>         [2] = {
> -               .name                   = "gpio-led:red:d1",
> -               .default_trigger        = "default-off",
> +               .name                   = "omap3:red:user1",
> +               .default_state          = 0,
>         },
>         [3] = {
> -               .name                   = "gpio-led:green:d1",
> -               .default_trigger        = "heartbeat",
> +               .name                   = "omap3:green:user1",
> +               .default_state          = 0,
>                 .gpio                   = -EINVAL, /* gets replaced */
>                 .active_low             = 1,
>         },
> --

Hi Tony,

Any comments on this patch?

I wonder if I should keep sending fixes/improvements for board-igep0020.c

I already sent an initial Device Tree support for IGEP boards [1] and
Benoit told me he is going to queue for 3.9. But still doesn't support
many peripherals found on these boards because they still don't proper
DT support, for instance NAND and Ethernet need the GPMC bindings
patches that haven't hit mainline yet.

So, it seems I will have to keep working on the board file until it
can be completely deprecated.

Thanks a lot and best regards,
Javier

[1]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg82383.html
