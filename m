From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.28-rc2-omap] board-h4 buildfix
Date: Wed, 29 Oct 2008 10:50:50 -0700
Message-ID: <20081029175049.GH20456@atomide.com>
References: <200810290010.09673.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56909 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660AbYJ2Ruw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 13:50:52 -0400
Content-Disposition: inline
In-Reply-To: <200810290010.09673.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081029 00:11]:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Let's build again, like we did last summer!
> http://www.chezmaya.com/05/3/lets_twist.htm
> 
> (The legacy ov9640 camera sensor code and header is gone.)

Pushed.

Tony

> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  arch/arm/mach-omap2/board-h4.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- a/arch/arm/mach-omap2/board-h4.c
> +++ b/arch/arm/mach-omap2/board-h4.c
> @@ -48,7 +48,6 @@
>  
>  #include <asm/io.h>
>  
> -#include <../drivers/media/video/ov9640.h>
>  
>  #define H4_FLASH_CS	0
>  #define H4_SMC91X_CS	1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
