From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Fri, 15 Apr 2011 16:52:38 +0300
Message-ID: <20110415135237.GA9513@zarco>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34492 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754588Ab1DONwy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Apr 2011 09:52:54 -0400
Content-Disposition: inline
In-Reply-To: <20110415130607.GM1611@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Nori, Sekhar" <nsekhar@ti.com>, "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Russel,

Just small comment,

On Fri, Apr 15, 2011 at 08:06:07AM -0500, Russell King wrote:

> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index a3f50b3..3588749 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -75,7 +75,6 @@
>  static unsigned long omap_sram_start;
>  static unsigned long omap_sram_base;
>  static unsigned long omap_sram_size;
> -static unsigned long omap_sram_ceil;

I think you missed one occurrence of omap_sram_ceil at omap3_sram_restore_context.
Probably you have compile-tested w/o CONFIG_PM?

All best,

-- 
Eduardo Valentin
