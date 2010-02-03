From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [Patch 1/8] DSPBRIDGE: typedef cleanup -DSP RTOS
Date: Wed, 3 Feb 2010 00:27:24 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602AA5737A9@dlee06.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E7394044A6B9671@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58010 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab0BCG10 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 01:27:26 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o136RQ1F024853
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 3 Feb 2010 00:27:26 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id o136RPXP024144
	for <linux-omap@vger.kernel.org>; Wed, 3 Feb 2010 00:27:25 -0600 (CST)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o136RPgY011452
	for <linux-omap@vger.kernel.org>; Wed, 3 Feb 2010 00:27:25 -0600 (CST)
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044A6B9671@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hebbar, Shivananda" <x0hebbar@ti.com>, linux-omap <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Hebbar, Shivananda
>Sent: Tuesday, February 02, 2010 6:44 PM
>To: linux-omap
>Subject: [Patch 1/8] DSPBRIDGE: typedef cleanup -DSP RTOS
>
>From 5855acc38e699f9abfcdd11f1dbd5d648feecb74 Mon Sep 17 00:00:00 2001
>From: Shivananda Hebbar <x0hebbar@ti.com>
>Date: Thu, 28 Jan 2010 18:57:02 -0600
>Subject: [PATCH] DSPBRIDGE: Remove typedef used for DSPRTOS type and
>replace it with normal C type.
>
>This patch removes the typdef used for DSPRTOS type and replaces it with
>normal C type.
>
>Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
>---
> arch/arm/plat-omap/include/dspbridge/dbdefs.h |    3 +--
> 1 files changed, 1 insertions(+), 2 deletions(-)
>
>diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-
>omap/include/dspbridge/dbdefs.h
>index fc9fdc8..049fcee 100644
>--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
>+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
>@@ -115,7 +115,6 @@
>
>        typedef u32 DSP_PROCFAMILY;     /* Processor family             */
>        typedef u32 DSP_PROCTYPE;       /* Processor type (w/in family) */
>-       typedef u32 DSP_RTOSTYPE;       /* Type of DSP RTOS             */
>
> /* Handy Macros */
> #define IsValidProcEvent(x) (((x) == 0) || (((x) &
>(DSP_PROCESSORSTATECHANGE | \ @@ -422,7 +421,7 @@
>                u32 ulInternalMemSize;
>                u32 ulExternalMemSize;
>                u32 uProcessorID;
>-               DSP_RTOSTYPE tyRunningRTOS;
>+               long tyRunningRTOS;

Why was it changed to long and not to unsigned int as it as defined before (u32) or int which is the tiye return by Atoi?

pGenObj->objData.procObj.tyRunningRTOS = Atoi(token);

>                s32 nNodeMinPriority;
>                s32 nNodeMaxPriority;
>        } ;
>--
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards,
Fernando.
