From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCHv4 4/4] OMAP3: Devkit8000: Fix indentation of brace
Date: Wed, 19 Jan 2011 14:39:25 +0530
Message-ID: <AANLkTi=oWsKyAcDwpW-oO8nPM=vHOhJ8NGnFp4jjCGAL@mail.gmail.com>
References: <1295425166-25540-1-git-send-email-weber@corscience.de> <1295425166-25540-5-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1295425166-25540-5-git-send-email-weber@corscience.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Weber <weber@corscience.de>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Morsing <daniel.morsing@gmail.com>, sshtylyov@mvista.com
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 19, 2011 at 13:49, Thomas Weber <weber@corscience.de> wrote=
:
>
> Fix indentation of a closing curly brace.

As Manjunath mentioned for the other patch, I guess this patch can
also be merged
with some other patch in this series.

>
> Signed-off-by: Thomas Weber <weber@corscience.de>
> ---
> =A0arch/arm/mach-omap2/board-devkit8000.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-o=
map2/board-devkit8000.c
> index 4ddd81c..a344cd8 100644
> --- a/arch/arm/mach-omap2/board-devkit8000.c
> +++ b/arch/arm/mach-omap2/board-devkit8000.c
> @@ -553,7 +553,7 @@ static void __init omap_dm9000_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "Failed to request GPI=
O%d for dm9000 IRQ\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_DM9000_GPIO_IRQ);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0gpio_direction_input(OMAP_DM9000_GPIO_IRQ);
>
> --
> 1.7.4.rc2
>
