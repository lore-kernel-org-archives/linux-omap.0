From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH] [RFC][OMAP3:I2C]Workaround for OMAP3430 I2C silicon
   errata 1.153
Date: Tue, 23 Jun 2009 14:06:34 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C0116011AC7@dlee02.ent.ti.com>
References: <CD8CC2B65FEE304DA95744A5472698F2028A41187E@dlee06.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C0115F50E6C@dlee02.ent.ti.com>
 <h1qm0f$r7c$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33662 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752534AbZFWTGn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 15:06:43 -0400
In-Reply-To: <h1qm0f$r7c$1@ger.gmane.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "i.mazanov@gmail.com" <i.mazanov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Igor Mazanov
> Sent: Tuesday, June 23, 2009 4:43 PM
> To: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] [RFC][OMAP3:I2C]Workaround for OMAP3430 I2C silicon
> errata 1.153
> 
> /*
>   * Is there a bug in the OMAP5910 I2C controller? It
>   * generates a bunch of fake XRDY interrupts under high load.
>   * As result, there is a very high chance to have a situation
>   * when dev->buf_len = 0 already, but I2C_CNT != 0. So, there
>   * is no ARDY irq then, no complete_cmd, controller timed out
>   * issues...
>   *
>   * Workaround:
>   *
>   * When we get XRDY interrupt without transmit underflow flag
>   * (XUDF bit in the I2C_STAT register), delay for 100 microsecs
>   * and ignore it.
>   *
>   * We write data into I2C_DATA register in case of transmit
>   * underflow condition ONLY.
>   */
> if (stat & OMAP_I2C_STAT_XRDY) {
> 	if (!(stat & OMAP_I2C_STAT_XUDF)) {
> 		udelay(100);
> 		continue;
> 	} else {
> 		w = 0;
> 		if (dev->buf_len) {
> 			w = *dev->buf++;
> 			dev->buf_len--;
> 			if (dev->buf_len) {
> 				w |= *dev->buf++ << 8;
> 				dev->buf_len--;
> 			}
> 			omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
> 		} else {
> 			dev_err(dev->dev, "XRDY IRQ while no "
> 						"data to send\n");
> 			break;
> 		}
> 		continue;
> 	}
> }
> 
Could you submit a patch please?


Regards,
Nishanth Menon
