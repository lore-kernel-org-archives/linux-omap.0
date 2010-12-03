From: Paul Walmsley <paul@pwsan.com>
Subject: Re: UART RX wakeup from sleep not working
Date: Fri, 3 Dec 2010 03:44:15 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012030326030.17078@utopia.booyaka.com>
References: <E1POEDj-0002sN-R2@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52094 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689Ab0LCKoQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 05:44:16 -0500
In-Reply-To: <E1POEDj-0002sN-R2@amazonia.comcast.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rick Bronson <rick@efn.org>
Cc: linux-omap@vger.kernel.org

Hi Rick

On Thu, 2 Dec 2010, Rick Bronson wrote:

> > If the OMAP is in full-chip retention, the UART's asynchronous wakeup
> > mechanism won't work, which appears to be what you're trying to use.
> > That will only work when PER is fully powered, as far as I know.  You'll
> > need to use the IO chain wakeup feature instead.  My guess is that you
> > need to make sure that your UART input pads have the WAKEUPENABLE bits set
> > in the CONTROL_PADCONF registers.  I think that should do it.
> 
>   I put debug code in and the IO chain wakeup feature is enabled and
> the WAKEUPENABLE bit is set on the pad in question.  With the IO chain
> feature what's the wakeup mechanism? 

It's described in the 34xx TRM sections 4.11.2 "Device Off-Mode 
Configuration" and 4.11.3 "CORE Power Domain Off-Mode Sequences".  All the 
references to off-mode just confuse things, since AFAIK, this wakeup 
mechanism also applies to the device in full-chip retention (see also the 
'NOTE:' portion of section 4.8.4 "Device Wake-Up Events").

 > Does it generate an interrupt?

An IO chain/ring wakeup event ultimately should generate a PRCM interrupt, 
which should wind up in mach-omap2/pm34xx.c:prcm_interrupt_handler().  
You might want to put some debugging in prcm_clear_mod_irqs(), first to 
see if that function is getting called, and second, to output the state of 
the WKST and GRPSEL registers.

>   I've updated my assumptions:
> 
> Assumptions (using UART3)
> 
> 1.  OMAP3730 is in sleep mode via
>     echo 1 > /mnt/dbg/pm_debug/sleep_while_idle
> 2.  The UARTi.SCR_REG[4] RX_CTS_WU_EN bit is set to 1.
> 3.  The UARTi.IER_REG[4] SLEEP_MODE bit to 1
> 4.  The UARTi.SYSC_REG[2] ENAWAKEUP bit is set to 1
> 5.  The UARTi.WER_REG EVENT_4_RX_ACTIVITY bit is set to 1
> 6.  The UARTi.SSR_REG RX_CTS_DSR_WAKE_UP_STS bit is set to 1
> 7.  The PRCM.PM_WKEN_WKUP EN_IO_CHAIN bit is set to 1 via omap3_enable_io_chain()
> 8.  The PRCM.PM_WKEN_WKUP[8] EN_IO bit is set to 1 via omap3_enable_io_chain()
> 9.  CONTROL_PADCONF_UART3_RTS_SD[14] WAKEUPENABLE0 is set to 1
> 10. CONTROL_PADCONF_UART3_RTS_SD INPUTENABLE is set to 1

This may be a stupid question, but are you using serial flow control?  If 
not, enabling wakeup on the RTS line isn't going to help.

Just out of curiosity, which kernel are you using?


- Paul
