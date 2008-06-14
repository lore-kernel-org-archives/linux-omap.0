From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 19/21] ARM: OMAP: Introduce omap_globals and prcm access functions for multi-omap
Date: Sat, 14 Jun 2008 10:09:25 +0100
Message-ID: <20080614090925.GP32122@flint.arm.linux.org.uk>
References: <1212802253-17797-11-git-send-email-tony@atomide.com> <1212802253-17797-12-git-send-email-tony@atomide.com> <1212802253-17797-13-git-send-email-tony@atomide.com> <1212802253-17797-14-git-send-email-tony@atomide.com> <1212802253-17797-15-git-send-email-tony@atomide.com> <1212802253-17797-16-git-send-email-tony@atomide.com> <1212802253-17797-17-git-send-email-tony@atomide.com> <1212802253-17797-18-git-send-email-tony@atomide.com> <1212802253-17797-19-git-send-email-tony@atomide.com> <1212802253-17797-20-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50144 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754332AbYFNJJh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Jun 2008 05:09:37 -0400
Content-Disposition: inline
In-Reply-To: <1212802253-17797-20-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Fri, Jun 06, 2008 at 06:30:51PM -0700, Tony Lindgren wrote:
> @@ -51,7 +50,7 @@ u32 omap_ctrl_readl(u16 offset)
>  void omap_ctrl_writeb(u8 val, u16 offset)
>  {
>  	pr_debug("omap_ctrl_writeb: writing 0x%0x to 0x%0x\n", val,
> -		 (u32)OMAP_CTRL_REGADDR(offset));
> +		 (__force u32)OMAP_CTRL_REGADDR(offset));

Casting to unsigned long avoids the need for __force.  __force should be
used sparingly.  Alternatively, use '%p' to print a pointer.

Apart from that, ok.
