From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v13 11/11] OMAP: dmtimer: convert to a driver
Date: Fri, 29 Apr 2011 16:21:45 +0530
Message-ID: <4DBA9841.1080508@ti.com>
References: <1302969063-8231-1-git-send-email-tarun.kanti@ti.com> <1302969063-8231-12-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:59035 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758574Ab1D2KwO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Apr 2011 06:52:14 -0400
Received: by gwj17 with SMTP id 17so1680815gwj.24
        for <linux-omap@vger.kernel.org>; Fri, 29 Apr 2011 03:52:12 -0700 (PDT)
In-Reply-To: <1302969063-8231-12-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org

Tarun,

On 4/16/2011 9:21 PM, Tarun Kanti DebBarma wrote:
> Make plat-omap/dmtimer.c a normal driver. It is moved to drivers/misc
> as timer-omap.c and the corresponding header file has been moved to
> include/linux as timer-omap.h. Files which included plat/dmtimer.h
> are changed to include linux/timer-omap.h now.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---
>   arch/arm/mach-omap1/dmtimer.c              |    3 +-
>   arch/arm/mach-omap1/pm.c                   |    2 +-
>   arch/arm/mach-omap1/timer32k.c             |    2 +-
>   arch/arm/mach-omap2/omap_hwmod_2420_data.c |    3 +-
>   arch/arm/mach-omap2/omap_hwmod_2430_data.c |    3 +-
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    3 +-
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
>   arch/arm/mach-omap2/pm-debug.c             |    2 +-
>   arch/arm/mach-omap2/timer.c                |    2 +-
>   arch/arm/plat-omap/Makefile                |    1 -
>   drivers/misc/Makefile                      |    1 +
>   drivers/misc/timer-omap.c                  |  643 ++++++++++++++++++++++++++++
>   drivers/tty/serial/omap-serial.c           |    2 +-
>   include/linux/timer-omap.h                 |  351 +++++++++++++++
>   14 files changed, 1008 insertions(+), 12 deletions(-)
>   create mode 100644 drivers/misc/timer-omap.c
>   create mode 100644 include/linux/timer-omap.h
>

[...]

> diff --git a/drivers/misc/timer-omap.c b/drivers/misc/timer-omap.c
> new file mode 100644
> index 0000000..4ee0571
> --- /dev/null
> +++ b/drivers/misc/timer-omap.c
[...]

> +
> +#if defined(CONFIG_ARCH_OMAP1)

Well this is suppose to be device driver so no place
for SOC #ifdef. You should remove this ...

> +
> +/**
> + * omap_dm_timer_modify_idlect_mask - Check if any running timers use ARMXOR
> + * @inputmask: current value of idlect mask
> + */
> +__u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
> +{
> +	int i = 0;
> +	struct omap_dm_timer *timer = NULL;
> +
> +	/* If ARMXOR cannot be idled this function call is unnecessary */
> +	if (!(inputmask&  (1<<  1)))
> +		return inputmask;
> +

[...]

> + * omap_dm_timer_probe - probe function called for every registered device
> + * @pdev:	pointer to current timer platform device
> + *
> + * Called by driver framework at the end of device registration for all
> + * timer devices.
> + */
> +static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct omap_dm_timer *timer;
> +	struct resource *mem, *irq, *ioarea;
> +	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
> +
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "%s: no platform data.\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (unlikely(!irq)) {
> +		dev_err(&pdev->dev, "%s: no IRQ resource.\n", __func__);
> +		ret = -ENODEV;
> +		goto err_free_pdev;
> +	}
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (unlikely(!mem)) {
> +		dev_err(&pdev->dev, "%s: no memory resource.\n", __func__);
> +		ret = -ENODEV;
> +		goto err_free_pdev;
> +	}
> +
> +	ioarea = request_mem_region(mem->start, resource_size(mem),
> +			pdev->name);
> +	if (!ioarea) {
> +		dev_err(&pdev->dev, "%s: region already claimed.\n", __func__);
> +		ret = -EBUSY;
> +		goto err_free_pdev;
> +	}
> +
> +	timer = kzalloc(sizeof(struct omap_dm_timer), GFP_KERNEL);
> +	if (!timer) {
> +		dev_err(&pdev->dev, "%s: no memory for omap_dm_timer.\n",
> +			__func__);
> +		ret = -ENOMEM;
> +		goto err_release_ioregion;
> +	}
> +
> +	timer->io_base = ioremap(mem->start, resource_size(mem));
> +	if (!timer->io_base) {
> +		dev_err(&pdev->dev, "%s: ioremap failed.\n", __func__);
> +		ret = -ENOMEM;
> +		goto err_free_mem;
> +	}
> +
> +	if (pdata->timer_ip_type == OMAP_TIMER_IP_VERSION_2) {
> +		timer->func_offset = VERSION2_TIMER_WAKEUP_EN_REG_OFFSET;
> +		timer->intr_offset = VERSION2_TIMER_STAT_REG_OFFSET;
> +	} else {
> +		timer->func_offset = 0;
> +		timer->intr_offset = 0;
> +	}
> +
> +	timer->id = pdev->id;
> +	timer->irq = irq->start;
> +	timer->pdev = pdev;
> +#if defined(CONFIG_ARCH_OMAP2)

This one too ..

[...]

> diff --git a/include/linux/timer-omap.h b/include/linux/timer-omap.h
> new file mode 100644
> index 0000000..a6b4cac
> --- /dev/null
> +++ b/include/linux/timer-omap.h
> @@ -0,0 +1,351 @@
> +/*
> + * include/linux/timer-omap.h
> + *
> + * OMAP Dual-Mode Timers
> + *

[...]

> +/* register offsets */
> +#define _OMAP_TIMER_ID_OFFSET		0x00
> +#define _OMAP_TIMER_OCP_CFG_OFFSET	0x10
> +#define _OMAP_TIMER_SYS_STAT_OFFSET	0x14
> +#define _OMAP_TIMER_STAT_OFFSET		0x18
> +#define _OMAP_TIMER_INT_EN_OFFSET	0x1c
> +#define _OMAP_TIMER_WAKEUP_EN_OFFSET	0x20
> +#define _OMAP_TIMER_CTRL_OFFSET		0x24
> +#define		OMAP_TIMER_CTRL_GPOCFG		(1<<  14)
> +#define		OMAP_TIMER_CTRL_CAPTMODE	(1<<  13)
> +#define		OMAP_TIMER_CTRL_PT		(1<<  12)
> +#define		OMAP_TIMER_CTRL_TCM_LOWTOHIGH	(0x1<<  8)
> +#define		OMAP_TIMER_CTRL_TCM_HIGHTOLOW	(0x2<<  8)
> +#define		OMAP_TIMER_CTRL_TCM_BOTHEDGES	(0x3<<  8)
> +#define		OMAP_TIMER_CTRL_SCPWM		(1<<  7)
> +#define		OMAP_TIMER_CTRL_CE		(1<<  6) /* compare enable */
> +#define		OMAP_TIMER_CTRL_PRE		(1<<  5) /* prescaler enable */
> +#define		OMAP_TIMER_CTRL_PTV_SHIFT	2 /* prescaler value shift */
> +#define		OMAP_TIMER_CTRL_POSTED		(1<<  2)
> +#define		OMAP_TIMER_CTRL_AR		(1<<  1) /* auto-reload enable */
> +#define		OMAP_TIMER_CTRL_ST		(1<<  0) /* start timer */
Fix the indentation above and in rest of the file.

Regards
Santosh
