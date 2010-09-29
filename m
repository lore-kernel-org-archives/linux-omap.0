From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 08/11] OMAP3: PM: Adding debug support to Voltage and Smartreflex drivers
Date: Wed, 29 Sep 2010 16:20:15 -0700
Message-ID: <87k4m4qgr4.fsf@deeprootsystems.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	<1285166719-19352-9-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40758 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab0I2XUZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 19:20:25 -0400
Received: by iwn5 with SMTP id 5so1614032iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Sep 2010 16:20:24 -0700 (PDT)
In-Reply-To: <1285166719-19352-9-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Wed, 22 Sep 2010 20:15:16 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

[...]

> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
> index 99836a1..8978d33 100644
> --- a/arch/arm/plat-omap/include/plat/voltage.h
> +++ b/arch/arm/plat-omap/include/plat/voltage.h
> @@ -14,6 +14,11 @@
>  #ifndef __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
>  #define __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
>  
> +extern u32 enable_sr_vp_debug;
> +#ifdef CONFIG_PM_DEBUG
> +extern struct dentry *pm_dbg_main_dir;
> +#endif
> +
>  #define VOLTSCALE_VPFORCEUPDATE		1
>  #define VOLTSCALE_VCBYPASS		2

This belongs in PATCH 1/11 and belongs in pm.h, not voltage.h as it's a
feature of the PM debug layer, not the voltage layer.

Kevin


