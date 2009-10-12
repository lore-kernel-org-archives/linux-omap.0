From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: RE: [PATCH RESEND] I2C: OMAP: Add missing wakeup events
Date: Mon, 12 Oct 2009 11:21:47 -0500
Message-ID: <CD8CC2B65FEE304DA95744A5472698F2029E372001@dlee06.ent.ti.com>
References: <1255342885-15786-1-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47171 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756716AbZJLQWn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Oct 2009 12:22:43 -0400
In-Reply-To: <1255342885-15786-1-git-send-email-aaro.koskinen@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "j-pakaravoor@ti.com" <j-pakaravoor@ti.com>

Hello Aaro!

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Aaro Koskinen
> Sent: Monday, October 12, 2009 5:21 AM
> To: ben-linux@fluff.org; linux-i2c@vger.kernel.org
> Cc: linux-omap@vger.kernel.org; j-pakaravoor@ti.com
> Subject: [PATCH RESEND] I2C: OMAP: Add missing wakeup events
> 
> From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> 
> Include wake up events for receiver overflow and transmitter
> underflow in OMAP_I2C_WE_REG configuration. Also fix a small
> typo.
> 
> Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 827da08..34ea9ed 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -92,8 +92,10 @@
>  #define OMAP_I2C_STAT_AL	(1 << 0)	/* Arbitration lost int ena */
> 
>  /* I2C WE wakeup enable register */
> -#define OMAP_I2C_WE_XDR_WE	(1 << 14)	/* TX drain wakup */
> +#define OMAP_I2C_WE_XDR_WE	(1 << 14)	/* TX drain wakeup */
>  #define OMAP_I2C_WE_RDR_WE	(1 << 13)	/* RX drain wakeup */
> +#define OMAP_I2C_WE_ROVR_WE	(1 << 11)	/* RX overflow wakeup */
> +#define OMAP_I2C_WE_XUDF_WE	(1 << 10)	/* TX underflow wakeup */

These bits are not documented in OMAP3430, they are reserved. How can we use them?

>  #define OMAP_I2C_WE_AAS_WE	(1 << 9)	/* Address as slave wakeup*/
>  #define OMAP_I2C_WE_BF_WE	(1 << 8)	/* Bus free wakeup */
>  #define OMAP_I2C_WE_STC_WE	(1 << 6)	/* Start condition wakeup */
> @@ -104,6 +106,7 @@
>  #define OMAP_I2C_WE_AL_WE	(1 << 0)	/* Arbitration lost wakeup */
> 
>  #define OMAP_I2C_WE_ALL		(OMAP_I2C_WE_XDR_WE |
> OMAP_I2C_WE_RDR_WE | \
> +				OMAP_I2C_WE_ROVR_WE | OMAP_I2C_WE_XUDF_WE | \
>  				OMAP_I2C_WE_AAS_WE | OMAP_I2C_WE_BF_WE | \
>  				OMAP_I2C_WE_STC_WE | OMAP_I2C_WE_GC_WE | \
>  				OMAP_I2C_WE_DRDY_WE | OMAP_I2C_WE_ARDY_WE | \
> --
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards
Moiz Sonasath

