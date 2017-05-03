From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v2] misc: sram-exec: Use aligned fncpy instead of memcpy
Date: Wed, 3 May 2017 19:55:33 +0100
Message-ID: <20170503185533.GS23750@n2100.armlinux.org.uk>
References: <20170410145247.6023-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170410145247.6023-1-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Keerthy J <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 10, 2017 at 09:52:47AM -0500, Dave Gerlach wrote:
> Currently the sram-exec functionality, which allows allocation of
> executable memory and provides an API to move code to it, is only
> selected in configs for the ARM architecture. Based on commit
> 5756e9dd0de6 ("ARM: 6640/1: Thumb-2: Symbol manipulation macros for
> function body copying") simply copying a C function pointer address
> using memcpy without consideration of alignment and Thumb is unsafe on
> ARM platforms.
> 
> The aforementioned patch introduces the fncpy macro which is a safe way
> to copy executable code on ARM platforms, so let's make use of that here
> rather than the unsafe plain memcpy that was previously used by
> sram_exec_copy. Now sram_exec_copy will move the code to "dst" and
> return an address that is guaranteed to be safely callable.
> 
> In the future, architectures hoping to make use of the sram-exec
> functionality must define an fncpy macro just as ARM has done to
> guarantee or check for safe copying to executable memory before allowing
> the arch to select CONFIG_SRAM_EXEC.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Looks a lot saner, thanks.  It's just a bit sad that we lose the type
checking.

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

> ---
> 
> v1: http://www.spinics.net/lists/linux-omap/msg136517.html
> 
> v2 changes: Return value of fncpy, as the returned address is the safely
> 	    executable one, and add supporting docs in comments.
> 
>  drivers/misc/sram-exec.c | 27 ++++++++++++++++++++-------
>  include/linux/sram.h     |  8 ++++----
>  2 files changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/misc/sram-exec.c b/drivers/misc/sram-exec.c
> index ac522417c462..9d54e14e8360 100644
> --- a/drivers/misc/sram-exec.c
> +++ b/drivers/misc/sram-exec.c
> @@ -19,6 +19,7 @@
>  #include <linux/sram.h>
>  
>  #include <asm/cacheflush.h>
> +#include <asm/fncpy.h>
>  
>  #include "sram.h"
>  
> @@ -57,20 +58,32 @@ int sram_add_protect_exec(struct sram_partition *part)
>   * @src: Source address for the data to copy
>   * @size: Size of copy to perform, which starting from dst, must reside in pool
>   *
> + * Return: Address for copied data that can safely be called through function
> + *	   pointer, or NULL if problem.
> + *
>   * This helper function allows sram driver to act as central control location
>   * of 'protect-exec' pools which are normal sram pools but are always set
>   * read-only and executable except when copying data to them, at which point
>   * they are set to read-write non-executable, to make sure no memory is
>   * writeable and executable at the same time. This region must be page-aligned
>   * and is checked during probe, otherwise page attribute manipulation would
> - * not be possible.
> + * not be possible. Care must be taken to only call the returned address as
> + * dst address is not guaranteed to be safely callable.
> + *
> + * NOTE: This function uses the fncpy macro to move code to the executable
> + * region. Some architectures have strict requirements for relocating
> + * executable code, so fncpy is a macro that must be defined by any arch
> + * making use of this functionality that guarantees a safe copy of exec
> + * data and returns a safe address that can be called as a C function
> + * pointer.
>   */
> -int sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
> -		   size_t size)
> +void *sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
> +		     size_t size)
>  {
>  	struct sram_partition *part = NULL, *p;
>  	unsigned long base;
>  	int pages;
> +	void *dst_cpy;
>  
>  	mutex_lock(&exec_pool_list_mutex);
>  	list_for_each_entry(p, &exec_pool_list, list) {
> @@ -80,10 +93,10 @@ int sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
>  	mutex_unlock(&exec_pool_list_mutex);
>  
>  	if (!part)
> -		return -EINVAL;
> +		return NULL;
>  
>  	if (!addr_in_gen_pool(pool, (unsigned long)dst, size))
> -		return -EINVAL;
> +		return NULL;
>  
>  	base = (unsigned long)part->base;
>  	pages = PAGE_ALIGN(size) / PAGE_SIZE;
> @@ -93,13 +106,13 @@ int sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
>  	set_memory_nx((unsigned long)base, pages);
>  	set_memory_rw((unsigned long)base, pages);
>  
> -	memcpy(dst, src, size);
> +	dst_cpy = fncpy(dst, src, size);
>  
>  	set_memory_ro((unsigned long)base, pages);
>  	set_memory_x((unsigned long)base, pages);
>  
>  	mutex_unlock(&part->lock);
>  
> -	return 0;
> +	return dst_cpy;
>  }
>  EXPORT_SYMBOL_GPL(sram_exec_copy);
> diff --git a/include/linux/sram.h b/include/linux/sram.h
> index c97dcbe8ce25..4fb405fb0480 100644
> --- a/include/linux/sram.h
> +++ b/include/linux/sram.h
> @@ -16,12 +16,12 @@
>  struct gen_pool;
>  
>  #ifdef CONFIG_SRAM_EXEC
> -int sram_exec_copy(struct gen_pool *pool, void *dst, void *src, size_t size);
> +void *sram_exec_copy(struct gen_pool *pool, void *dst, void *src, size_t size);
>  #else
> -static inline int sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
> -				 size_t size)
> +static inline void *sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
> +				   size_t size)
>  {
> -	return -ENODEV;
> +	return NULL;
>  }
>  #endif /* CONFIG_SRAM_EXEC */
>  #endif /* __LINUX_SRAM_H__ */
> -- 
> 2.11.0
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
