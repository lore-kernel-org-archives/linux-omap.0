From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [RFC PATCH 1/3] asm-generic: io: Add exec versions of ioremap
Date: Thu, 12 May 2016 17:37:59 +0100
Message-ID: <20160512163759.GW5783@n2100.arm.linux.org.uk>
References: <1462830111-28172-1-git-send-email-d-gerlach@ti.com>
 <1462830111-28172-2-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462830111-28172-2-git-send-email-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Russ Dill <russ.dill@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>, Tony Lindgren <tony@atomide.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, May 09, 2016 at 04:41:49PM -0500, Dave Gerlach wrote:
> diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> index 66a978d05958..c6eef3c98074 100644
> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -400,6 +400,20 @@ EXPORT_SYMBOL(ioremap_wc);
>   * clocks that would affect normal memory for example. Please see
>   * CONFIG_GENERIC_ALLOCATOR for allocating external memory.
>   */
> +void __iomem *ioremap_exec(resource_size_t res_cookie, size_t size)
> +{
> +	return arch_ioremap_caller(res_cookie, size, MT_MEMORY_RWX,
> +				   __builtin_return_address(0));
> +}
> +EXPORT_SYMBOL(ioremap_exec);
> +
> +void __iomem *ioremap_exec_nocache(resource_size_t res_cookie, size_t size)
> +{
> +	return arch_ioremap_caller(res_cookie, size, MT_MEMORY_RWX_NONCACHED,
> +				   __builtin_return_address(0));
> +}
> +EXPORT_SYMBOL(ioremap_exec_nocache);

I think these should be called memremap_exec() and similar.  Please
see the description of memremap() in kernel/memremap.c.  If you're
going to be executing code, the region must not have I/O side effects
and according to the new definition of memremap() vs ioremap(), the
memremap() interfaces fit better.

Please also get these reviewed by Dan Williams who provided the
memremap() API.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
