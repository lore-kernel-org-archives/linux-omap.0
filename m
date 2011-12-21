From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH] ARM: remove header files included more than once
Date: Wed, 21 Dec 2011 13:10:23 +0900
Message-ID: <061b01ccbf96$763f95e0$62bec1a0$%kim@samsung.com>
References: <1323447943-23595-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:10705 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab1LUEK0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Dec 2011 23:10:26 -0500
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LWJ0032RCXDZTC0@mailout3.samsung.com> for
 linux-omap@vger.kernel.org; Wed, 21 Dec 2011 13:10:25 +0900 (KST)
Received: from DOKGENEKIM03 ([12.23.120.114])
 by mmp1.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0LWJ002H4CXBYJ00@mmp1.samsung.com>
 for linux-omap@vger.kernel.org; Wed, 21 Dec 2011 13:10:25 +0900 (KST)
In-reply-to: <1323447943-23595-1-git-send-email-omar.ramirez@ti.com>
Content-language: ko
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Omar Ramirez Luna' <omar.ramirez@ti.com>, 'Russell King' <linux@arm.linux.org.uk>
Cc: 'Jiandong Zheng' <jdzheng@broadcom.com>, 'Scott Branden' <sbranden@broadcom.com>, 'David Brown' <davidb@codeaurora.org>, 'Daniel Walker' <dwalker@fifo99.com>, 'Bryan Huntsman' <bryanh@codeaurora.org>, 'Tony Lindgren' <tony@atomide.com>, 'Benoit Cousson' <b-cousson@ti.com>, 'Eric Miao' <eric.y.miao@gmail.com>, 'Paul Mundt' <lethal@linux-sh.org>, 'Magnus Damm' <magnus.damm@gmail.com>, 'Srinidhi Kasagar' <srinidhi.kasagar@stericsson.com>, 'Linus Walleij' <linus.walleij@stericsson.com>, 'Paul Walmsley' <paul@pwsan.com>, 'Ben Dooks' <ben-linux@fluff.org>, 'Simtec Linux Team' <linux@simtec.co.uk>, 'Daniel Silverstone' <dsilvers@simtec.co.uk>, 'Stephen Boyd' <sboyd@codeaurora.org>, 'Krzysztof Halasa' <khc@pm.waw.pl>, 'Lei Wen' <leiwen@marvell.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Omar Ramirez Luna wrote:
> 
> checkincludes.pl complains about these:
> 	linux/debugfs.h
> 	linux/dma-mapping.h
> 	linux/gpio.h
> 	linux/sched.h
> 	linux/slab.h
> 	plat/common.h
> 	plat/i2c.h
> 
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
>  arch/arm/mach-bcmring/dma.c                 |    1 -
>  arch/arm/mach-ks8695/leds.c                 |    1 -
>  arch/arm/mach-mmp/aspenite.c                |    1 -
>  arch/arm/mach-mmp/tavorevb.c                |    1 -
>  arch/arm/mach-msm/board-msm7x30.c           |    1 -
>  arch/arm/mach-msm/board-qsd8x50.c           |    1 -
>  arch/arm/mach-omap2/board-ldp.c             |    1 -
>  arch/arm/mach-omap2/io.c                    |    1 -
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c  |    1 -
>  arch/arm/mach-pxa/pxa25x.c                  |    1 -
>  arch/arm/mach-pxa/pxa27x.c                  |    1 -
>  arch/arm/mach-pxa/saarb.c                   |    1 -
>  arch/arm/mach-shmobile/board-ag5evm.c       |    1 -
>  arch/arm/mach-ux500/board-mop500-u8500uib.c |    1 -
>  arch/arm/plat-omap/clock.c                  |    1 -
>  arch/arm/plat-samsung/dev-backlight.c       |    1 -
>  16 files changed, 0 insertions(+), 16 deletions(-)
> 

(snip)

> diff --git a/arch/arm/plat-samsung/dev-backlight.c
b/arch/arm/plat-samsung/dev-backlight.c
> index e657305..a976c02 100644
> --- a/arch/arm/plat-samsung/dev-backlight.c
> +++ b/arch/arm/plat-samsung/dev-backlight.c
> @@ -15,7 +15,6 @@
>  #include <linux/slab.h>
>  #include <linux/io.h>
>  #include <linux/pwm_backlight.h>
> -#include <linux/slab.h>
> 
>  #include <plat/devs.h>
>  #include <plat/gpio-cfg.h>
> --
> 1.7.4.1

Hi,

Above has been already fixed in mainline.
:commit d7a4c45ec24b6c6773ff302c3c9cb5ed46c8e211 ("ARM: SAMSUNG: remove
duplicated header include").

Anyway, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

