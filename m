From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: [PATCH] twl4030-rtc support on 3430
Date: Mon, 10 Dec 2007 19:23:42 +0300
Message-ID: <475D680E.7040802@gmail.com>
References: <01ee01c83b2e$1277e1c0$988818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <01ee01c83b2e$1277e1c0$988818ac@ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Girish <girishsg@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Girish,

Girish wrote:
> Hi,
> This patch supports TWL4030 RTC on 3430 and adds periodic interrupts functionality through framework. Also, some code cleanup.
>
could you split your patch into two parts: 1) rtc-twl4030 update and 2)
OMAP3430-specific code.


> Regards,
> Girish
>
>
> ---
>  arch/arm/configs/omap_3430sdp_defconfig |    4 +-
>  arch/arm/mach-omap2/board-3430sdp.c     |   62 ++++++++++++++++++++++++++++++++
>  drivers/rtc/rtc-twl4030.c               |   46 +++++++++++++++++++++--
>  3 files changed, 106 insertions(+), 6 deletions(-)
>
[snip]
>
>  
>  static inline void __init sdp3430_init_smc91x(void)
> Index: linux-omap-dec10/drivers/rtc/rtc-twl4030.c
> ===================================================================
> --- linux-omap-dec10.orig/drivers/rtc/rtc-twl4030.c	2007-12-10 11:20:43.000000000 +0530
> +++ linux-omap-dec10/drivers/rtc/rtc-twl4030.c	2007-12-10 12:06:07.992689883 +0530
> @@ -353,6 +353,31 @@
>  	return ret;
>  }
>  
> +/*
> + * We will just handle setting the frequency and make use the framework for
> + * reading the periodic interupts.
> + *
> + * @freq: Current periodic IRQ freq:
> + * 		bit 0: every second
> + * 		bit 1: every minute
> + * 		bit 2: every hour
> + * 		bit 3: every day
> + */

Note, this breaks an assumption that freq is measured in Hz. For
example, RTC Driver Test/Example Program won't pass the "test_PIE" part.


Regards,
Dmitry
