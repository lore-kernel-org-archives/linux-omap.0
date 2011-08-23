From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 02/22] gpio/omap: use flag to identify wakeup domain
Date: Tue, 23 Aug 2011 18:11:10 +0530
Message-ID: <4E539FE6.2090007@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com> <1312455893-14922-3-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:46350 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752890Ab1HWMlR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 08:41:17 -0400
Received: by mail-yw0-f47.google.com with SMTP id 12so41814ywa.20
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 05:41:17 -0700 (PDT)
In-Reply-To: <1312455893-14922-3-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> From: Charulatha V<charu@ti.com>
>
> In omap3, save/restore context is implemented for GPIO banks 2-6 as GPIO bank1
> is in wakeup domain. Instead of identifying bank's power domain by bank id,
> use 'loses_context' flag which is filled by pwrdm_can_ever_lose_context()
> during dev_init.
>
> For getting the powerdomain pointer, omap_hwmod_get_pwrdm() is used.
> omap_device_get_pwrdm() could not be used as the pwrdm information needs to be
> filled in pdata, whereas omap_device_get_pwrdm() could be used only after
> omap_device_build() call.
>
> Signed-off-by: Charulatha V<charu@ti.com>
> ---
>   arch/arm/mach-omap2/gpio.c             |    6 ++++++
>   arch/arm/plat-omap/include/plat/gpio.h |    1 +
>   drivers/gpio/gpio-omap.c               |   13 ++++++-------
>   3 files changed, 13 insertions(+), 7 deletions(-)
>
Nice change.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
