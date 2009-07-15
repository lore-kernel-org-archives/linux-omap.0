From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: RE: [PATCH 2/3] [OMAP:I2C]In case of a NACK|ARDY|AL return from the
 ISR
Date: Wed, 15 Jul 2009 10:25:55 -0500
Message-ID: <CD8CC2B65FEE304DA95744A5472698F202957C7C2D@dlee06.ent.ti.com>
References: <CD8CC2B65FEE304DA95744A5472698F202957C7AFA@dlee06.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C011E5ED9E0@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59624 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755303AbZGOP0F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jul 2009 11:26:05 -0400
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C011E5ED9E0@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kamat, Nishant" <nskamat@ti.com>, Paul Walmsley <paul@pwsan.com>

Hello Nishant,

Comments inlined:

Regards
Moiz Sonasath
Linux Baseport Team, Dallas
214-567-5514

-----Original Message-----
From: Menon, Nishanth 
Sent: Tuesday, July 14, 2009 5:22 PM
To: Sonasath, Moiz; linux-omap@vger.kernel.org
Cc: Kamat, Nishant; Paul Walmsley
Subject: RE: [PATCH 2/3] [OMAP:I2C]In case of a NACK|ARDY|AL return from the ISR

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

[Moiz]
Correct me if I am wrong, but you are referring to the OMAP_I2C_STAT_REG (which has the interrupt status information). This is actually ACKED just before going into the NACK|AL|ARDY error cases. I suppose a few days back you also sent out a patch to change this to ACK all interrupts other than RRDY/RDR and XRDY/XDR as we have to ACK these only after we service them.
  
I think this conflicts with [1]
[Moiz]
Actually, it does not conflict with [1], as [1] changes the later part of the code allowing this patch to be applied cleanly.

Regards,
Nishanth Menon

Ref:
[1] http://patchwork.kernel.org/patch/32332/
