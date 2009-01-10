From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] ARM: OMAP: Fix missing includes
Date: Sat, 10 Jan 2009 10:57:40 +0000
Message-ID: <20090110105740.GA28945@n2100.arm.linux.org.uk>
References: <20090107111415.GF27566@atomide.com> <20090107111615.GG27566@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60726 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbZAJK5v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Jan 2009 05:57:51 -0500
Content-Disposition: inline
In-Reply-To: <20090107111615.GG27566@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Wed, Jan 07, 2009 at 01:16:15PM +0200, Tony Lindgren wrote:
> diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.c
> index b59c385..18179ac 100644
> --- a/drivers/mfd/twl4030-core.c
> +++ b/drivers/mfd/twl4030-core.c
> @@ -38,6 +38,7 @@
>  #include <linux/i2c.h>
>  #include <linux/i2c/twl4030.h>
>  
> +#include <mach/cpu.h>

This really needs the clock API usage fixing, rather than fixing it
like this.  I want to see the OMAP clock API getting fixed ASAP.
For the time being, I'm going to add a comment about it into this file.
