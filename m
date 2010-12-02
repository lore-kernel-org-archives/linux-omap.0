From: Paul Walmsley <paul@pwsan.com>
Subject: Re: UART RX wakeup from sleep not working
Date: Wed, 1 Dec 2010 17:56:45 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012011750450.2515@utopia.booyaka.com>
References: <E1PNozS-00020z-OZ@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41442 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820Ab0LBA4q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Dec 2010 19:56:46 -0500
In-Reply-To: <E1PNozS-00020z-OZ@amazonia.comcast.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rick Bronson <rick@efn.org>
Cc: linux-omap@vger.kernel.org

Hello Rick,

On Wed, 1 Dec 2010, Rick Bronson wrote:

>   I'm having trouble getting the UART wakeup from sleep via activity
> on the RX pin working.
> 
> --------------------------------------------------------
> Assumptions (using UART3)
> 
> 1. Using Arago Linux 2.6.32
> 2. OMAP3730 is in sleep mode via
>    echo 1 > /mnt/dbg/pm_debug/sleep_while_idle
> 3. The UARTi.SCR_REG[4] RX_CTS_WU_EN bit is set to 1.
> 4. The UARTi.IER_REG[4] SLEEP_MODE bit to 1
> 5. The UARTi.SYSC_REG[2] ENAWAKEUP bit is set to 1
> 6. The UARTi.WER_REG EVENT_4_RX_ACTIVITY bit is set to 1
> 7. The UARTi.SSR_REG RX_CTS_DSR_WAKE_UP_STS bit is set to 1
> 
> Expectations
> 
>   When a character arrives on the RX pin of UART3 when in sleep mode,
> the OMAP3730 exits sleep mode immediately via a RX_CTS_DSR_WAKE_UP
> interrupt.
>
> Problem
> 
>   The interrupt does happen but only after the UART clocks have been
> enabled.  The OMAP3730 seems to exit sleep mode only when the UART
> clocks are re-enabled via omap_uart_enable_clocks() in
> arch/arm/mach-omap2/serial.c

If the OMAP is in full-chip retention, the UART's asynchronous wakeup 
mechanism won't work, which appears to be what you're trying to use.  
That will only work when PER is fully powered, as far as I know.  You'll 
need to use the IO chain wakeup feature instead.  My guess is that you 
need to make sure that your UART input pads have the WAKEUPENABLE bits set 
in the CONTROL_PADCONF registers.  I think that should do it.


- Paul
