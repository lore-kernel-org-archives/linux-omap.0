From: tony@atomide.com
Subject: Re: [PATCH] ARM: OMAP: Remove platform_device.h from dsp.h
Date: Thu, 30 Nov 2006 15:08:34 -0800
Message-ID: <20061130230833.GG9605@atomide.com>
References: <3a5b1be00611301252j4f5d6f22ydf389457982f3c58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <3a5b1be00611301252j4f5d6f22ydf389457982f3c58@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal.shah802003@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal.shah802003@gmail.com> [061130 12:53]:
> -- 
> ---Komal Shah
> http://komalshah.blogspot.com

> From 2b552fefc1ff873b1ccc2c6657b5bce758458897 Mon Sep 17 00:00:00 2001
> From: Komal Shah <komal_shah802003@yahoo.com>
> Date: Fri, 1 Dec 2006 02:19:17 +0530
> Subject: [PATCH] ARM: OMAP: Remove platform_device.h from dsp.h
> 
> - Remove unnecessary #include <linux/platform_device.h>
> 
> Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>
> ---
>  arch/arm/plat-omap/dsp/dsp.h |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dsp/dsp.h b/arch/arm/plat-omap/dsp/dsp.h
> index 64d22c6..3535659 100644
> --- a/arch/arm/plat-omap/dsp/dsp.h
> +++ b/arch/arm/plat-omap/dsp/dsp.h
> @@ -21,7 +21,6 @@
>   *
>   */
>  
> -#include <linux/platform_device.h>
>  #include "hardware_dsp.h"
>  #include "dsp_common.h"
>  

Pushing today.

Tony
