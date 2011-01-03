From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ETM: Fix etm_probe and etb_probe section mismatch warnings
 in arch/arm/kernel/etm.c
Date: Mon, 03 Jan 2011 08:23:52 -0600
Message-ID: <4D21DBF8.1070504@ti.com>
References: <EC93877F-CDA7-4231-9B4C-0F72623AAC8F@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:51098 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754796Ab1ACOX5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 09:23:57 -0500
Received: by gye5 with SMTP id 5so6314783gye.18
        for <linux-omap@vger.kernel.org>; Mon, 03 Jan 2011 06:23:56 -0800 (PST)
In-Reply-To: <EC93877F-CDA7-4231-9B4C-0F72623AAC8F@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Elvis Dowson had written, on 12/26/2010 03:26 PM, the following:
> Hi,
>        This patch fixes section mismatch warnings for etm_probe() and etb_probe() for linux-2.6.37-rc7.
> 
> Elvis Dowson

Could you post this to l-a and cc l-o?
a better cc list is got by scripts/get_maintainer.pl patch

> 
> 
> From d9168ebf22bfac428955b3a3fe2d657faae4a9ee Mon Sep 17 00:00:00 2001
> From: Elvis Dowson <elvis.dowson@gmail.com>
> Date: Mon, 27 Dec 2010 01:21:39 +0400
> Subject: [PATCH] ETM: Fix etm_probe and etb_probe section mismatch warnings in arch/arm/kernel/etm.c
> 
> Fix the following section mismatch warning when building omap2plus_defconfig:
> 
> WARNING: vmlinux.o(.data+0x1b70): Section mismatch in reference from the variable etb_driver to the function .init.text:etb_probe()
> 
> WARNING: vmlinux.o(.data+0x1bbc): Section mismatch in reference from the variable etm_driver to the function .init.text:etm_probe() 
> 
> Signed-off-by: Elvis Dowson <elvis.dowson@gmail.com>
> ---
>  arch/arm/kernel/etm.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
> index 11db628..e881a0d 100644
> --- a/arch/arm/kernel/etm.c
> +++ b/arch/arm/kernel/etm.c
> @@ -338,7 +338,7 @@ static struct miscdevice etb_miscdev = {
>  	.fops = &etb_fops,
>  };
>  
> -static int __init etb_probe(struct amba_device *dev, struct amba_id *id)
> +static int __devinit etb_probe(struct amba_device *dev, struct amba_id *id)
>  {
>  	struct tracectx *t = &tracer;
>  	int ret = 0;
> @@ -530,7 +530,7 @@ static ssize_t trace_mode_store(struct kobject *kobj,
>  static struct kobj_attribute trace_mode_attr =
>  	__ATTR(trace_mode, 0644, trace_mode_show, trace_mode_store);
>  
> -static int __init etm_probe(struct amba_device *dev, struct amba_id *id)
> +static int __devinit etm_probe(struct amba_device *dev, struct amba_id *id)
>  {
>  	struct tracectx *t = &tracer;
>  	int ret = 0;


-- 
Regards,
Nishanth Menon
