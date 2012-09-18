From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH] ARM: OMAP: OMAP_DEBUG_LEDS needs to select LEDS_CLASS
Date: Tue, 18 Sep 2012 14:34:48 +0800
Message-ID: <CAK5ve-LXv76vuBLHQQtREHn_ZogUsbyqzz2-uTHT_Ps-9vS3Pw@mail.gmail.com>
References: <1347939042.15578.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347939042.15578.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 18, 2012 at 11:30 AM, Axel Lin <axel.lin@gmail.com> wrote:
> This fixes below build error when CONFIG_LEDS_CLASS is not set.
>
>   LD      init/built-in.o
> arch/arm/plat-omap/built-in.o: In function `fpga_probe':
> arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
> make: *** [vmlinux] Error 1
>

Thanks for posting this. But I think Tony has already fixed it in mainline:
--
commit 359f64f7b3997e94ee71039b5fcdc1278b9b77c4
Author: Tony Lindgren <tony@atomide.com>
Date:   Wed Sep 15 10:18:51 2010 -0700

    omap: Fix compile dependency to LEDS_CLASS

    If we LEDS_CLASS is not selected, we will get undefined reference
    to `led_classdev_register'.

    Signed-off-by: Tony Lindgren <tony@atomide.com>
--

-Bryan

> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  arch/arm/plat-omap/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index ca83a76..c262781 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -43,6 +43,7 @@ config OMAP_DEBUG_DEVICES
>
>  config OMAP_DEBUG_LEDS
>         def_bool y if NEW_LEDS
> +       select LEDS_CLASS
>         depends on OMAP_DEBUG_DEVICES
>
>  config POWER_AVS_OMAP
> --
> 1.7.9.5
>
>
>



-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer    +86.186-168-78255 Mobile
Canonical Ltd.      www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
