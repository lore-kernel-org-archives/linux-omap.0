From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix compile error in usb-musb.c
Date: Fri, 16 Jan 2009 09:29:04 +0200
Message-ID: <20090116072904.GN4128@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815B88@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64851 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137AbZAPH3D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 02:29:03 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815B88@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Brownell <david-b@pacbell.net>

* Gadiyar, Anand <gadiyar@ti.com> [090115 20:48]:
> From: Anand Gadiyar <gadiyar@ti.com>
> 
> Fix this compile error

This one should go via the usb list too.

Acked-by: Tony Lindgren <tony@atomide.com>


>   CC      arch/arm/mach-omap2/usb-musb.o
> arch/arm/mach-omap2/usb-musb.c:47: error: 'INT_243X_HS_USB_MC' undeclared here (not in a function)
> arch/arm/mach-omap2/usb-musb.c:51: error: 'INT_243X_HS_USB_DMA' undeclared here (not in a function)
> make[1]: *** [arch/arm/mach-omap2/usb-musb.o] Error 1
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Reported-by: David Brownell <david-b@pacbell.net>
> ---
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
> index 61c5709..5d79f89 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -28,6 +28,7 @@
>  #include <linux/usb/musb.h>
>  
>  #include <mach/hardware.h>
> +#include <mach/irqs.h>
>  #include <mach/pm.h>
>  #include <mach/mux.h>
>  #include <mach/usb.h>
