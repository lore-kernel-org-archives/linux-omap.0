From: Mark Olleson <mark.olleson@yamaha.co.uk>
Subject: Re: [PATCH] ARM: OMAP2+ i2c NACK without STP
Date: Wed, 4 Jan 2012 14:42:46 +0000
Message-ID: <9C97AB15-07D0-4EF5-80A1-193FEB5B49C8@yamaha.co.uk>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:38564 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077Ab2ADOmu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jan 2012 09:42:50 -0500
Received: by werm1 with SMTP id m1so8588755wer.19
        for <linux-omap@vger.kernel.org>; Wed, 04 Jan 2012 06:42:49 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I have found another circumstance in which the bus locks up which is possibly a regression caused by this patch.

When performing a transfer with repeat starts, if one of the parts, that is is NOT the last in the sequence AND is a master-write AND is NACKed by the remote device, OMAP_I2C_CON_STP is never set and the bus is left in the busy state when returning to user-land with an error-code.

This code responsible for this is towards the bottom of  omap_i2c_xfer_msg() generates OMAP_I2C_CON_STP only when the NACK occurs on the last part of a repeat-start transfer. 

 	if (dev->cmd_err & OMAP_I2C_STAT_NACK) {
	..
		if (stop) {
			w = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
			w |= OMAP_I2C_CON_STP;
			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
		}
		return -EREMOTEIO;	

The caller - omap_i2c_xfer() - quickly bails following the error and doesn't attempt to try subsequent parts of the transfer. 

I'm slight perplexed by the original intention here: was it to i) fail quickly or ii) retry iii) continue with remaining parts of the transfer?  

The first of these feels right to me - in which we case we need a OMAP_I2C_CON_STP asserted following all NACKs

Anyone got any insight?


Mark




On Tue, Jun 14, 2011 at 4:24 PM, Jan Weitzel <j.weitzel@phytec.de> wrote:
> On OMAP4 OMAP_I2C_STAT_NACK is causing a timeout on the next access.
> The isr cleans all flags in OMAP_I2C_CON_REG by setting OMAP_I2C_CON_STP
> OMAP_I2C_CON_STP is also set in omap_i2c_xfer_msg on the last message.
>
> According to the TI TSR the sequence for OMAP_I2C_STAT_NACK and
> OMAP_I2C_STAT_AL are nearly the same.
> Removing the OMAP_I2C_CON_STP part in the isr fix the problem.
> Tested on OMAP4430 and OMAP3530 (here NACK was not a problem)
> Fixes also booting on 2430sdp.
>
> Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Balaji T K <balajitk@ti.com>
Can you please queue this patch

This patch has been tested in linux-omap tree
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commit;h=464fca36d98b97ccd05e4f200ab7483d3acc8345

> ---
>  drivers/i2c/busses/i2c-omap.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 58a58c7..670f2a2 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -836,11 +836,9 @@ complete:
>                                ~(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
>                                OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
>
> -               if (stat & OMAP_I2C_STAT_NACK) {
> +               if (stat & OMAP_I2C_STAT_NACK)
>                        err |= OMAP_I2C_STAT_NACK;
> -                       omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
> -                                          OMAP_I2C_CON_STP);
> -               }
> +
>                if (stat & OMAP_I2C_STAT_AL) {
>                        dev_err(dev->dev, "Arbitration lost\n");
>                        err |= OMAP_I2C_STAT_AL;
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html





