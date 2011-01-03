From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 2/4] TI816X: Update common OMAP machine specific
 sources
Date: Mon, 3 Jan 2011 16:11:17 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101031607340.10403@utopia.booyaka.com>
References: <1294075746-22453-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48180 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab1ACXLS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 18:11:18 -0500
In-Reply-To: <1294075746-22453-1-git-send-email-hemantp@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@deeprootsystems.com

On Mon, 3 Jan 2011, Hemant Pedanekar wrote:

> Note2: The optimized irq macro for omap3 skips checking the 4th irq status
> register but this needs to be added for TI816X (interrupts 96 to 127).
> Presently, only the multi-omap irq macro (unoptimized) is updated to check the
> 4th status register.

Sounds like you should either add an #ifdef CONFIG_ARCH_OMAPTI816X (or 
whatever macro name you use) to the optimized version to check the fourth 
ISR.  Either that, or add code to force a MULTI_OMAP build when compiling 
for this chip.  Otherwise if someone builds an "optimized", non-multi-OMAP 
kernel for this chip, they'll be pretty surprised when it misses 
interrupts from that fourth bank.


- Paul
