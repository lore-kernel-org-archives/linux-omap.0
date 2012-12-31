From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2xxx: PM: enter WFI via inline asm if CORE
 stays active
Date: Mon, 31 Dec 2012 13:57:28 +0530
Message-ID: <50E14C70.2090700@ti.com>
References: <20121230182745.30526.47072.stgit@dusk.lan> <20121230182826.30526.27155.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50417 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759Ab2LaI0j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Dec 2012 03:26:39 -0500
In-Reply-To: <20121230182826.30526.27155.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, Richard Woodruff <r-woodruff2@ti.com>

On Sunday 30 December 2012 11:58 PM, Paul Walmsley wrote:
> There shouldn't be any need to jump to SRAM code if the OMAP CORE
> clockdomain (and consequently the SDRAM controller and CORE PLL) stays
> active during MPU WFI.  The SRAM code should only be needed when the RAM
> enters self-refresh.  So in the case where CORE stays active, just call
> WFI directly from the mach-omap2/pm24xx.c code.  This removes some
> unnecessary SRAM code.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Richard Woodruff <r-woodruff2@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
This sounds correct to me.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

