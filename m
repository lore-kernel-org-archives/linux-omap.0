From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: EHCI: Adding back Copyright
Date: Tue, 29 Apr 2008 17:33:26 -0700
Message-ID: <20080430003326.GH8981@atomide.com>
References: <FCCFB4CDC6E5564B9182F639FC3560872F72C9E3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50680 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755617AbYD3Ad2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2008 20:33:28 -0400
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560872F72C9E3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

* Pandita, Vikram <vikram.pandita@ti.com> [080428 04:53]:
> Adding back Copyright notice that was not carried forward by a patch from Felipe.
> Copyrights should be retained without fail.

Pushing today.

Tony


> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
>  arch/arm/mach-omap2/usb-ehci.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> Index: linux-omap-2.6/arch/arm/mach-omap2/usb-ehci.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/usb-ehci.c  2008-04-28 16:39:18.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/usb-ehci.c       2008-04-28 16:44:48.000000000 +0530
> @@ -4,8 +4,11 @@
>   * This file will contain the board specific details for the
>   * Synopsys EHCI host controller on OMAP3430
>   *
> - * Copyright (C) 2008 Nokia Corporation
> - * Author: Felipe Balbi <felipe.balbi@nokia.com>
> + * Copyright (C) 2007 Texas Instruments
> + * Author: Vikram Pandita <vikram.pandita@ti.com>
> + *
> + * Generalization by:
> + * Felipe Balbi <felipe.balbi@nokia.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
