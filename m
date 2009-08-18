From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] i2c-omap: Enable workaround for Errata 1.153 based
 on
Date: Tue, 18 Aug 2009 01:04:46 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908180104350.19267@utopia.booyaka.com>
References: <1250549146-18362-1-git-send-email-m-sonasath@ti.com> <1250549146-18362-2-git-send-email-m-sonasath@ti.com> <1250549146-18362-3-git-send-email-m-sonasath@ti.com> <1250549146-18362-4-git-send-email-m-sonasath@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33135 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbZHRHEq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Aug 2009 03:04:46 -0400
In-Reply-To: <1250549146-18362-4-git-send-email-m-sonasath@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Moiz Sonasath <m-sonasath@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, 17 Aug 2009, Moiz Sonasath wrote:

> Silicon Errata 1.153 has been fixed on OMAP 3630|4430 with the use of a later
> version of I2C IP block.
> 
> The errata impacts OMAP 2420|2430|3430, enable the workaround for these based 
> on I2C IP block revision number instead of OMAP CPU type
> 
> Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com

Reviewed-by: Paul Walmsley <paul@pwsan.com>

> ---
>  drivers/i2c/busses/i2c-omap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 16b39f4..827da08 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -784,7 +784,7 @@ complete:
>  				 * memory to the I2C interface.
>  				 */
>  
> -				if (cpu_is_omap34xx()) {
> +				if (dev->rev <= OMAP_I2C_REV_ON_3430) {
>  						while (!(stat & OMAP_I2C_STAT_XUDF)) {
>  							if (stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
>  								omap_i2c_ack_stat(dev, stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
> -- 
> 1.5.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
