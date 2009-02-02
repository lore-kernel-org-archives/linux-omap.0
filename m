From: Ben Dooks <ben@fluff.org.uk>
Subject: Re: [PATCH] I2C: OMAP: Add missing wakeup events
Date: Mon, 2 Feb 2009 14:06:06 +0000
Message-ID: <20090202140606.GN8032@fluff.org.uk>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02A39CF17B@dbde02.ent.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02A3D44D79@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:59936 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752074AbZBBOGK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2009 09:06:10 -0500
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02A3D44D79@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: Ben Dooks <ben-linux@fluff.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Feb 02, 2009 at 12:47:05PM +0530, Pakaravoor, Jagadeesh wrote:
> Ben,
> 
>   Did you get a chance to look at this patch?

Is it a necesary bugfix, or should it wait for the next merge window?

> -----Original Message-----
> From: linux-i2c-owner@vger.kernel.org [mailto:linux-i2c-owner@vger.kernel.org] On Behalf Of Pakaravoor, Jagadeesh
> Sent: Friday, January 23, 2009 2:19 PM
> To: linux-i2c@vger.kernel.org
> Cc: linux-omap@vger.kernel.org; Ben Dooks
> Subject: [PATCH] I2C: OMAP: Add missing wakeup events
> 
> From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> 
> Include wake up events for receiver overflow and transmitter
> underflow in OMAP_I2C_WE_REG configuration. Also fix a small
> typo.
> 
> Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> ---
> Index: kernel_org/drivers/i2c/busses/i2c-omap.c
> ===================================================================
> --- kernel_org.orig/drivers/i2c/busses/i2c-omap.c	2009-01-23 12:46:58.000000000 +0530
> +++ kernel_org/drivers/i2c/busses/i2c-omap.c	2009-01-23 14:15:52.187150630 +0530
> @@ -92,8 +92,10 @@
>  #define OMAP_I2C_STAT_AL	(1 << 0)	/* Arbitration lost int ena */
>  
>  /* I2C WE wakeup enable register */
> -#define OMAP_I2C_WE_XDR_WE	(1 << 14)	/* TX drain wakup */
> +#define OMAP_I2C_WE_XDR_WE	(1 << 14)	/* TX drain wakeup */
>  #define OMAP_I2C_WE_RDR_WE	(1 << 13)	/* RX drain wakeup */
> +#define OMAP_I2C_WE_ROVR_WE	(1 << 11)	/* RX overflow wakeup */
> +#define OMAP_I2C_WE_XUDF_WE	(1 << 10)	/* TX underflow wakeup */
>  #define OMAP_I2C_WE_AAS_WE	(1 << 9)	/* Address as slave wakeup*/
>  #define OMAP_I2C_WE_BF_WE	(1 << 8)	/* Bus free wakeup */
>  #define OMAP_I2C_WE_STC_WE	(1 << 6)	/* Start condition wakeup */
> @@ -104,6 +106,7 @@
>  #define OMAP_I2C_WE_AL_WE	(1 << 0)	/* Arbitration lost wakeup */
>  
>  #define OMAP_I2C_WE_ALL		(OMAP_I2C_WE_XDR_WE | OMAP_I2C_WE_RDR_WE | \
> +				OMAP_I2C_WE_ROVR_WE | OMAP_I2C_WE_XUDF_WE | \
>  				OMAP_I2C_WE_AAS_WE | OMAP_I2C_WE_BF_WE | \
>  				OMAP_I2C_WE_STC_WE | OMAP_I2C_WE_GC_WE | \
>  				OMAP_I2C_WE_DRDY_WE | OMAP_I2C_WE_ARDY_WE | \
> --
> With Regards,
> Jagadeesh Bhaskar P
>  
> ----------------------------
> Some men see things as they are and say why - I dream things that never were and say why not.
> - George Bernard Shaw
> ----------------------------
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
