From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] [PATCH] mfd: twl4030: Fix mismatch in mutex
 lock-unlock
Date: Sat, 9 Jul 2011 08:51:24 +0200
Message-ID: <20110709085124.401dba10@endymion.delvare>
References: <1310129879-4748-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:22840 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278Ab1GIGvl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Jul 2011 02:51:41 -0400
In-Reply-To: <1310129879-4748-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: lm-sensors@lm-sensors.org, linux-omap@vger.kernel.org

On Fri, 8 Jul 2011 18:27:59 +0530, Sanjeev Premi wrote:
> A mutex is locked on entry into twl4030_madc_conversion().
> Immediate return on some error conditions leaves the
> mutex locked.
> 
> This patch ensures that mutex is always unlocked before
> leaving the function.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> Cc: Keerthy <j-keerthy@ti.com>
> ---
> 
>  Compile tested only.
> 
> 
>  drivers/mfd/twl4030-madc.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/twl4030-madc.c b/drivers/mfd/twl4030-madc.c
> index 3941ddc..b5d598c 100644
> --- a/drivers/mfd/twl4030-madc.c
> +++ b/drivers/mfd/twl4030-madc.c
> (...)

Wrong list. This isn't a hwmon driver, so lm-sensors isn't suitable.
scripts/get_maintainer.pl says that you should send this patch to:
Samuel Ortiz <sameo@linux.intel.com>

Thanks,
-- 
Jean Delvare
