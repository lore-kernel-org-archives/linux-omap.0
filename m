From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 16/24] omap4: Add i2c support on omap4 platform
Date: Tue, 16 Feb 2010 16:21:18 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002161616550.10478@utopia.booyaka.com>
References: <1266335895-32741-1-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-3-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-4-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-5-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-6-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-7-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-8-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-9-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-10-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-11-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-12-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-13-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-14-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-15-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-16-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39611 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933513Ab0BPXVT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 18:21:19 -0500
In-Reply-To: <1266335895-32741-16-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk, rnayak@ti.com, Syed Rafiuddin <rafiuddin.syed@ti.com>, Ben Dooks <ben-linux@fluff.org>

Hello Santosh,

one general comment on this patch, before the specific comments.  Rather 
than adding more cpu_is_omap*() all over, please instead convert this code 
to use flags passed in via platform_data.  The I2C hwmod conversion 
patches are one attempt to do that via the hwmod mechanism; you can use 
that as an example of one way to do that with this driver.

On Tue, 16 Feb 2010, Santosh Shilimkar wrote:

> @@ -746,9 +814,12 @@ complete:
>  				if (dev->buf_len) {
>  					*dev->buf++ = w;
>  					dev->buf_len--;
> -					/* Data reg from 2430 is 8 bit wide */
> +					/* Data reg in 2430, omap3 and
> +					 * omap4 is 8 bit wide
> +					 */

The above comment needs to be fixed per CodingStyle.

>  					if (!cpu_is_omap2430() &&
> -							!cpu_is_omap34xx()) {
> +							!cpu_is_omap34xx() &&
> +							!cpu_is_omap44xx()) {
>  						if (dev->buf_len) {
>  							*dev->buf++ = w >> 8;
>  							dev->buf_len--;
> @@ -786,9 +857,12 @@ complete:
>  				if (dev->buf_len) {
>  					w = *dev->buf++;
>  					dev->buf_len--;
> -					/* Data reg from  2430 is 8 bit wide */
> +					/* Data reg in 2430, omap3 and
> +					 * omap4 is 8 bit wide
> +					 */

The above comment needs to be fixed per CodingStyle.

>  					if (!cpu_is_omap2430() &&
> -							!cpu_is_omap34xx()) {
> +							!cpu_is_omap34xx() &&
> +							!cpu_is_omap44xx()) {
>  						if (dev->buf_len) {
>  							w |= *dev->buf++ << 8;
>  							dev->buf_len--;
> @@ -897,6 +971,8 @@ omap_i2c_probe(struct platform_device *pdev)
>  
>  	if (cpu_is_omap7xx())
>  		dev->reg_shift = 1;
> +	else if (cpu_is_omap44xx())
> +		dev->reg_shift = 0;
>  	else
>  		dev->reg_shift = 2;
>  
> @@ -911,11 +987,16 @@ omap_i2c_probe(struct platform_device *pdev)
>  	if ((r = omap_i2c_get_clocks(dev)) != 0)
>  		goto err_iounmap;
>  
> +	if (cpu_is_omap44xx())
> +		dev->regs = (u8 *) omap4_reg_map;
> +	else
> +		dev->regs = (u8 *) reg_map;
> +
>  	omap_i2c_unidle(dev);
>  
>  	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
>  
> -	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
> +	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
>  		u16 s;
>  
>  		/* Set up the fifo size - Get total size */
> @@ -927,8 +1008,13 @@ omap_i2c_probe(struct platform_device *pdev)
>  		 * size. This is to ensure that we can handle the status on int
>  		 * call back latencies.
>  		 */
> -		dev->fifo_size = (dev->fifo_size / 2);
> -		dev->b_hw = 1; /* Enable hardware fixes */
> +		if (dev->rev >= OMAP_I2C_REV_ON_4430) {
> +			dev->fifo_size = 0;
> +			dev->b_hw = 0; /* Enable hardware fixes */
> +		} else {
> +			dev->fifo_size = (dev->fifo_size / 2);
> +			dev->b_hw = 1; /* Disable hardware fixes */

You've got the comments backwards here.  b_hw = 1 means "enable hardware 
fixes" as noted above.


> +		}
>  	}
>  
>  	/* reset ASAP, clearing any IRQs */
> -- 
> 1.6.0.4
> 


- Paul
