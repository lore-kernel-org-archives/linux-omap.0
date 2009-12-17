From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 2/2] omap i2c: add a timeout to the busy waiting
Date: Thu, 17 Dec 2009 08:38:39 +0530
Message-ID: <4B29A0B7.1020908@ti.com>
References: <1260972144-31593-1-git-send-email-virtuoso@slind.org> <1260972144-31593-2-git-send-email-virtuoso@slind.org> <1260972144-31593-3-git-send-email-virtuoso@slind.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:33176 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506AbZLQDIo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 22:08:44 -0500
In-Reply-To: <1260972144-31593-3-git-send-email-virtuoso@slind.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Shishkin <virtuoso@slind.org>
Cc: "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Alexander Shishkin said the following on 12/16/2009 07:32 PM:
> The errata 1.153 workaround is busy waiting on XUDF bit in interrupt
> context, which may lead to kernel hangs. The problem can be reproduced
> by running the bus with wrong (too high) speed.
>
> Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
> CC: linux-i2c@vger.kernel.org
> CC: linux-omap@vger.kernel.org
> ---
>  drivers/i2c/busses/i2c-omap.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index ad8242a..b474c20 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -678,7 +678,9 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
>   */
>  static int omap3430_workaround(struct omap_i2c_dev *dev, u16 *stat, int *err)
>  {
> -	while (!(*stat & OMAP_I2C_STAT_XUDF)) {
> +	unsigned long timeout = 10000;
> +
> +	while (!(*stat & OMAP_I2C_STAT_XUDF && --timeout)) {
>   
a) timeout without using an actual delay is not a good idea - consider 
each OPP - we can go upto 1ghz on 3630,
the actual time for 10000 iterations will depend on the MPU speed.
b) how did you arrive at the 10k iteration limit?

>  		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
>  			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
>  							OMAP_I2C_STAT_XDR));
> @@ -689,6 +691,9 @@ static int omap3430_workaround(struct omap_i2c_dev *dev, u16 *stat, int *err)
>  		*stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
>  	}
>  
> +	if (!timeout)
> +		dev_err(dev->dev, "timeout waiting on XUDF bit\n");
> +
>  	return 0;
>  }
>  
>   
Regards,
Nishanth Menon
