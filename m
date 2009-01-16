From: "roel kluin" <roel.kluin@gmail.com>
Subject: Re: [PATCH 01/10] omap mailbox: cleanup omap2 register definition with macro
Date: Fri, 16 Jan 2009 10:56:01 +0100
Message-ID: <25e057c00901160156w6058ade2j9c99ef727d8767ab@mail.gmail.com>
References: <20090116081919.17571.34378.stgit@oreo.research.nokia.com>
	 <20090116082706.17571.31102.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:45196 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761577AbZAPJ4E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 04:56:04 -0500
In-Reply-To: <20090116082706.17571.31102.stgit@oreo.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

2009/1/16 Hiroshi DOYU <Hiroshi.DOYU@nokia.com>:
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>
>  arch/arm/mach-omap2/mailbox.c |   77 +++++++++++++++--------------------------
>  1 files changed, 29 insertions(+), 48 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index 32b7af3..0609e2d 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c

> @@ -18,40 +18,19 @@
>  #include <mach/mailbox.h>
>  #include <mach/irqs.h>
>
> -#define MAILBOX_REVISION               0x00
> -#define MAILBOX_SYSCONFIG              0x10
> -#define MAILBOX_SYSSTATUS              0x14
> -#define MAILBOX_MESSAGE_0              0x40
> -#define MAILBOX_MESSAGE_1              0x44
> -#define MAILBOX_MESSAGE_2              0x48
> -#define MAILBOX_MESSAGE_3              0x4c
> -#define MAILBOX_MESSAGE_4              0x50
> -#define MAILBOX_MESSAGE_5              0x54
> -#define MAILBOX_FIFOSTATUS_0           0x80
> -#define MAILBOX_FIFOSTATUS_1           0x84
> -#define MAILBOX_FIFOSTATUS_2           0x88
> -#define MAILBOX_FIFOSTATUS_3           0x8c
> -#define MAILBOX_FIFOSTATUS_4           0x90
> -#define MAILBOX_FIFOSTATUS_5           0x94
> -#define MAILBOX_MSGSTATUS_0            0xc0
> -#define MAILBOX_MSGSTATUS_1            0xc4
> -#define MAILBOX_MSGSTATUS_2            0xc8
> -#define MAILBOX_MSGSTATUS_3            0xcc
> -#define MAILBOX_MSGSTATUS_4            0xd0
> -#define MAILBOX_MSGSTATUS_5            0xd4
> -#define MAILBOX_IRQSTATUS_0            0x100
> -#define MAILBOX_IRQENABLE_0            0x104
> -#define MAILBOX_IRQSTATUS_1            0x108
> -#define MAILBOX_IRQENABLE_1            0x10c
> -#define MAILBOX_IRQSTATUS_2            0x110
> -#define MAILBOX_IRQENABLE_2            0x114
> -#define MAILBOX_IRQSTATUS_3            0x118
> -#define MAILBOX_IRQENABLE_3            0x11c
> +#define MAILBOX_REVISION               0x000
> +#define MAILBOX_SYSCONFIG              0x010
> +#define MAILBOX_SYSSTATUS              0x014
> +#define MAILBOX_MESSAGE(m)             (0x040 + 4 * (m))
> +#define MAILBOX_FIFOSTATUS(m)          (0x080 + 4 * (m))
> +#define MAILBOX_MSGSTATUS(m)           (0x0c0 + 4 * (m))
> +#define MAILBOX_IRQSTATUS(u)           (0x100 + 8 * (u))
> +#define MAILBOX_IRQENABLE(u)           (0x108 + 8 * (u))
                                                                  ^^^^^^^
shouldn't this be
#define MAILBOX_IRQENABLE(u)           (0x104 + 8 * (u))

>
> -static unsigned long mbox_base;
> +#define MAILBOX_IRQ_NEWMSG(u)          (1 << (2 * (u)))
> +#define MAILBOX_IRQ_NOTFULL(u)         (1 << (2 * (u) + 1))
>
> -#define MAILBOX_IRQ_NOTFULL(n)         (1 << (2 * (n) + 1))
> -#define MAILBOX_IRQ_NEWMSG(n)          (1 << (2 * (n)))
> +static unsigned long mbox_base;
>
>  struct omap_mbox2_fifo {
>        unsigned long msg;
