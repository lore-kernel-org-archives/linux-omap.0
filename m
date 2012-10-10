From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP: resolve sparse warning concerning debug_card_init()
Date: Wed, 10 Oct 2012 09:01:10 +0200
Message-ID: <50751D36.9020001@compulab.co.il>
References: <alpine.DEB.2.00.1210092028080.5736@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:38078 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870Ab2JJHBQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Oct 2012 03:01:16 -0400
In-Reply-To: <alpine.DEB.2.00.1210092028080.5736@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On 10/09/12 22:29, Paul Walmsley wrote:
> 
> Commit 801475ccb2b2c1928b22aec4b9e5285d9e347602 ("ARM: OMAP: move
> debug_card_init() function") results in the following new sparse
> warning:
> 
> arch/arm/plat-omap/debug-devices.c:71:12: warning: symbol 'debug_card_init' was not declared. Should it be static?
> 
> Fix by implementing Tony's suggestion to add a "sideways include" to the
> new location of the debug-devices.h file in arch/arm/mach-omap2/.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Igor Grinberg <grinberg@compulab.co.il>
> Cc: Tony Lindgren <tony@atomide.com>

Acked-by: Igor Grinberg <grinberg@compulab.co.il>

> ---
>  arch/arm/plat-omap/debug-devices.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/plat-omap/debug-devices.c b/arch/arm/plat-omap/debug-devices.c
> index c7a4c09..5a4678e 100644
> --- a/arch/arm/plat-omap/debug-devices.c
> +++ b/arch/arm/plat-omap/debug-devices.c
> @@ -16,6 +16,7 @@
>  #include <linux/smc91x.h>
>  
>  #include <mach/hardware.h>
> +#include "../mach-omap2/debug-devices.h"
>  
>  /* Many OMAP development platforms reuse the same "debug board"; these
>   * platforms include H2, H3, H4, and Perseus2.

-- 
Regards,
Igor.
