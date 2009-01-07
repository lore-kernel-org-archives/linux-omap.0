From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap mmc: remove duplicated #include's
Date: Wed, 7 Jan 2009 16:04:56 +0200
Message-ID: <20090107140455.GP27566@atomide.com>
References: <20090104110120.C99F.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52536 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbZAGOE6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 09:04:58 -0500
Content-Disposition: inline
In-Reply-To: <20090104110120.C99F.WEIYI.HUANG@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Huang Weiyi <weiyi.huang@gmail.com>
Cc: linux-omap@vger.kernel.org

* Huang Weiyi <weiyi.huang@gmail.com> [090104 05:13]:
> Removed duplicated #include's in arch/arm/mach-omap1/board-voiceblue.c

Thanks, pushing to linux-omap tree and adding to omap-fixes queue
for mainline kernel.

Tony


> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
> 
> diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
> index c224f3c..a765354 100644
> --- a/arch/arm/mach-omap1/board-voiceblue.c
> +++ b/arch/arm/mach-omap1/board-voiceblue.c
> @@ -22,7 +22,6 @@
>  #include <linux/reboot.h>
>  #include <linux/serial_8250.h>
>  #include <linux/serial_reg.h>
> -#include <linux/irq.h>
> 
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> 
