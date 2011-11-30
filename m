From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V4 3/3] arm:omap:am33xx: Add low level debugging support
Date: Wed, 30 Nov 2011 15:33:29 -0800
Message-ID: <87r50pxk1i.fsf@ti.com>
References: <1320946837-32507-1-git-send-email-hvaibhav@ti.com>
	<1320946837-32507-4-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:51338 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752599Ab1K3Xde (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Nov 2011 18:33:34 -0500
Received: by mail-gy0-f178.google.com with SMTP id f1so1257183ghb.9
        for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 15:33:33 -0800 (PST)
In-Reply-To: <1320946837-32507-4-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Thu, 10 Nov 2011 23:10:37 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, Afzal Mohammed <afzal@ti.com>

Hi Vaibhav,

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> From: Afzal Mohammed <afzal@ti.com>
>
> Add support for low level debugging on AM335X EVM (AM33XX family).
> Currently only support for UART1 console, which is used on AM335X EVM
> is added.
>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

One minor comment below...

> ---
>  arch/arm/mach-omap2/include/mach/debug-macro.S |   17 ++++++++++++++++-
>  arch/arm/plat-omap/include/plat/serial.h       |    4 ++++
>  arch/arm/plat-omap/include/plat/uncompress.h   |    6 ++++++
>  3 files changed, 26 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
> index 13f98e5..ce543ae 100644
> --- a/arch/arm/mach-omap2/include/mach/debug-macro.S
> +++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
> @@ -72,6 +72,8 @@ omap_uart_lsr:	.word	0
>  		beq	82f			@ configure UART2
>  		cmp	\rp, #TI816XUART3	@ ti816x UART offsets different
>  		beq	83f			@ configure UART3
> +		cmp	\rp, #AM33XXUART1	@ AM33XX UART offsets different
> +		beq	84f			@ configure UART1
>  		cmp	\rp, #ZOOM_UART		@ only on zoom2/3
>  		beq	95f			@ configure ZOOM_UART
>
> @@ -100,7 +102,9 @@ omap_uart_lsr:	.word	0
>  		b	98f
>  83:		mov	\rp, #UART_OFFSET(TI816X_UART3_BASE)
>  		b	98f
> -
> +84:		ldr	\rp, =AM33XX_UART1_BASE
> +		and	\rp, \rp, #0x00ffffff
> +		b	97f
>  95:		ldr	\rp, =ZOOM_UART_BASE
>  		str	\rp, [\tmp, #0]		@ omap_uart_phys
>  		ldr	\rp, =ZOOM_UART_VIRT
> @@ -110,6 +114,17 @@ omap_uart_lsr:	.word	0
>  		b	10b
>
>  		/* Store both phys and virt address for the uart */

Please update this comment to clarify that this block is for AM33xx
only, and update the following one as the catch all.

> +97:		add	\rp, \rp, #0x44000000	@ phys base
> +		str	\rp, [\tmp, #0]		@ omap_uart_phys
> +		sub	\rp, \rp, #0x44000000	@ phys base
> +		add	\rp, \rp, #0xf9000000	@ virt base
> +		str	\rp, [\tmp, #4]		@ omap_uart_virt
> +		mov	\rp, #(UART_LSR << OMAP_PORT_SHIFT)
> +		str	\rp, [\tmp, #8]		@ omap_uart_lsr

The last 3 lines are unnecessarily duplicated.  They can be shared with
the common block that follows.  IOW, only the base addresses are
different, the rest of the operations are shared.

> +		b	10b
> +
> +		/* Store both phys and virt address for the uart */
>  98:		add	\rp, \rp, #0x48000000	@ phys base
>  		str	\rp, [\tmp, #0]		@ omap_uart_phys
>  		sub	\rp, \rp, #0x48000000	@ phys base

Kevin
