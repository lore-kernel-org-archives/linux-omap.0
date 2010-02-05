From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [Patch 5/8] DSPBRIDGE: typedef cleanup -DSP_HPROCESSOR
Date: Fri, 5 Feb 2010 16:39:51 -0600
Message-ID: <4B6C9E37.9060705@ti.com>
References: <19F8576C6E063C45BE387C64729E7394044A6B9675@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38790 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934004Ab0BEWjw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Feb 2010 17:39:52 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o15MdqlC021491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 5 Feb 2010 16:39:52 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id o15MdptU016427
	for <linux-omap@vger.kernel.org>; Fri, 5 Feb 2010 16:39:51 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o15Mdpgf025816
	for <linux-omap@vger.kernel.org>; Fri, 5 Feb 2010 16:39:51 -0600 (CST)
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044A6B9675@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hebbar, Shivananda" <x0hebbar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi,

On 2/2/2010 6:44 PM, Hebbar, Shivananda wrote:
>  From 82f402b577d1afb535b319eed4a18087010ef679 Mon Sep 17 00:00:00 2001
> From: Shivananda Hebbar<x0hebbar@ti.com>
> Date: Thu, 28 Jan 2010 20:06:40 -0600
> Subject: [PATCH] DSPBRIDGE: Remove typdef used for Processor type replace it with standard C type
>
> Signed-off-by: Shivananda Hebbar<x0hebbar@ti.com>
> ---
>   arch/arm/plat-omap/include/dspbridge/cmm.h      |    2 +-
>   arch/arm/plat-omap/include/dspbridge/dbdefs.h   |    2 -
>   arch/arm/plat-omap/include/dspbridge/dmm.h      |    2 +-
>   arch/arm/plat-omap/include/dspbridge/drv.h      |    2 +-
>   arch/arm/plat-omap/include/dspbridge/node.h     |    2 +-
>   arch/arm/plat-omap/include/dspbridge/proc.h     |   41 +++++++++++-----------
>   arch/arm/plat-omap/include/dspbridge/wcdioctl.h |   40 +++++++++++-----------
>   drivers/dsp/bridge/pmgr/cmm.c                   |    2 +-
>   drivers/dsp/bridge/pmgr/dev.c                   |    6 ++--
>   drivers/dsp/bridge/pmgr/dmm.c                   |    2 +-
>   drivers/dsp/bridge/pmgr/wcd.c                   |    2 +-
>   drivers/dsp/bridge/rmgr/node.c                  |    2 +-
>   drivers/dsp/bridge/rmgr/proc.c                  |   42 +++++++++++-----------
>   13 files changed, 72 insertions(+), 75 deletions(-)
>

missing this hunk for proc.c

@@ -246,7 +246,7 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct 
DSP_PROCESSORATTRIN *pAttrIn,
  				 "Proc Object into DEV, 0x%x!\n", status);
  		}
  		if (DSP_SUCCEEDED(status)) {
-			*phProcessor = (DSP_HPROCESSOR)pProcObject;
+			*phProcessor = (void *)pProcObject;
  			pr_ctxt->hProcessor = *phProcessor;
  			(void)PROC_NotifyClients(pProcObject,
  						 DSP_PROCESSORATTACH);


[...]

- omar
