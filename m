From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 7/8] gpio/omap: remove cpu_is_omapxxxx() checks from *_runtime_resume()
Date: Thu, 03 May 2012 16:45:06 +0530
Message-ID: <4FA268BA.2040804@ti.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com> <1335536018-16004-8-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:36939 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754720Ab2ECLPM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 07:15:12 -0400
Received: by obbeh20 with SMTP id eh20so3480916obb.17
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 04:15:11 -0700 (PDT)
In-Reply-To: <1335536018-16004-8-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>

On Friday 27 April 2012 07:43 PM, Tarun Kanti DebBarma wrote:
> Add register offsets for GPIO_IRQSTATUS_RAW_0, GPIO_IRQSTATUS_RAW_0
> which are present on OMAP4+ processors. Now we can distinguish
> conditions applicable to OMAP4,5 and those specific to OMAP24xx
> and OMAP3xxx.
> 
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
>  arch/arm/mach-omap2/gpio.c             |    2 ++
>  arch/arm/plat-omap/include/plat/gpio.h |    2 ++
>  drivers/gpio/gpio-omap.c               |    4 ++--
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
Looks like this was the last cpu_is_*() in gpio driver.
Thanks for cleaning up this.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
