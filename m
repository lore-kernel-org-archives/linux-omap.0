From: Samuel Ortiz <sameo@openedhand.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: Fix missing includes
Date: Sat, 10 Jan 2009 16:56:12 +0100
Message-ID: <20090110155612.GA2601@sortiz.org>
References: <20090107111415.GF27566@atomide.com> <20090107111615.GG27566@atomide.com>
Reply-To: Samuel Ortiz <sameo@openedhand.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 3a.49.1343.static.theplanet.com ([67.19.73.58]:58707 "EHLO
	pug.o-hand.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751733AbZAJPxj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 10 Jan 2009 10:53:39 -0500
Content-Disposition: inline
In-Reply-To: <20090107111615.GG27566@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>

Hi Tony,

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
That will break the build on !ARM for this driver.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
