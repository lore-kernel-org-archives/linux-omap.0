From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCHv2] arm: mach-omap2: smartreflex: fix another memory leak
Date: Mon, 7 Feb 2011 20:34:32 +0530
Message-ID: <ba6df530470834775860a63aa1141837@mail.gmail.com>
References: <1297087684-19967-1-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:51499 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753508Ab1BGPEf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 10:04:35 -0500
Received: by mail-fx0-f53.google.com with SMTP id 11so6509786fxm.40
        for <linux-omap@vger.kernel.org>; Mon, 07 Feb 2011 07:04:33 -0800 (PST)
In-Reply-To: <1297087684-19967-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Aaro Koskinen [mailto:aaro.koskinen@nokia.com]
> Sent: Monday, February 07, 2011 7:38 PM
> To: tony@atomide.com; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Cc: vishwanath.bs@ti.com; Aaro Koskinen
> Subject: [PATCHv2] arm: mach-omap2: smartreflex: fix another memory
> leak
>
> Temporary strings with volt_* file names should be released after the
> debugfs entries are created. While at it, also simplify the string
> allocation, and use just snprintf() to create the name.
>
> The patch eliminates kmemleak reports with the following stack trace
> (multiple objects depending on HW):
>
> unreferenced object 0xcedbc5a0 (size 64):
>   comm "swapper", pid 1, jiffies 4294929375 (age 423.734s)
>   hex dump (first 32 bytes):
>     76 6f 6c 74 5f 39 37 35 30 30 30 00 00 00 00 00  volt_975000.....
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<c012fee0>] create_object+0x104/0x208
>     [<c012dbc8>] kmem_cache_alloc_trace+0xf0/0x17c
>     [<c0013f64>] omap_sr_probe+0x314/0x420
>     [<c02a1724>] platform_drv_probe+0x18/0x1c
>     [<c02a088c>] driver_probe_device+0xc8/0x188
>     [<c02a09b4>] __driver_attach+0x68/0x8c
>     [<c02a00ac>] bus_for_each_dev+0x44/0x74
>     [<c029f9e0>] bus_add_driver+0xa0/0x228
>     [<c02a0cac>] driver_register+0xa8/0x130
>     [<c02a1b2c>] platform_driver_probe+0x18/0x8c
>     [<c0013c1c>] sr_init+0x40/0x74
>     [<c005a554>] do_one_initcall+0xc8/0x1a0
>     [<c00084f4>] kernel_init+0x150/0x218
>     [<c0065d64>] kernel_thread_exit+0x0/0x8
>     [<ffffffff>] 0xffffffff
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---
>
> v2: Get rid of kmalloc().
>
>  arch/arm/mach-omap2/smartreflex.c |   15 +++------------
>  1 files changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-
> omap2/smartreflex.c
> index 77ecebf..e54db84 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -927,19 +927,10 @@ static int __init omap_sr_probe(struct
> platform_device *pdev)
>  	}
>
>  	for (i = 0; i < sr_info->nvalue_count; i++) {
> -		char *name;
> -		char volt_name[32];
> -
> -		name = kzalloc(NVALUE_NAME_LEN + 1, GFP_KERNEL);
> -		if (!name) {
> -			dev_err(&pdev->dev, "%s: Unable to allocate
> memory"
> -				" for n-value directory name\n",
__func__);
> -			return -ENOMEM;
> -		}
> +		char name[NVALUE_NAME_LEN + 1];
Is there any need to keep this inside the loop? Defining it in the
beginning of function might save a few cpu cycles.

Vishwa
>
> -		strcpy(name, "volt_");
> -		sprintf(volt_name, "%d", volt_data[i].volt_nominal);
> -		strcat(name, volt_name);
> +		snprintf(name, sizeof(name), "volt_%d",
> +			 volt_data[i].volt_nominal);
>  		(void) debugfs_create_x32(name, S_IRUGO | S_IWUGO,
> nvalue_dir,
>  				&(sr_info->nvalue_table[i].nvalue));
>  	}
> --
> 1.5.6.5
