From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 02/12] OMAP2+: UART: Remove uart clock handling code from serial.c
Date: Fri, 24 Jun 2011 15:28:19 -0700
Message-ID: <877h8ax3ss.fsf@ti.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
	<1307532194-13039-3-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:43659 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754822Ab1FXW2X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 18:28:23 -0400
In-Reply-To: <1307532194-13039-3-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Wed, 8 Jun 2011 16:53:04 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Cleanup serial.c file in preparation to addition of runtime api's in omap-serial
> file. Remove all clock handling mechanism as this will be taken care with
> pm runtime api's in omap-serial.c file itself.
>
> 1.) Remove omap-device enable and disable. We can can use get_sync/put_sync api's
> 2.) Remove context save/restore can be done with runtime_resume callback for
>     get_sync call. No need to save context as all reg details available in
>     uart_port structure can be used for restore, so add missing regs in
>     uart port struct.
> 3.) Add func to identify console uart.
> 4.) Erratum handling informed as flag to driver and func to handle erratum
>     can be moved to omap-serial driver itself.
>
> Acked-by: Alan Cox <alan@linux.intel.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

[...]

> @@ -47,65 +40,9 @@
>  #include "control.h"
>  #include "mux.h"
>  
> -#define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV	0x52
> -#define UART_OMAP_WER		0x17	/* Wake-up enable register */
> -
> -#define UART_ERRATA_FIFO_FULL_ABORT	(0x1 << 0)
> -#define UART_ERRATA_i202_MDR1_ACCESS	(0x1 << 1)
> -
> -/*
> - * NOTE: By default the serial timeout is disabled as it causes lost characters
> - * over the serial ports. This means that the UART clocks will stay on until
> - * disabled via sysfs. This also causes that any deeper omap sleep states are
> - * blocked. 
> - */
> -#define DEFAULT_TIMEOUT 0
> -
> -#define MAX_UART_HWMOD_NAME_LEN		16
> +#define MAX_UART_HWMOD_NAME_LEN                16

Minor: only whitespace change here, you converted tabs to spaces.

Rest of this looks fine.

Kevin
