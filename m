From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 03/14] ARM: OMAP4+: CM: Move function prototypes to common
 header for re-use
Date: Sat, 8 Jun 2013 17:44:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306081743280.7001@utopia.booyaka.com>
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com> <1369845494-30231-4-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:51953 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab3FHRoQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Jun 2013 13:44:16 -0400
In-Reply-To: <1369845494-30231-4-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, 29 May 2013, Santosh Shilimkar wrote:

> OMAP5 reuses OMAP4 CM IP block which lets us re-use CM1/CM2 functions.
> So move the function prototypes from cm1_44xx.h, cm2_44xx.h to
> cm_prm44xx_54xx.h header. The suggestion came from Paul Walmsley
> as part of the OMAP5 data file review.
> 
> This is preparatory  patch to add OMAP5 CM data file.
> 
> Cc: Paul Walmsley <paul@pwsan.com>

...

> new file mode 100644
> index 0000000..4154f86
> --- /dev/null
> +++ b/arch/arm/mach-omap2/cm_44xx_54xx.h
> @@ -0,0 +1,36 @@
> +/*
> + * OMAP44xx and OMAP54xx CM1/CM2 function prototypes
> + *
> + * Copyright (C) 2009-201333 Texas Instruments, Inc.

Heh, looks like someone's a vi user ;-)

Fixed in the local copy here.


- Paul
