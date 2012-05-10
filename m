From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 2/3] ARM: OMAP AM35xx: clock and hwmod data: fix UART4
 data
Date: Thu, 10 May 2012 12:36:25 -0700
Message-ID: <20120510193625.GD20494@animalcreek.com>
References: <20120510172449.13418.66815.stgit@dusk>
 <20120510172917.13418.14437.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:33753 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760771Ab2EJTg1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 15:36:27 -0400
Content-Disposition: inline
In-Reply-To: <20120510172917.13418.14437.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kyle Manna <kyle.manna@fuel7.com>, Ranjith Lohithakshan <ranjithl@ti.com>

On Thu, May 10, 2012 at 11:29:18AM -0600, Paul Walmsley wrote:
> Add missing terminators to the arrays of IRQ, DMA, and address space
> structure records in the AM35xx UART4 hwmod data.  Without these
> terminators, the following warnings appear on boot:
> 
> omap_uart.3: failed to claim resource 58
> omap_device: omap_uart: build failed (-16)
> WARNING: at /home/paul/linux/arch/arm/mach-omap2/serial.c:375 omap_serial_init_port+0x198/0x284()
> Could not build omap_device for omap_uart: uart4.
> 
> Also, AM35xx uart4_fck has an incorrect parent clock pointer.  Fix it
> and clean up a whitespace issue.
> 
> Fix some incorrectly-named macros related to AM35xx UART4.
> 
> Cc: Kyle Manna <kyle.manna@fuel7.com>
> Cc: Mark A. Greer <mgreer@animalcreek.com>
> Cc: Ranjith Lohithakshan <ranjithl@ti.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Acked-by: Mark A. Greer <mgreer@animalcreek.com>
(on an am3517evm)
