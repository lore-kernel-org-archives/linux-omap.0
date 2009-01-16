From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix compile error in usb-ehci.c
Date: Fri, 16 Jan 2009 09:28:24 +0200
Message-ID: <20090116072823.GM4128@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815B89@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64604 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446AbZAPH2X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 02:28:23 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815B89@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Gadiyar, Anand <gadiyar@ti.com> [090115 20:48]:
> From: Anand Gadiyar <gadiyar@ti.com>
> 
> Fix this compile error

Can you please resend via the usb list?

Acked-by: Tony Lindgren <tony@atomide.com>


>   CC      arch/arm/mach-omap2/usb-ehci.o
> arch/arm/mach-omap2/usb-ehci.c:39: error: 'INT_34XX_EHCI_IRQ' undeclared here (not in a function)
> make[1]: *** [arch/arm/mach-omap2/usb-ehci.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> ---
> diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
> index 489439d..6af0b02 100644
> --- a/arch/arm/mach-omap2/usb-ehci.c
> +++ b/arch/arm/mach-omap2/usb-ehci.c
> @@ -25,6 +25,7 @@
>  #include <linux/usb/musb.h>
>  
>  #include <mach/hardware.h>
> +#include <mach/irqs.h>
>  #include <mach/pm.h>
>  #include <mach/usb.h>
