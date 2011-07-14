From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3] OMAP4:hwmod: I2C : I2C context save
Date: Thu, 14 Jul 2011 22:06:00 +0530
Message-ID: <4E1F1AF0.2090803@ti.com>
References: <1310661218-3819-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1310661218-3819-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Please ignore the patch sent another one with correct sub line
On Thursday 14 July 2011 10:03 PM, Shubhrajyoti D wrote:

> Restore of context is not done for OMAP4. This patch
> adds the OMAP_I2C_FLAG_RESET_REGS_POSTIDLE in the OMAP4
> hwmod data which activates the restore for OMAP4.
> Currently the OMAP4 does not hit device off still the
> driver may have support for it.
>
> Signed-off-by: Shubhrajyoti D<shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
> Applies on top of patches from Andy Green
> http://www.spinics.net/lists/linux-i2c/msg05632.html
> Tested on OMAP4430
>
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 ++-
>   1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 0fe9556..5e2c748 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -2130,7 +2130,8 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
>   };
>
>   static struct omap_i2c_dev_attr i2c_dev_attr = {
> -	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE,
> +	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE |
> +			OMAP_I2C_FLAG_RESET_REGS_POSTIDLE,
>   };
>
>   /* i2c1 */
