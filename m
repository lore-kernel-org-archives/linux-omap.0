From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] omap: serial: fix coding style indentaion
Date: Thu, 7 Jan 2010 13:06:59 -0600
Message-ID: <4B4630D3.4010100@ti.com>
References: <1262890159-22878-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56341 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644Ab0AGTHB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 14:07:01 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o07J70kO006927
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 7 Jan 2010 13:07:00 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id o07J70hY005511
	for <linux-omap@vger.kernel.org>; Thu, 7 Jan 2010 13:07:00 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o07J70Si001021
	for <linux-omap@vger.kernel.org>; Thu, 7 Jan 2010 13:07:00 -0600 (CST)
In-Reply-To: <1262890159-22878-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Pandita, Vikram had written, on 01/07/2010 12:49 PM, the following:
> Just fix coding style indentaion as per checkpatch
> No logical code change.
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 8c964be..467e5de 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -694,15 +694,15 @@ void __init omap_serial_init_port(int port)
>  		DEV_CREATE_FILE(dev, &dev_attr_sleep_timeout);
>  	}
>  
> -		/* omap44xx: Never read empty UART fifo
> -		 * omap3xxx: Never read empty UART fifo on UARTs
> -		 * with IP rev >=0x52
> -		 */
> -		if (cpu_is_omap44xx())
> -			uart->p->serial_in = serial_in_override;
> -		else if ((serial_read_reg(uart->p, UART_OMAP_MVER) & 0xFF)
> -				>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
> -			uart->p->serial_in = serial_in_override;
> +	/* omap44xx: Never read empty UART fifo
> +	 * omap3xxx: Never read empty UART fifo on UARTs
> +	 * with IP rev >=0x52
> +	 */
Since you are fixing the coding style, ;) multiline comment goes:
/*
  * tada tada
  */
Ref: Documentation/CodingStyle Chapter 8: Commenting

> +	if (cpu_is_omap44xx())
> +		uart->p->serial_in = serial_in_override;
> +	else if ((serial_read_reg(uart->p, UART_OMAP_MVER) & 0xFF)
> +			>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
> +		uart->p->serial_in = serial_in_override;
>  }
>  
>  /**


-- 
Regards,
Nishanth Menon
