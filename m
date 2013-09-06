From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 0/4] Create infrastructure for running C code from SRAM.
Date: Fri, 6 Sep 2013 12:12:21 +0100
Message-ID: <20130906111221.GH25647@n2100.arm.linux.org.uk>
References: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53598 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab3IFLN1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Sep 2013 07:13:27 -0400
Content-Disposition: inline
In-Reply-To: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, mans@mansr.com, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>

On Tue, Sep 03, 2013 at 09:44:21AM -0700, Russ Dill wrote:
> SRAM handling code is in the process of being moved from arch directories
> into drivers/misc/sram.c using device tree and genalloc [1] [2]. This RFC
> patchset builds on that, including the limitation that the SRAM address is
> not known at compile time. Because the SRAM address is not known at compile
> time, the code that runs from SRAM must be compiled with -fPIC. Even if
> the code were loaded to a fixed virtual address, portions of the code must
> often be run with the MMU disabled.

What are you doing about the various gcc utility functions that may be
implicitly called from C code such as memcpy and memset?

> The general idea is that for each SRAM user (such as an SoC specific
> suspend/resume mechanism) to create a group of sections. The section group
> is created with a single macro for each user, but end up looking like this:
> 
> .sram.am33xx : AT(ADDR(.sram.am33xx) - 0) {
>   __sram_am33xx_start = .;
>   *(.sram.am33xx.*)
>   __sram_am33xx_end = .;
> }
> 
> Any data or functions that should be copied to SRAM for this use should be
> maked with an appropriate __section() attribute. A helper is then added for
> translating between the original kernel symbol, and the address of that
> function or variable once it has been copied into SRAM. Once control is
> passed to a function within the SRAM section grouping, it can access any
> variables or functions within that same SRAM section grouping without
> translation.

What about the relocations which will need to be fixed up - eg, addresses
in the literal pool, the GOT table contents, etc?  You say nothing about
this.
