From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix USB compilation for N800 defconfig
Date: Tue, 6 Mar 2007 02:42:16 -0800
Message-ID: <20070306104215.GD24639@atomide.com>
References: <45EA9F9F.3010305@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <45EA9F9F.3010305@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [070304 02:31]:
> 
> linux/usb_ch9.h has moved to linux/usb/ch9.h
> 
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
> 
> 

> Index: linux-osk/drivers/usb/musb/musbdefs.h
> ===================================================================
> --- linux-osk.orig/drivers/usb/musb/musbdefs.h
> +++ linux-osk/drivers/usb/musb/musbdefs.h
> @@ -40,7 +40,7 @@
>  #include <linux/smp_lock.h>
>  #include <linux/errno.h>
>  #include <linux/device.h>
> -#include <linux/usb_ch9.h>
> +#include <linux/usb/ch9.h>
>  #include <linux/usb_gadget.h>
>  #include <linux/usb.h>
>  #include <linux/usb/otg.h>
> 

Pushing today.

Tony
