From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.28-rc3-omap git] cbus build fixes
Date: Thu, 13 Nov 2008 13:43:35 -0800
Message-ID: <20081113214334.GH3106@atomide.com>
References: <200811052313.52300.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62240 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbYKMVnh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 16:43:37 -0500
Content-Disposition: inline
In-Reply-To: <200811052313.52300.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081105 23:14]:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Build fixes for CBUS stuff.

Pushing today.

Tony

> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  drivers/cbus/cbus.c  |    1 +
>  drivers/cbus/retu.c  |    1 +
>  drivers/cbus/tahvo.c |    1 +
>  3 files changed, 3 insertions(+)
> 
> --- a/drivers/cbus/cbus.c
> +++ b/drivers/cbus/cbus.c
> @@ -31,6 +31,7 @@
>  
>  #include <mach/gpio.h>
>  #include <mach/board.h>
> +#include <mach/board-nokia.h>
>  
>  #include <asm/io.h>
>  
> --- a/drivers/cbus/retu.c
> +++ b/drivers/cbus/retu.c
> @@ -41,6 +41,7 @@
>  #include <mach/mux.h>
>  #include <mach/gpio.h>
>  #include <mach/board.h>
> +#include <mach/board-nokia.h>
>  
>  #include "cbus.h"
>  #include "retu.h"
> --- a/drivers/cbus/tahvo.c
> +++ b/drivers/cbus/tahvo.c
> @@ -41,6 +41,7 @@
>  #include <mach/mux.h>
>  #include <mach/gpio.h>
>  #include <mach/board.h>
> +#include <mach/board-nokia.h>
>  
>  #include "cbus.h"
>  #include "tahvo.h"
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
