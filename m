From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP4: I2C : I2C context save
Date: Thu, 14 Jul 2011 08:52:46 -0700
Message-ID: <87zkkgoo4x.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:58792 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754639Ab1GNPwv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jul 2011 11:52:51 -0400
References: 
In-Reply-To: 1309933145-8825-1-git-send-email-shubhrajyoti@ti.com
	(Shubhrajyoti D.'s message of "2011-07-06 6:31:05")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> Restore of context is not done for OMAP4. This patch 

Subject says context *save*, here says context *restore.*

> adds the OMAP_I2C_FLAG_RESET_REGS_POSTIDLE in the OMAP4
> hwmod which activates the restore for OMAP4.

s/hwmod/hwmod data/

> Currently the OMAP4 doesnot hit device off still the

s/doesnot/does not/

> driver may have support for it.

Also, since this is a patch to the hwmod data, the subject
prefix should be something like:

OMAP4: hwmod_data: I2C: set flag to restore context

or something similar.

Also, this is the 2nd (or maybe 3rd) version of this patch posted.
Please version the patch using [PATCH vN].

Kevin

> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> Applies on top of patches from Andy Green
> http://www.spinics.net/lists/linux-i2c/msg05632.html
> Tested on OMAP4430
>
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 0fe9556..5e2c748 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -2130,7 +2130,8 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
>  };
>  
>  static struct omap_i2c_dev_attr i2c_dev_attr = {
> -	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE,
> +	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE |
> +			OMAP_I2C_FLAG_RESET_REGS_POSTIDLE,
>  };
>  
>  /* i2c1 */
