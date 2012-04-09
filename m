From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND] omap1: mux: add missing include
Date: Mon, 9 Apr 2012 11:02:54 -0700
Message-ID: <20120409180253.GA6487@atomide.com>
References: <1333916610-7451-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:13250 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756677Ab2DISC7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Apr 2012 14:02:59 -0400
Content-Disposition: inline
In-Reply-To: <1333916610-7451-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jarkko.nikula@bitmer.com

* Aaro Koskinen <aaro.koskinen@iki.fi> [120408 13:26]:
> Fix the following build breakage in v3.4-rc2:
> 
> arch/arm/mach-omap1/mux.c:89:1: error: 'FUNC_MUX_CTRL_9' undeclared here (not in a function)
> arch/arm/mach-omap1/mux.c:89:1: error: 'PULL_DWN_CTRL_2' undeclared here (not in a function)
> arch/arm/mach-omap1/mux.c:93:1: error: 'FUNC_MUX_CTRL_C' undeclared here (not in a function)
> 
> etc.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> ---
>  arch/arm/mach-omap1/mux.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
> index 087dba0..e9cc52d 100644
> --- a/arch/arm/mach-omap1/mux.c
> +++ b/arch/arm/mach-omap1/mux.c
> @@ -27,6 +27,7 @@
>  #include <linux/io.h>
>  #include <linux/spinlock.h>
>  
> +#include <mach/hardware.h>
>  
>  #include <plat/mux.h>
>  

Thanks for the repost, looks like I missed this one earlier.
Applying to fixes.

Tony
