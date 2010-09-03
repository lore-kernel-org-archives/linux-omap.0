From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 0/1] omap: fix section mismatch errors
Date: Fri, 3 Sep 2010 13:59:51 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301F6BC8986@dbde02.ent.ti.com>
References: <1281972664-1587-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40797 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430Ab0ICI35 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 04:29:57 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o838Tr47013813
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 3 Sep 2010 03:29:56 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o838TrVX014551
	for <linux-omap@vger.kernel.org>; Fri, 3 Sep 2010 13:59:53 +0530 (IST)
In-Reply-To: <1281972664-1587-1-git-send-email-premi@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Monday, August 16, 2010 9:01 PM
> To: linux-omap@vger.kernel.org
> Cc: Premi, Sanjeev
> Subject: [PATCH 0/1] omap: fix section mismatch errors
> 
> Multiple section mismatches are observed with the latest
> master. While attempting to fix the ones listed below, I
> came across more instances.
> 
> The patch in this series fixes all these issues.
> 
> Though most of the changes are straight-forward, but for
> these (for now annotated as ___refdata):
> 
> 1) arch/arm/plat-omap/cpu-omap.c
>    Variable omap_driver may be required beyond __init
>    lifetime.
>  
> 2) drivers/mfd/twl-core.c
>    Variable twl_driver is used both in __init and __exit
>    context.
> 
> There are few more similar errors in some of the modules
> would submit them separately.
> 
> 
> WARNING: vmlinux.o(.text+0x187c0): Section mismatch in 
> reference from the function zoom_twl_gpio_setup() to the 
> (unknown reference) .init.data:(unknown)
> The function zoom_twl_gpio_setup() references
> the (unknown reference) __initdata (unknown).
> This is often because zoom_twl_gpio_setup lacks a __initdata
> annotation or the annotation of (unknown) is wrong.
> 
> WARNING: vmlinux.o(.text+0x189b0): Section mismatch in 
> reference from the function cm_t35_twl_gpio_setup() to the 
> (unknown reference) .init.data:(unknown)
> The function cm_t35_twl_gpio_setup() references
> the (unknown reference) __initdata (unknown).
> This is often because cm_t35_twl_gpio_setup lacks a __initdata
> annotation or the annotation of (unknown) is wrong.
> 
> WARNING: vmlinux.o(.data+0x19e38): Section mismatch in 
> reference from the variable h4_config to the (unknown 
> reference) .init.data:(unknown)
> The variable h4_config references
> the (unknown reference) __initdata (unknown)
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name 
> the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
> 
> WARNING: vmlinux.o(.data+0x1a670): Section mismatch in 
> reference from the variable sdp2430_config to the (unknown 
> reference) .init.data:(unknown)
> The variable sdp2430_config references
> the (unknown reference) __initdata (unknown)
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name 
> the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
> 
> WARNING: vmlinux.o(.data+0x1ac50): Section mismatch in 
> reference from the variable apollon_config to the (unknown 
> reference) .init.data:(unknown)
> The variable apollon_config references
> the (unknown reference) __initdata (unknown)
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name 
> the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
> 
> WARNING: vmlinux.o(.data+0x2e378): Section mismatch in 
> reference from the variable omap_driver to the function 
> .init.text:omap_cpu_init()
> The variable omap_driver references
> the function __init omap_cpu_init()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name 
> the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
> 
> WARNING: vmlinux.o(.data+0x1b9dcc): Section mismatch in 
> reference from the variable twl_driver to the function 
> .init.text:twl_probe()
> The variable twl_driver references
> the function __init twl_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name 
> the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
> 
> Sanjeev Premi (1):
>   omap: fix section mismatch errors
> 
>  arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
>  arch/arm/mach-omap2/board-apollon.c          |    2 +-
>  arch/arm/mach-omap2/board-cm-t35.c           |    8 ++++----
>  arch/arm/mach-omap2/board-h4.c               |    2 +-
>  arch/arm/mach-omap2/board-zoom-peripherals.c |   18 
> +++++++++---------
>  arch/arm/plat-omap/cpu-omap.c                |    2 +-
>  drivers/mfd/twl-core.c                       |    2 +-
>  7 files changed, 18 insertions(+), 18 deletions(-)
> 
> 
Hi Tony,

Did you look at this as well?

Best regards,
Sanjeev
