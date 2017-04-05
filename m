From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH] misc: sram-exec: Use aligned fncpy instead of memcpy
Date: Wed, 5 Apr 2017 14:22:33 -0500
Message-ID: <ab1583fc-0560-b4d2-851b-4be6201edf8b@ti.com>
References: <20170405192120.1009-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170405192120.1009-1-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: Keerthy J <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Russell,
On 04/05/2017 02:21 PM, Dave Gerlach wrote:
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
> sram_exec_copy.
>
> In the future, architectures hoping to make use of the sram-exec
> functionality must define an fncpy macro just as ARM has done to
> guarantee or check for safe copying to executable memory before allowing
> the arch to select CONFIG_SRAM_EXEC.
>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  drivers/misc/sram-exec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/sram-exec.c b/drivers/misc/sram-exec.c
> index ac522417c462..0057eabe5c03 100644
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
> @@ -93,7 +94,7 @@ int sram_exec_copy(struct gen_pool *pool, void *dst, void *src,
>  	set_memory_nx((unsigned long)base, pages);
>  	set_memory_rw((unsigned long)base, pages);
>
> -	memcpy(dst, src, size);
> +	fncpy(dst, src, size);
>
>  	set_memory_ro((unsigned long)base, pages);
>  	set_memory_x((unsigned long)base, pages);
>

Does this address your concerns from here [1]? Because the only user of this 
code is ARM right now I already only build the sram-exec code in if CONFIG_ARM 
is selected. I originally split the sram-exec code into its own file as it 
already depends on the changes you made to set_memory_* APIs for ARM which we 
have a hard dependency on here, and not all platforms support this. So this 
allowed me to constrain the sram_exec code to platforms with the proper 
set_memory_* APIs defined, but also now this lets us directly use the fncpy 
macro in this driver. For future platforms that want to make use of sram_exec we 
set the constraint that an arch must:

* Support the required set_memory_* APIs
* Define a fncpy macro that guarantees safe movement of a function.

This seems reasonable to me and gives support for ARM right away with a path 
forward for additional architectures to support sram_exec.

Regards,
Dave

[1] https://www.spinics.net/lists/arm-kernel/msg574481.html
