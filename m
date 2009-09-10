From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: FW: [RFC][PATCH]: Adding support for omap-serail driver
Date: Thu, 10 Sep 2009 08:57:49 -0700
Message-ID: <87ws46aj2a.fsf@deeprootsystems.com>
References: <F12CE1A68F023D498A2691C7B539311503935BC4@ZMY16EXM66.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:58090 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbZIJP5t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Sep 2009 11:57:49 -0400
Received: by pxi27 with SMTP id 27so198543pxi.15
        for <linux-omap@vger.kernel.org>; Thu, 10 Sep 2009 08:57:52 -0700 (PDT)
In-Reply-To: <F12CE1A68F023D498A2691C7B539311503935BC4@ZMY16EXM66.ds.mot.com> (HU TAO-TGHK's message of "Tue\, 1 Sep 2009 01\:32\:45 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: HU TAO-TGHK48 <taohu@motorola.com>
Cc: linux-omap@vger.kernel.org

"HU TAO-TGHK48" <taohu@motorola.com> writes:

> Resend to linux-omap
>
> -----Original Message-----
> From: HU TAO-TGHK48 
> Sent: Monday, August 31, 2009 7:50 PM
> To: 'vimal singh'; linux-omap@vger.kernel.org; LKML;
> linux-serial@vger.kernel.org
> Cc: Ye Yuan.Bo-A22116; Chen Xiaolong-A21785
> Subject: RE: [RFC][PATCH]: Adding support for omap-serail driver
>
>  
> 1. Shall we cleanup PM related stuff in arch/arm/mach-omap2/serial.c as
> well?
>     Originally serail.c register UART IRQ  to decide if UART idle for a
> while and is able to enter low power mode (e.g. retention).
>     To work with original 8250 driver, it is probably the only way since
> 8250 is not aware of OMAP PM.
>    
>     However  it would be more reasonable to merge PM stuff to
> omap-serial.c. since the new driver is already OMAP specific
>     
> 2. There is an issue for DMA  with current implementation in serial.c 
>     When Rx DMA is active NO Rx IRQ will be generated.
>     So serial.c will easily set uart->can_sleep with "1" even there is
> Rx DMA ongoing
>     +	if ((iir & 0x4) && up->use_dma) {
>     +		up->ier &= ~UART_IER_RDI;
>     +		serial_out(up, UART_IER, up->ier
>
>    In my view, the best way is to do the idle detection in
> omap_serial.c.

FWIW, as the author of much of the PM hacker in mach-omap2/serial.c, I
agree with Tao.

The only reason for the PM hackery in mach-omap2/serial.c is because
of the limitations of the 8250 driver.

Kevin

