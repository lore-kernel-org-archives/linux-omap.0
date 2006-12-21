From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Remove unnecessary memset in dsp task.c
Date: Thu, 21 Dec 2006 15:02:41 -0800
Message-ID: <20061221230240.GI10399@atomide.com>
References: <3a5b1be00612041027h2e3cefefwf140897ee1bb4717@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <3a5b1be00612041027h2e3cefefwf140897ee1bb4717@mail.gmail.com>
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
Cc: linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal.shah802003@gmail.com> [061204 10:33]:
> There is much more duplicated code can be removed in task.c by using
> already available wait_for_event_{un}interruptible_{timeout},
> prepare_wait, finish_wait etc calls. What do you say?
> 
> -- 
> ---Komal Shah
> http://komalshah.blogspot.com

> From 4e89cea55f7aa2162a7541106443eef609666ed0 Mon Sep 17 00:00:00 2001
> From: Komal Shah <komal_shah802003@yahoo.com>
> Date: Mon, 4 Dec 2006 23:52:11 +0530
> Subject: [PATCH] ARM: OMAP: Remove unnecessary memset in dsp task.c
> 
> - and remove commented "struct device_driver"
> 
> Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>
> ---
>  arch/arm/plat-omap/dsp/task.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dsp/task.c b/arch/arm/plat-omap/dsp/task.c
> index 7fcc06a..807c408 100644
> --- a/arch/arm/plat-omap/dsp/task.c
> +++ b/arch/arm/plat-omap/dsp/task.c
> @@ -108,7 +108,6 @@ struct rcvdt_bk_struct {
>  
>  struct taskdev {
>  	struct bus_type *bus;
> -//	struct device_driver *driver;
>  	struct device dev;	/* Generic device interface */
>  
>  	long state;
> @@ -564,9 +563,6 @@ int dsp_task_config_all(u8 n)
>  	struct dsptask *taskheap;
>  	size_t devheapsz, taskheapsz;
>  
> -	memset(taskdev, 0, sizeof(void *) * TASKDEV_MAX);
> -	memset(dsptask, 0, sizeof(void *) * TASKDEV_MAX);
> -
>  	printk(KERN_INFO "omapdsp: found %d task(s)\n", n);
>  	if (n == 0)
>  		return 0;

Pushing today.

Tony
