From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 10/21] ARM: OMAP: McBSP: Coding style cleanup on arch/arm/plat-omap/mcbsp.c
Date: Sat, 14 Jun 2008 09:19:40 +0100
Message-ID: <20080614081940.GL32122@flint.arm.linux.org.uk>
References: <1212802253-17797-2-git-send-email-tony@atomide.com> <1212802253-17797-3-git-send-email-tony@atomide.com> <1212802253-17797-4-git-send-email-tony@atomide.com> <1212802253-17797-5-git-send-email-tony@atomide.com> <1212802253-17797-6-git-send-email-tony@atomide.com> <1212802253-17797-7-git-send-email-tony@atomide.com> <1212802253-17797-8-git-send-email-tony@atomide.com> <1212802253-17797-9-git-send-email-tony@atomide.com> <1212802253-17797-10-git-send-email-tony@atomide.com> <1212802253-17797-11-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58653 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498AbYFNIT4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Jun 2008 04:19:56 -0400
Content-Disposition: inline
In-Reply-To: <1212802253-17797-11-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Eduardo Valentin <eduardo.valentin@indt.org.br>, linux-omap@vger.kernel.org

On Fri, Jun 06, 2008 at 06:30:42PM -0700, Tony Lindgren wrote:
> From: Eduardo Valentin <eduardo.valentin@indt.org.br>
> 
> This patch fix lots of warnings and errors reported by
> scripts/checkpatch.pl on arch/arm/plat-omap/mcbsp.c.
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index 9cf83c4..053de31 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -21,9 +21,8 @@
>  #include <linux/err.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> -
> -#include <asm/io.h>
> -#include <asm/irq.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>

checkpatch isn't always right.  In the case of linux/irq.h vs asm/irq.h
they are not equivalent.  linux/irq.h is the genirq header file.  asm/irq.h
is the architecture irq.h file.  The two are quite different (unlike the
linux/io.h and asm/io.h case.)

Unless you're doing something with static IRQ numbers, you shouldn't need
either of these irq.h headers - the one you generally want for drivers is
linux/interrupt.h.
