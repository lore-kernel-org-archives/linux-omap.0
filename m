From: Rick Bronson <rick@efn.org>
Subject: Re: UART RX wakeup from sleep not working
Date: Thu, 02 Dec 2010 10:49:31 -0800
Message-ID: <E1POEDj-0002sN-R2@amazonia.comcast.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from efn.org ([206.192.230.249]:34512 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753162Ab0LBStc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Dec 2010 13:49:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Hi Paul,

  Thanks much for the help.

> If the OMAP is in full-chip retention, the UART's asynchronous wakeup
> mechanism won't work, which appears to be what you're trying to use.
> That will only work when PER is fully powered, as far as I know.  You'll
> need to use the IO chain wakeup feature instead.  My guess is that you
> need to make sure that your UART input pads have the WAKEUPENABLE bits set
> in the CONTROL_PADCONF registers.  I think that should do it.

  I put debug code in and the IO chain wakeup feature is enabled and
the WAKEUPENABLE bit is set on the pad in question.  With the IO chain
feature what's the wakeup mechanism?  Does it generate an interrupt?

  I've updated my assumptions:

Assumptions (using UART3)

1.  OMAP3730 is in sleep mode via
    echo 1 > /mnt/dbg/pm_debug/sleep_while_idle
2.  The UARTi.SCR_REG[4] RX_CTS_WU_EN bit is set to 1.
3.  The UARTi.IER_REG[4] SLEEP_MODE bit to 1
4.  The UARTi.SYSC_REG[2] ENAWAKEUP bit is set to 1
5.  The UARTi.WER_REG EVENT_4_RX_ACTIVITY bit is set to 1
6.  The UARTi.SSR_REG RX_CTS_DSR_WAKE_UP_STS bit is set to 1
7.  The PRCM.PM_WKEN_WKUP EN_IO_CHAIN bit is set to 1 via omap3_enable_io_chain()
8.  The PRCM.PM_WKEN_WKUP[8] EN_IO bit is set to 1 via omap3_enable_io_chain()
9.  CONTROL_PADCONF_UART3_RTS_SD[14] WAKEUPENABLE0 is set to 1
10. CONTROL_PADCONF_UART3_RTS_SD INPUTENABLE is set to 1

  Thanks again,

 Rick

> Hello Rick,
> 
> On Wed, 1 Dec 2010, Rick Bronson wrote:
> 
> >   I'm having trouble getting the UART wakeup from sleep via activity
> > on the RX pin working.
> >
> > --------------------------------------------------------
> > Assumptions (using UART3)
> >
> > 1. Using Arago Linux 2.6.32
> > 2. OMAP3730 is in sleep mode via
> >    echo 1 > /mnt/dbg/pm_debug/sleep_while_idle
> > 3. The UARTi.SCR_REG[4] RX_CTS_WU_EN bit is set to 1.
> > 4. The UARTi.IER_REG[4] SLEEP_MODE bit to 1
> > 5. The UARTi.SYSC_REG[2] ENAWAKEUP bit is set to 1
> > 6. The UARTi.WER_REG EVENT_4_RX_ACTIVITY bit is set to 1
> > 7. The UARTi.SSR_REG RX_CTS_DSR_WAKE_UP_STS bit is set to 1
> >
> > Expectations
> >
> >   When a character arrives on the RX pin of UART3 when in sleep mode,
> > the OMAP3730 exits sleep mode immediately via a RX_CTS_DSR_WAKE_UP
> > interrupt.
> >
> > Problem
> >
> >   The interrupt does happen but only after the UART clocks have been
> > enabled.  The OMAP3730 seems to exit sleep mode only when the UART
> > clocks are re-enabled via omap_uart_enable_clocks() in
> > arch/arm/mach-omap2/serial.c
> 
