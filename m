From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] OMAP3: I2C: Errata ID i207: Clear wrong RDR
 interrupt
Date: Wed, 21 Apr 2010 14:42:53 -0700
Message-ID: <20100421214252.GM18272@atomide.com>
References: <1271167302-17776-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64414 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232Ab0DUVmz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Apr 2010 17:42:55 -0400
Content-Disposition: inline
In-Reply-To: <1271167302-17776-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manjunatha GK <manjugk@ti.com>
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, ben-linux@fluff.org, "Kalliguddi, Hema" <hemahk@ti.com>, Nishanth Menon <nm@ti.com>

* Manjunatha GK <manjugk@ti.com> [100413 06:32]:
> Under certain rare conditions, I2C_STAT[13].RDR bit may be set
> and the corresponding interrupt fire, even there is no data in
> the receive FIFO, or the I2C data transfer is still ongoing.
> These spurious RDR events must be ignored by the software.
> 
> This patch handles and ignores RDR spurious interrupts.
> 
> Patch tested on OMAP zoom3 board.
> 
> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-i2c@vger.kernel.org
> Cc: ben-linux@fluff.org
> Cc: Kalliguddi, Hema <hemahk@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> ---
> Review comments for earlier post can be found at:
> https://patchwork.kernel.org/patch/90122/
> 
>  drivers/i2c/busses/i2c-omap.c |   32 +++++++++++++++++++++++++++++++-
>  1 files changed, 31 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index ae6f5c1..d4ec886 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -733,10 +733,40 @@ complete:
>  		}
>  		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
>  			u8 num_bytes = 1;
> +
> +			/*
> +			 * I2C Errata(Errata Nos. OMAP2: 1.67, OMAP3: 1.8)
> +			 * Not applicable for OMAP4.
> +			 * Under certain rare conditions, RDR could be set again
> +			 * when the bus is busy, then ignore the interrupt and
> +			 * clear the interrupt.
> +			 */
> +			if ((stat & OMAP_I2C_STAT_RDR) && !cpu_is_omap44xx()) {
> +				/* Step 1: If RDR is set, clear it */
> +				omap_i2c_ack_stat(dev, stat & OMAP_I2C_STAT_RDR);
> +
> +				/* Step 2: */
> +				if(!(omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG)
> +							& OMAP_I2C_STAT_BB)) {
> +					/* Step 3: */
> +					while(omap_i2c_read_reg(dev,
> +						OMAP_I2C_STAT_REG)
> +							& OMAP_I2C_STAT_RDR) {
> +						omap_i2c_ack_stat(dev, stat
> +							& OMAP_I2C_STAT_RDR);
> +						dev_err(dev->dev,
> +						"I2C : RDR when the bus is busy.\n");
> +						continue;
> +					}
> +
> +				}
> +				else
> +					return IRQ_HANDLED;
> +			}

Please move these hacks into a separate inline function that you initialize
during the init. Then in the function you do it if OMAP_I2C_QUIRK_1234 flag
has been set.

In general, it seems that a lot of TI omap4 patches just do:

if (!cpu_is_omap4430()) {
	indent_old_code_even_more
	...
} else {
	add_hacks_for_omap4
	...
}

And sprinkle that all over the place.

This is not a maintainable way of doing things. Please do something
like this instead:

#ifdef CONFIG_ARCH_OMAP4
static inline void omap_i2c_quirk_1234(struct device *dev)
{
	/* Do hacks here */	
}
#else
static inline void omap_i2c_quirk_1234(struct device *dev)
{
}
#endif

int omap_i2_some_function(struct device *dev)
{
	...
	if (dev->quirks & OMAP_I2C_QUIRK_1234)
		omap_i2c_quirk_1234(dev);
	...
}

And then in the driver init just set the quirks you need.

Regards,

Tony
