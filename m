From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP 3530 - DPLL4 Clock
Date: Wed, 19 May 2010 17:46:24 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005191726270.27473@utopia.booyaka.com>
References: <AANLkTilMVZOU8TpocEGIZzI6GA3G5AM0aeg6lgaKBqBy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44722 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945Ab0ESXqZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 19:46:25 -0400
In-Reply-To: <AANLkTilMVZOU8TpocEGIZzI6GA3G5AM0aeg6lgaKBqBy@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Danilo Caravana <danilo.caravana@gmail.com>
Cc: linux-omap@vger.kernel.org

On Wed, 19 May 2010, Danilo Caravana wrote:

> I'm using Linux kernel on my OMAP 3530 product, but i need the McSPI 
> running at exactly 6,5 Mhz.  The problem is that McSPI clocks is derived 
> from DPLL4 which has a 96 MHz output.

You might be able to change the source of 48M_FCLK to come from the OMAP's 
sys_altclk ball via clk_set_parent(), and feed an external 6.5MHz clock 
(or some multiple) in sys_altclk.  HDQ/1WIRE, UART1, UART2 would be 
affected also, but maybe you don't need those.

Of course, that will probably mean a board change...

> I need to change the DPLL4 clock in Linux, and need everything else
> working (Except USB, which need 48MHz).

You could also try reducing the DPLL4 frequency with clk_set_rate(), but 
that really could affect many other peripherals.

USB should be clocked by DPLL5, so you should be safe there.

> Analysing the kernel code, I couldn't find where the DPLL4 is set

It's probably set by your bootloader, usually X-Loader or U-Boot.


- Paul
