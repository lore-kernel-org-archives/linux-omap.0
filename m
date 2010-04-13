From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] OMAP GPTimer for OProfile(Errata#628216)
Date: Tue, 13 Apr 2010 18:03:37 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030D4D270A@dbde02.ent.ti.com>
References: <1270135448-11604-1-git-send-email-manjugk@ti.com>
 <201004011832.14879.siarhei.siamashka@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53875 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997Ab0DMMdm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Apr 2010 08:33:42 -0400
In-Reply-To: <201004011832.14879.siarhei.siamashka@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "Koskinen Aaro (Nokia-D/Helsinki)" <aaro.koskinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Siarhei Siamashka
> Sent: 2010-04-01 21:02
> To: G, Manjunath Kondaiah; Koskinen Aaro (Nokia-D/Helsinki)
> Cc: linux-omap@vger.kernel.org; DebBarma, Tarun Kanti
> Subject: Re: [PATCH] OMAP GPTimer for OProfile(Errata#628216)
> 
> On Thursday 01 April 2010 18:24:08 ext Manjunatha GK wrote:
> > From: DebBarma, Tarun Kanti <tarun.kanti@ti.com>
> >
> > [ARM Cortex-A8 Errata 628216]
> > If a Perf Counter OVFL occurs simultaneously with an update to a CP14 or
> > CP15 register, the OVFL status can be lost.
> >
> > In order to workaround problem in Cortex-A8 Performance Counter, OMAP
> > GPTIMER is used by OProfile.
> 
> Thanks for digging this up. But even though GPTIMER has a lower overhead,
> there is actually a better (more portable) fix which is on the way into
> mainline kernel:
> http://marc.info/?l=oprofile-list&m=126754919315010&w=2
> 
> Samples collection frequency can be adjusted by another patch (the default
> 128Hz used on most ARM boards/devices is way too low).
> 
> oprofile kernel module can be loaded with 'timer=1' parameter to override
> the use of buggy Cortex-A8 PMU.

[Ghorai] ok. Your patch did not work if I build inside kernel image. Here is the error - 
$>opcontrol --setup --vmlinux=/vmlinux
cpu_type 'unset' is not valid
you should upgrade oprofile or force the use of timer mode
/usr/bin/objdump

> 
> --
> Best regards,
> Siarhei Siamashka
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
