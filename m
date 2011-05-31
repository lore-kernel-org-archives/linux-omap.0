From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH v4] Consolidate SRAM support
Date: Tue, 31 May 2011 22:21:42 +0100
Message-ID: <20110531212142.GA6700@n2100.arm.linux.org.uk>
References: <20110512174546.GB8633@n2100.arm.linux.org.uk> <1306371777-20431-1-git-send-email-plagnioj@jcrosoft.com> <B85A65D85D7EB246BE421B3FB0FBB593024D234457@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41952 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932528Ab1EaVWD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 17:22:03 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D234457@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Sascha Hauer <kernel@pengutronix.de>

On Tue, May 31, 2011 at 10:39:48PM +0530, Nori, Sekhar wrote:
> I also found some check patch errors. Feel free to merge
> the attached patch.

And this introduces another style issue...

> diff --git a/arch/arm/plat-mxc/include/mach/iram.h b/arch/arm/plat-mxc/include/mach/iram.h
> index 8279c47..aae5e35 100644
> --- a/arch/arm/plat-mxc/include/mach/iram.h
> +++ b/arch/arm/plat-mxc/include/mach/iram.h
> @@ -31,7 +31,7 @@ static inline void *iram_alloc(size_t size, phys_addr_t *phys)
>  
>  	*phys = gen_pool_virt_to_phys(iram_pool, addr);
>  
> -	return (void*)addr;
> +	return (void *) addr;

The style here is:
	return (void *)addr;
