From: Tony Lindgren <tony@atomide.com>
Subject: Re: Commit 0c8219f0... breaks omap7xx support
Date: Mon, 8 Mar 2010 16:48:32 -0800
Message-ID: <20100309004832.GK2900@atomide.com>
References: <6cb013311003062056v3ed83a53u2636838348bf4845@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52601 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756176Ab0CIArN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 19:47:13 -0500
Content-Disposition: inline
In-Reply-To: <6cb013311003062056v3ed83a53u2636838348bf4845@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, miknix@gmail.com, a.j.buxton@gmail.com, linwizard-devel@lists.sf.net

* Cory Maccarrone <darkstar6262@gmail.com> [100306 20:53]:
> All,
> 
> I've finally gotten some time to test the latest linux-omap code, and
> found the following commit:
> 
>     4f2c49fedf... omap: Clean the serial port defines
> 
> breaks current omap7xx support.  To get linux-omap master to boot, I
> had to revert that, and the three two that follow it:
> 
>     0c8219f03... omap: Make uncompress code and DEBUG_LL code generic
>     61b603b4e...omap: Remove old DEBUG_LL serial port options
> 
> in order to boot with DEBUG_LL enabled.  Disabled, I only needed to
> revert the last two.

Hmm OK thanks for bisecting this. The first patch seems to have
a bug for uncompress.h on non omap3 platforms, see the attached
patch.

Are you sure you have CONFIG_EARLY_PRINTK and earlyprintk also
in your cmdline?

> I don't know enough about that part of the kernel to debug it, so all
> I can offer is a test result.  For reference, this was on
> board-htcherald using the htcherald_defconfig settings.

Can you try the following:

- Use the current mainline kernel head
- make sure you have DEBUG_LL and EARLY_PRINTK enabled in your .config
- check that you have earlyprintk also in the kernel cmdline
- no other serial patches applied

If no serial output, please temporarily hardcode the values
for your 7xx board in mach-omap1/include/mach/debug-macro.S for
omap_uart_phys and omap_uart_virt. Maybe that will give some
more clues.

If you don't have any serial output with that, then try this:

- reset some branch to 4f2c49fedf
- make sure you have DEBUG_LL and EARLY_PRINTK enabled in your .config
- check that you have earlyprintk also in the kernel cmdline
- apply the following patch for the uncompress code

That way you might be able to track down further where things
break with the patches following 4f2c49fedf.

Regards,

Tony

--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -42,11 +42,11 @@ static void putc(int c)
 #ifdef CONFIG_ARCH_OMAP
 	/* Will get removed in the next patch, set to OMAP3 to compile */
 #ifdef	CONFIG_OMAP_LL_DEBUG_UART3
-	uart = (volatile u8 *)(OMAP3_UART3_BASE);
+	uart = (volatile u8 *)(OMAP1_UART3_BASE);
 #elif defined(CONFIG_OMAP_LL_DEBUG_UART2)
-	uart = (volatile u8 *)(OMAP3_UART2_BASE);
+	uart = (volatile u8 *)(OMAP1_UART2_BASE);
 #elif defined(CONFIG_OMAP_LL_DEBUG_UART1)
-	uart = (volatile u8 *)(OMAP3_UART1_BASE);
+	uart = (volatile u8 *)(OMAP1_UART1_BASE);
 #elif defined(CONFIG_OMAP_LL_DEBUG_NONE)
 	return;
 #else
