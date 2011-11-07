From: Kevin Hilman <khilman@ti.com>
Subject: Re: 10-bit address support in i2c-omap and i2c-davinci
Date: Mon, 07 Nov 2011 07:09:38 -0800
Message-ID: <87hb2g0y19.fsf@ti.com>
References: <20111107094614.0062a3f7@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:59395 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751751Ab1KGPJn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 10:09:43 -0500
In-Reply-To: <20111107094614.0062a3f7@endymion.delvare> (Jean Delvare's
	message of "Mon, 7 Nov 2011 09:46:14 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Ben Dooks <ben-linux@fluff.org>, Tony Lindgren <tony@atomide.com>, Andy Green <andy.green@linaro.org>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Linux I2C <linux-i2c@vger.kernel.org>, linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com

Adding linux-omap and linux-davinci lists

Jean Delvare <khali@linux-fr.org> writes:

> Both bus drivers i2c-omap and i2c-davinci apparently handle 10-bit addresses:
>
> (i2c-omap.c)
> 	if (msg->flags & I2C_M_TEN)
> 		w |= OMAP_I2C_CON_XA;
>
> (i2c-davinci.c)
> 	/* if the slave address is ten bit address, enable XA bit */
> 	if (msg->flags & I2C_M_TEN)
> 		flag |= DAVINCI_I2C_MDR_XA;
>
> However neither driver declares functionality flag I2C_FUNC_10BIT_ADDR,
> so chip drivers would normally refuse to bind to these buses. If 10-bit
> address support is incomplete or broken then it should be removed
> completely. If it works then these drivers should declare so by adding
> I2C_FUNC_10BIT_ADDR to the functionality flags they return.
