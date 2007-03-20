From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix USB compilation for N770 defconfig
Date: Tue, 20 Mar 2007 11:45:28 -0400
Message-ID: <20070320154525.GJ19913@atomide.com>
References: <45FD1481.6010602@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <45FD1481.6010602@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [070318 06:35]:
> 
> linux/usb_ch9.h is now linux/usb/ch9.h
> 
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
> 

> Index: linux-osk/drivers/cbus/tahvo-usb.c
> ===================================================================
> --- linux-osk.orig/drivers/cbus/tahvo-usb.c
> +++ linux-osk/drivers/cbus/tahvo-usb.c
> @@ -33,7 +33,7 @@
>  #include <linux/slab.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> -#include <linux/usb_ch9.h>
> +#include <linux/usb/ch9.h>
>  #include <linux/usb_gadget.h>
>  #include <linux/usb.h>
>  #include <linux/usb/otg.h>
> 

Pushing today.

Tony
