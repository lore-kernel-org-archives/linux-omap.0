From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH] ARM: bcm: Fix support for BCM2711 SoC which breaks other
 ARM platforms
Date: Sat, 14 Dec 2019 22:09:48 +0100
Message-ID: <a78dbb9c-31ee-90c6-6bb6-6f6448c8208e@gmx.net>
References: <33662723d61a80669390abc1e592eb006d8709f1.1576353784.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <33662723d61a80669390abc1e592eb006d8709f1.1576353784.git.hns@goldelico.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: letux-kernel@openphoenux.org, Tony Lindgren <tony@atomide.com>, linux@armlinux.org.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org, kernel@pyra-handheld.com, Linux-OMAP <linux-omap@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Nikolaus,

Am 14.12.19 um 21:03 schrieb H. Nikolaus Schaller:
> commit 781fa0a95424 ("ARM: bcm: Add support for BCM2711 SoC")
>
> breaks boot of many other platforms (e.g. OMAP or i.MX6) if
> CONFIG_ARCH_BCM2835 is enabled in addition to some multiplatform
> config (e.g. omap2plus_defconfig). The symptom is that the OMAP
> based board does not show any activity beyond "Starting Kernel ..."
> even with earlycon.
>
> Reverting the mentioned commit makes it work again.
>
> The real fix is to add the missing NULL sentinel to the
> bcm2711_compat[] variable-length array.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

could you please add a Fixes tag. Apart from that

Acked-by: Stefan Wahren <wahrenst@gmx.net>

Thank you
Stefan

> ---
>  arch/arm/mach-bcm/bcm2711.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-bcm/bcm2711.c b/arch/arm/mach-bcm/bcm2711.c
> index dbe296798647..fa0300d8c79d 100644
> --- a/arch/arm/mach-bcm/bcm2711.c
> +++ b/arch/arm/mach-bcm/bcm2711.c
> @@ -13,6 +13,7 @@ static const char * const bcm2711_compat[] =3D {
>  #ifdef CONFIG_ARCH_MULTI_V7
>  	"brcm,bcm2711",
>  #endif
> +	NULL
>  };
>
>  DT_MACHINE_START(BCM2711, "BCM2711")
