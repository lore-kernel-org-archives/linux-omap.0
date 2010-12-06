From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/9] TILER-DMM: Main TILER driver implementation
Date: Mon, 6 Dec 2010 15:21:59 -0800
Message-ID: <20101206232159.GS8345@atomide.com>
References: <1291674446-10766-1-git-send-email-davidsin@ti.com>
 <1291674446-10766-8-git-send-email-davidsin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1291674446-10766-8-git-send-email-davidsin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Sin <davidsin@ti.com>
Cc: Greg KH <greg@kroah.com>, Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lajos Molnar <molnar@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* David Sin <davidsin@ti.com> [101206 14:09]:
> From: Lajos Molnar <molnar@ti.com>
> 
> This patch contains the TILER driver and implementation of the TILER
> block manipulation and mapping functions.
> 
> It also contains the makefile and config file for the TILER driver.

...
> +config TILER_GRANULARITY
> +        int "Allocation granularity"
> +        range 1 4096
> +        default 128
...
> +config TILER_ALIGNMENT
> +        int "Allocation alignment"
> +        range 1 4096
> +        default 4096
...
> +config TILER_CACHE_LIMIT
> +        int "Memory limit to cache free pages in MBytes"
> +        range 0 128
> +        default 40
...

Do you really need these Kconfig options? To me it seems you
should pass these in platform_data.

Regards,

Tony
