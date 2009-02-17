From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [OMAPZOOM][PATCH] Testing for TWL4030 in board file change.
Date: Tue, 17 Feb 2009 10:11:31 +0200
Message-ID: <499A7133.4050803@gmail.com>
References: <200902161815.13645.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:54978 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbZBQILg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Feb 2009 03:11:36 -0500
Received: by fxm13 with SMTP id 13so6527710fxm.13
        for <linux-omap@vger.kernel.org>; Tue, 17 Feb 2009 00:11:34 -0800 (PST)
In-Reply-To: <200902161815.13645.dcurran@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dominic Curran <dcurran@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, saaguirre@ti.com

Dominic Curran said the following on 02/17/2009 02:15 AM:
> From: Dominic Curran <dcurran@ti.com>
> Subject: [OMAPZOOM][PATCH] Testing for TWL4030 in board file change.
>
> This patch changes the method of testing for TWL4030 in the sensor portion of the 
> board file.
> Previously, if TWL4030 was not built into kernel then the build would be stopped 
> by code in the board file simular to:
>  #ifndef CONFIG_TWL4030_CORE
>  #error "no power companion board defined!"
>  #endif
>
> However for debugging purposes it maybe required to build without TWL4030.
> Therefore this patch allows the kernel to be compiled without a build error when 
> TWL4030 is not present.
> In such a case the sensor power function will build, but when called immediately 
> return a -ENODEV error (so initilization of sensor will go no further).
>
> This change is targeted at all camera sensors within the board files for SDP, 
> Zoom1 & Zoom2.
>
> Alternative fixes to this problem like changes to Kconfig were considered, but 
> rejected as inappropriate solutions.
>
>   
Would a solution as follows be appropriate?
in arch/arm/mach-omap2/Kconfig:
 config MACH_OMAP_ZOOM2
           bool "OMAP3 ZOOM2 board"
           depends on ARCH_OMAP3 && ARCH_OMAP34XX
+        select TWL4030_CORE if VIDEO_OMAP3
 
A similar strategy has been implemented for N800, albeit for other
peripherals.
Regards,
Nishanth Menon
