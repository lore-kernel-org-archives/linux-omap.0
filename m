From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 6/8] ARM: OMAP2/3: Change omapfb to use clkdev for
	dispc and rfbi
Date: Sat, 16 May 2009 10:06:21 +0100
Message-ID: <20090516090621.GC15328@n2100.arm.linux.org.uk>
References: <20090514174100.12080.9736.stgit@localhost> <20090514174959.12080.64417.stgit@localhost> <20090514210312.9fa02bb3.krzysztof.h1@poczta.fm> <20090514202805.GQ5593@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59008 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964AbZEPJGg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 05:06:36 -0400
Content-Disposition: inline
In-Reply-To: <20090514202805.GQ5593@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>, linux-arm-kernel@lists.arm.linux.org.uk, Imre Deak <imre.deak@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Thu, May 14, 2009 at 01:28:06PM -0700, Tony Lindgren wrote:
> commit 27db33cfadd3c47c9499def6e71aaf5d2fd51e60
> Author: Tony Lindgren <tony@atomide.com>
> Date:   Tue May 12 11:20:03 2009 -0700
> 
>     ARM: OMAP2/3: Change omapfb to use clkdev for dispc and rfbi, v2
>     
>     This makes the framebuffer work on omap3.
>     
>     Also fix the clk_get usage for checkpatch.pl
>     "ERROR: do not use assignment in if condition".
>     
>     Cc: Imre Deak <imre.deak@nokia.com>
>     Cc: linux-fbdev-devel@lists.sourceforge.net
>     Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
>     Signed-off-by: Tony Lindgren <tony@atomide.com>

This isn't a bug fix - the current code works, although checkpatch will
complain about the assignment in the if condition.

The rest of the patch is just a conversion from the old way of doing
things to the new way, and I don't think is -rc material.
