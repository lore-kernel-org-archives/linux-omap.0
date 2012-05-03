From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/8] gpio/omap: remove virtual_irq_start variable
Date: Thu, 03 May 2012 16:43:25 +0530
Message-ID: <4FA26855.3010005@ti.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com> <1335536018-16004-2-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:59296 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755309Ab2ECLNd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 07:13:33 -0400
Received: by yhnn12 with SMTP id n12so1961818yhn.24
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 04:13:31 -0700 (PDT)
In-Reply-To: <1335536018-16004-2-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>

On Friday 27 April 2012 07:43 PM, Tarun Kanti DebBarma wrote:
> This cleanup got missed while implementing following:
> 25db711 gpio/omap: Fix IRQ handling for SPARSE_IRQ
> 384ebe1 gpio/omap: Add DT support to GPIO driver
> 
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
>  arch/arm/mach-omap1/gpio15xx.c         |    2 --
>  arch/arm/mach-omap1/gpio16xx.c         |    5 -----
>  arch/arm/mach-omap1/gpio7xx.c          |    7 -------
>  arch/arm/mach-omap2/gpio.c             |    1 -
>  arch/arm/plat-omap/include/plat/gpio.h |    1 -
>  5 files changed, 0 insertions(+), 16 deletions(-)
> 
Looks good.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
