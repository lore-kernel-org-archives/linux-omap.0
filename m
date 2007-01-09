From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Workqueue changes for retu-rtc
Date: Tue, 9 Jan 2007 15:23:23 -0800
Message-ID: <20070109232323.GL7384@atomide.com>
References: <459D2D8D.1060705@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <459D2D8D.1060705@googlemail.com>
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

* Dirk Behme <dirk.behme@googlemail.com> [070104 08:39]:
> 
> ARM: OMAP: Workqueue changes for retu-rtc.c
> 
> Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>
> 

> Index: linux-osk/drivers/cbus/retu-rtc.c
> ===================================================================
> --- linux-osk.orig/drivers/cbus/retu-rtc.c
> +++ linux-osk/drivers/cbus/retu-rtc.c
> @@ -40,6 +40,7 @@
>  #include <linux/completion.h>
>  #include <linux/platform_device.h>
>  #include <linux/mutex.h>
> +#include <linux/workqueue.h>
>  
>  #include "cbus.h"
>  #include "retu.h"
> @@ -312,13 +313,13 @@ static void retu_rtca_disable(void)
>  	retu_write_reg(RETU_REG_RTCHMAR, (24 << 8) | 60);
>  }
>  
> -static void retu_rtca_expired(void *data)
> +static void retu_rtca_expired(struct work_struct *unused)
>  {
>  	retu_rtca_disable();
>  	sysfs_notify(&retu_rtc_driver.kobj, NULL, "alarm_expired");
>  }
>  
> -DECLARE_WORK(retu_rtca_work, retu_rtca_expired, NULL);
> +DECLARE_WORK(retu_rtca_work, retu_rtca_expired);
>  
>  /*
>   * RTCHMR RTCHMAR RTCCAL must be accessed within 0.9 s since the seconds
> 

Pushing today.

Tony
