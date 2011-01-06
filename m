From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4430SDP boot failure
Date: Thu, 6 Jan 2011 12:34:32 -0800
Message-ID: <20110106203431.GZ7771@atomide.com>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk>
 <20110106180030.GA8249@n2100.arm.linux.org.uk>
 <20110106182023.GV7771@atomide.com>
 <20110106195225.GX7771@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:45975 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab1AFUeo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 15:34:44 -0500
Content-Disposition: inline
In-Reply-To: <20110106195225.GX7771@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [110106 11:52]:
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -71,6 +71,23 @@ wait:		mrc	p14, 0, pc, c0, c1, 0
>  		mov	\rb, #0x50000000
>  		add	\rb, \rb, #0x4000 * CONFIG_S3C_LOWLEVEL_UART_PORT
>  		.endm
> +#elif defined(CONFIG_ARCH_OMAP2PLUS)
> +#include <plat/multi.h>
> +#ifdef MULTI_OMAP2)
                     ^
Looks like my last change to this patch from if defined to ifdef
broke the warning above with an unbalanced bracket..

Thanks Nishant for catching that, updated patch below.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Thu, 6 Jan 2011 11:29:39 -0800
Subject: [PATCH] ARM: Fix low-level decompress debug code for omap

If DEBUG is enabled for decompress code, the system will hang
as the debug UART is not specified. Fix this by adding the
necessary code for omap2plus.

Note that this won't work properly with multi-omap support
compiled in. Also the debug UART used needs to be patched
in if not omap UART3.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -71,6 +71,23 @@ wait:		mrc	p14, 0, pc, c0, c1, 0
 		mov	\rb, #0x50000000
 		add	\rb, \rb, #0x4000 * CONFIG_S3C_LOWLEVEL_UART_PORT
 		.endm
+#elif defined(CONFIG_ARCH_OMAP2PLUS)
+#include <plat/multi.h>
+#ifdef MULTI_OMAP2
+#error Low-level uncompress debug code won't work with multi-omap
+#elif defined(CONFIG_ARCH_OMAP2)
+		.macro loadsp, rb, tmp
+		ldr	\rb, =OMAP2_UART3_BASE	/* patch accordingly */
+		.endm
+#elif defined(CONFIG_ARCH_OMAP3)
+		.macro loadsp, rb, tmp
+		ldr	\rb, =OMAP3_UART3_BASE	/* patch accordingly */
+		.endm
+#elif defined(CONFIG_ARCH_OMAP4)
+		.macro loadsp, rb, tmp
+		ldr	\rb, =OMAP4_UART3_BASE	/* patch accordingly */
+		.endm
+#endif
 #else
 		.macro	loadsp,	rb, tmp
 		addruart \rb, \tmp
