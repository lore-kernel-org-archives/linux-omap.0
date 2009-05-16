From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RESUBMIT][PATCH 3/7] OMAP4: Update common omap platform
	headers.
Date: Sat, 16 May 2009 10:30:17 +0100
Message-ID: <20090516093017.GG15328@n2100.arm.linux.org.uk>
References: <1241677756-28756-1-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-2-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56263 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668AbZEPJaZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 05:30:25 -0400
Content-Disposition: inline
In-Reply-To: <1241677756-28756-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Thu, May 07, 2009 at 11:59:12AM +0530, Santosh Shilimkar wrote:
> This patch updates the common platform headers files for OMAP4430.
> On OMAP4, GIC is used instead of INTC, hence all the private peripheral
> interrupts are shifted by an offset of 32. So if the hardcoding is not
> done for IRQ lines in drivers, then this change won't impact any driver.

Just one small nit.

> diff --git a/arch/arm/plat-omap/include/mach/entry-macro.S b/arch/arm/plat-omap/include/mach/entry-macro.S
> index 2276f89..62bcb1b 100644
> --- a/arch/arm/plat-omap/include/mach/entry-macro.S
> +++ b/arch/arm/plat-omap/include/mach/entry-macro.S
> @@ -3,6 +3,9 @@
>   *
>   * Low-level IRQ helper macros for OMAP-based platforms
>   *
> + * Copyright (C) 2009 Texas Instruments
> + * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>*

I don't think you want that trailing *
