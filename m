From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 2/3] [OMAP:I2C]In case of a NACK|ARDY|AL return from the
 ISR
Date: Tue, 14 Jul 2009 17:21:57 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C011E5ED9E0@dlee02.ent.ti.com>
References: <CD8CC2B65FEE304DA95744A5472698F202957C7AFA@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37505 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755791AbZGNWWG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jul 2009 18:22:06 -0400
In-Reply-To: <CD8CC2B65FEE304DA95744A5472698F202957C7AFA@dlee06.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sonasath, Moiz" <m-sonasath@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kamat, Nishant" <nskamat@ti.com>, Paul Walmsley <paul@pwsan.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Sonasath, Moiz
> Sent: Tuesday, July 14, 2009 4:20 PM
> To: linux-omap@vger.kernel.org
> Cc: Kamat, Nishant; Paul Walmsley
> Subject: [PATCH 2/3] [OMAP:I2C]In case of a NACK|ARDY|AL return from the
> ISR
> 
> 
> In case of a NACK or ARDY or AL interrupt, complete the request.
> There is no need to service the RRDY/RDR or XRDY/XDR interrupts.
> 
> Refer TRM SWPU114: Figure 18-31.I2C Master Transmitter Mode, Interrupt
> Method,
> in F/S and HS Modes
> 
> http://focus.ti.com/pdfs/wtbu/SWPU114T_PrelimFinalEPDF_06_25_2009.pdf
> 
> Signed-off-by: Moiz Sonasath<m-sonasath@ti.com>
> Signed-off-by: Vikram Pandita<vikram.pandita@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index d280acf..05b5e4c 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -685,8 +685,10 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  			err |= OMAP_I2C_STAT_AL;
>  		}
>  		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
> -					OMAP_I2C_STAT_AL))
> +					OMAP_I2C_STAT_AL)) {
>  			omap_i2c_complete_cmd(dev, err);
> +			return IRQ_HANDLED;
> +		}
What is the status of IRQ_STAT register? Who will clear that if we return immediately from ISR? Isr will be reinvoked and we'd handle the same anyways..

I think this conflicts with [1]

Regards,
Nishanth Menon

Ref:
[1] http://patchwork.kernel.org/patch/32332/
