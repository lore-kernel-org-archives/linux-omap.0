From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH] ARM: remove header files included more than once
Date: Mon, 12 Dec 2011 09:10:28 +0800
Message-ID: <CAN1soZyaDO1dFTuG-5AgNGEHua6pi_W7VQ24yxyV1+dadK-vdQ@mail.gmail.com>
References: <1323447943-23595-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37204 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618Ab1LLBK3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Dec 2011 20:10:29 -0500
Received: by vcbfk14 with SMTP id fk14so3391697vcb.19
        for <linux-omap@vger.kernel.org>; Sun, 11 Dec 2011 17:10:28 -0800 (PST)
In-Reply-To: <1323447943-23595-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, Daniel Walker <dwalker@fifo99.com>, Kukjin Kim <kgene.kim@samsung.com>, Magnus Damm <magnus.damm@gmail.com>, David Brown <davidb@codeaurora.org>, Daniel Silverstone <dsilvers@simtec.co.uk>, Lei Wen <leiwen@marvell.com>, Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, Simtec Linux Team <linux@simtec.co.uk>, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@stericsson.com>, Paul Walmsley <paul@pwsan.com>, Eric Miao <eric.y.miao@gmail.com>, Benoit Cousson <b-cousson@ti.com>, Scott Branden <sbranden@broadcom.com>, Stephen Boyd <sboyd@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Paul Mundt <lethal@linux-sh.org>, Jiandong Zheng <jdzheng@broadcom.com>, Krzysztof Halasa <khc@pm.waw.pl>

On Sat, Dec 10, 2011 at 12:25 AM, Omar Ramirez Luna <omar.ramirez@ti.co=
m> wrote:
> checkincludes.pl complains about these:
> =A0 =A0 =A0 =A0linux/debugfs.h
> =A0 =A0 =A0 =A0linux/dma-mapping.h
> =A0 =A0 =A0 =A0linux/gpio.h
> =A0 =A0 =A0 =A0linux/sched.h
> =A0 =A0 =A0 =A0linux/slab.h
> =A0 =A0 =A0 =A0plat/common.h
> =A0 =A0 =A0 =A0plat/i2c.h
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
> =A0arch/arm/mach-bcmring/dma.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A01 -
> =A0arch/arm/mach-ks8695/leds.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A01 -
> =A0arch/arm/mach-mmp/aspenite.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A01 -
> =A0arch/arm/mach-mmp/tavorevb.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A01 -
> =A0arch/arm/mach-msm/board-msm7x30.c =A0 =A0 =A0 =A0 =A0 | =A0 =A01 -
> =A0arch/arm/mach-msm/board-qsd8x50.c =A0 =A0 =A0 =A0 =A0 | =A0 =A01 -
> =A0arch/arm/mach-omap2/board-ldp.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01=
 -
> =A0arch/arm/mach-omap2/io.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A01 -
> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c =A0| =A0 =A01 -
> =A0arch/arm/mach-pxa/pxa25x.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A01 -
> =A0arch/arm/mach-pxa/pxa27x.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A01 -
> =A0arch/arm/mach-pxa/saarb.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A01 -
> =A0arch/arm/mach-shmobile/board-ag5evm.c =A0 =A0 =A0 | =A0 =A01 -
> =A0arch/arm/mach-ux500/board-mop500-u8500uib.c | =A0 =A01 -
> =A0arch/arm/plat-omap/clock.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A01 -
> =A0arch/arm/plat-samsung/dev-backlight.c =A0 =A0 =A0 | =A0 =A01 -
> =A016 files changed, 0 insertions(+), 16 deletions(-)
>

Hi Omar,

Thanks for your patch. Could you help to split your patches into small
pieces? Since different people are handling for different files. For
example, I can help to handle files in arch-pxa. But I can't handle
other files.

Best Regards
Haojian
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
