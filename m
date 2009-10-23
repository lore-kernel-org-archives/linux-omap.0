From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: RE: [PATCH V4 3/3] OMAP: I2C: Add mpu wake up latency constraint in
 i2c
Date: Fri, 23 Oct 2009 10:53:34 -0500
Message-ID: <CD8CC2B65FEE304DA95744A5472698F2029E427B04@dlee06.ent.ti.com>
References: <> <1256125881-12441-1-git-send-email-kalle.jokiniemi@digia.com>
 <1256125881-12441-2-git-send-email-kalle.jokiniemi@digia.com>
 <1256125881-12441-3-git-send-email-kalle.jokiniemi@digia.com>
 <1256125881-12441-4-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58635 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbZJWPxg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 11:53:36 -0400
In-Reply-To: <1256125881-12441-4-git-send-email-kalle.jokiniemi@digia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Menon, Nishanth" <nm@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

Hello Jokiniemi!

> -----Original Message-----
> From: Kalle Jokiniemi [mailto:kalle.jokiniemi@digia.com]
> Sent: Wednesday, October 21, 2009 6:51 AM
> To: khilman@deeprootsystems.com
> Cc: linux-omap@vger.kernel.org; Kalle Jokiniemi; Sonasath, Moiz; Jarkko
> Nikula; Paul Walmsley; Menon, Nishanth
> Subject: [PATCH V4 3/3] OMAP: I2C: Add mpu wake up latency constraint in
> i2c
> 
> While waiting for completion of the i2c transfer, the
> MPU could hit OFF mode and cause several msecs of
> delay that made i2c transfers fail more often. The
> extra delays and subsequent re-trys cause i2c clocks
> to be active more often. This has also an negative
> effect on power consumption.
> 
> Created a mechanism for passing and using the
> constraint setting function in driver code. The used
> mpu wake up latency constraints are now set individually
> per bus, and they are calculated based on clock rate
> and fifo size.
> 
> Thanks to Jarkko Nikula, Moiz Sonasath, Paul Walmsley,
> and Nishanth Menon for tuning out the details of
> this patch.
> 
> Cc: Moiz Sonasath <m-sonasath@ti.com>
> Cc: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
> ---
> 


>  	dev->speed = speed;
>  	dev->idle = 1;
> @@ -911,6 +923,11 @@ omap_i2c_probe(struct platform_device *pdev)
>  		 */
>  		dev->fifo_size = (dev->fifo_size / 2);
>  		dev->b_hw = 1; /* Enable hardware fixes */
> +
> +		/* calculate wakeup latency constraint for MPU */
> +		if (dev->set_mpu_wkup_lat != NULL)
> +			dev->latency = (1000000 * dev->fifo_size) /
> +				       (1000 * speed / 8);
>  	}

IMHO, here instead of using 'dev->fifo_size' for calculating the 
'dev->latency', we need to use:

1. For RX case, to avoid Reciver overrun:
	if (msg->flags & I2C_M_RD)
		Use [(FIFO Depth)bytes - (FIFO THRSH)bytes] in calculating 
		dev->latency

Because conceptually, RDR/RRDY interrupts are generated when RTRSH is reached, so we want the MPU to be wake up within the time it takes to fill the FIFO from RTRSH to FIFO Depth (FIFO full).  

2. For TX case, to avoid Transmitter Underflow:
	if (!(msg->flags & I2C_M_RD))
		Use (FIFO THRSH)bytes in calculating dev->latency

Because conceptually, XDR/XRDY interrupts are generated when XTRSH is reached, so we want the MPU to be wake up within the time it takes to drain the FIFO from XTRSH to Zero (FIFO empty).  

Using, dev->fifo_size instead, works in the present code because we have a RTRSH/XTRSH = dev->fifo_size/2 = 4 bytes
And therefore,
(FIFO Depth)bytes - (FIFO THRSH)bytes
= 8 - 4 = 4 bytes

But, to make it more generic in future and to make it independent of any changes in the RTRSH/XTRSH values or FIFO depths in future, we should use a generic code here.  

> 
>  	/* reset ASAP, clearing any IRQs */
> diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
> new file mode 100644
> index 0000000..1362fba
> --- /dev/null
> +++ b/include/linux/i2c-omap.h
> @@ -0,0 +1,9 @@
> +#ifndef __I2C_OMAP_H__
> +#define __I2C_OMAP_H__
> +
> +struct omap_i2c_bus_platform_data {
> +	u32		clkrate;
> +	void		(*set_mpu_wkup_lat)(struct device *dev, int set);
> +};
> +
> +#endif
> --
> 1.5.4.3

Regards
Moiz Sonasath

