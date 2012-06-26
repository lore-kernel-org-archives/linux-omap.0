From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH v2 05/17] i2c: omap: split out [XR]DR and [XR]RDY
Date: Tue, 26 Jun 2012 16:11:30 +0530
Message-ID: <4FE991DA.5070301@ti.com>
References: <1339691067-919-1-git-send-email-balbi@ti.com> <1339691067-919-6-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339691067-919-6-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: ben-linux@fluff.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <linux@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, w.sang@pengutronix.de
List-Id: linux-omap@vger.kernel.org

Hi Felipe,
On Thursday 14 June 2012 09:54 PM, Felipe Balbi wrote:
>  			return IRQ_HANDLED;
>  		}
>  
> -		if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
> +		if (stat & OMAP_I2C_STAT_RDR) {
>  			u8 num_bytes = 1;
>  
> +			if (dev->fifo_size)
> +				num_bytes = dev->fifo_size;
In case of a draining interrupt. The byte count may not be the fifo size.
Do you agree?
> +
> +			while (num_bytes--) {
> +				if (!dev->buf_len) {
