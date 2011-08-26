From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v14 REPOST 04/12] OMAP2+: dmtimer: convert to platform
 devices
Date: Fri, 26 Aug 2011 20:03:03 +0530
Message-ID: <4E57AE9F.7070907@ti.com>
References: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com> <1310731501-13078-5-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:40678 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750868Ab1HZOdM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Aug 2011 10:33:12 -0400
Received: by mail-gw0-f53.google.com with SMTP id 20so3887736gwj.40
        for <linux-omap@vger.kernel.org>; Fri, 26 Aug 2011 07:33:11 -0700 (PDT)
In-Reply-To: <1310731501-13078-5-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Thara Gopinath <thara@ti.com>

On Friday 15 July 2011 05:34 PM, Tarun Kanti DebBarma wrote:
> Add routines to converts dmtimers to platform devices. The device data
> is obtained from hwmod database of respective platform and is registered
> to device model after successful binding to driver.
> In addition, capability attribute of each of the timers is added in
> hwmod database.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> Signed-off-by: Thara Gopinath<thara@ti.com>
> Acked-by: Cousson, Benoit<b-cousson@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_2420_data.c |   22 +++++
>   arch/arm/mach-omap2/omap_hwmod_2430_data.c |   22 +++++
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   27 ++++++
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   21 +++++
>   arch/arm/mach-omap2/timer.c                |  136 ++++++++++++++++++++++++++++
>   arch/arm/plat-omap/include/plat/dmtimer.h  |   10 ++-
>   6 files changed, 237 insertions(+), 1 deletions(-)
>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh

