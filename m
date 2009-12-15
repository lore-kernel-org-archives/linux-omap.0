From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH] omap i2c: add timeout to a busy loop in isr
Date: Tue, 15 Dec 2009 15:20:14 +0200
Message-ID: <4B278D0E.8000807@nokia.com>
References: <1260796864-8560-1-git-send-email-virtuoso@slind.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:64963 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828AbZLONU3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 08:20:29 -0500
In-Reply-To: <1260796864-8560-1-git-send-email-virtuoso@slind.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Alexander Shishkin <virtuoso@slind.org>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Alexander Shishkin wrote:
> Signed-off-by: Alexander Shishkin <virtuoso@slind.org>

Could you add a better patch description? I.e. the patch is needed
because I2C failure can cause a kernel hang. The problem can be
reproduced by running the bus with wrong (too high) speed.

Also, you should send the patch to ben-linux@fluff.org with
linux-omap and linux-i2c@vger.kernel.org in CC.

Tested-by: Aaro Koskinen <aaro.koskinen@nokia.com>

>  drivers/i2c/busses/i2c-omap.c |   21 +++++++++++++--------
>  1 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 75bf3ad..7617f18 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -803,15 +803,20 @@ complete:
>  				 */
>  
>  				if (dev->rev <= OMAP_I2C_REV_ON_3430) {
> -						while (!(stat & OMAP_I2C_STAT_XUDF)) {
> -							if (stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
> -								omap_i2c_ack_stat(dev, stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
> -								err |= OMAP_I2C_STAT_XUDF;
> -								goto complete;
> -							}
> -							cpu_relax();
> -							stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> +					unsigned long timeout = 10000;

I think 10000 reads (with L4 core interconnect latency) is at least 0.8 ms. It should be more than
enough for normal cases.

> +					while (!(stat & OMAP_I2C_STAT_XUDF) && --timeout) {
> +						if (stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
> +							omap_i2c_ack_stat(dev, stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
> +							err |= OMAP_I2C_STAT_XUDF;
> +							goto complete;
>  						}
> +						cpu_relax();
> +						stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> +					}
> +
> +					if (!timeout)
> +						dev_err(dev->dev, "timeout waiting on XUDF bit\n");
>  				}
>  
>  				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);

A.
