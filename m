From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v4 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Mon, 25 Jun 2012 11:12:14 -0500
Message-ID: <4FE88DDE.60601@ti.com>
References: <cover.1340354985.git.afzal@ti.com> <7a14edf83068261d8c07217873d14fe7f73975bc.1340354986.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47732 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753645Ab2FYQMT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 12:12:19 -0400
In-Reply-To: <7a14edf83068261d8c07217873d14fe7f73975bc.1340354986.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Afzal,

Looks much better!

On 06/22/2012 04:01 AM, Afzal Mohammed wrote:
> Reorganize gpmc-onenand initialization so that changes
> required for gpmc driver migration can be made smooth.
> 
> Ensuring sync read/write are disabled in onenand cannot
> be expected to work properly unless GPMC is setup, this
> has been removed.
> 
> Refactor set_async_mode & set_sync_mode functions to
> separate out timing calculation & actual configuration
> (GPMC & OneNAND side).
> 
> Thanks to Jon for his suggestions.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
> 
> v4:
> Reorganize set_sync/async functions in a better way
> v3:
> Refactor set_sync/async functions to separate out timing and
>  configurations
> v2:
> Move ensuring that async mode in OneNAND has been setup from
>  set_sync to setup function, improve commit message
> 
>  arch/arm/mach-omap2/gpmc-onenand.c |  153 +++++++++++++++++++-----------------
>  1 file changed, 83 insertions(+), 70 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
> index 8863e0a..878182b 100644
> --- a/arch/arm/mach-omap2/gpmc-onenand.c
> +++ b/arch/arm/mach-omap2/gpmc-onenand.c
> @@ -15,6 +15,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/mtd/onenand_regs.h>
>  #include <linux/io.h>
> +#include <linux/err.h>
>  
>  #include <asm/mach/flash.h>
>  
> @@ -25,6 +26,7 @@
>  
>  #define	ONENAND_IO_SIZE	SZ_128K
>  
> +static int hf, vhf, sync_read, sync_write, latency;

I am wondering if we can remove hf, vhf, sync_read/write variables
completely. We already have flags from sync_read/write and so we could
just use the cfg->flags variable and remove sync_read/write variables.

At the same time, we could create flags for ONENAND_FREQ_HF and
ONENAND_FREQ_VHF or something like that. It could be nice to store the
latency in onenand_data too. In other words, keep all the configuration
in one place.

Otherwise looks good.

Cheers
Jon
