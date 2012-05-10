From: Sricharan R <r.sricharan@ti.com>
Subject: RE: [PATCH 0/4] ARM: OMAP2+: Misc cleanup part2
Date: Thu, 10 May 2012 22:47:38 +0530
Message-ID: <e9a14034778ef9c8047887de64b5dbae@mail.gmail.com>
References: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:43779 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756648Ab2EJRRl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 13:17:41 -0400
Received: by lahc1 with SMTP id c1so1199624lah.4
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 10:17:39 -0700 (PDT)
In-Reply-To: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, tony@atomide.com, Benoit Cousson <b-cousson@ti.com>, paul@pswan.com

> -----Original Message-----
> From: R Sricharan [mailto:r.sricharan@ti.com]
> Sent: Thursday, May 10, 2012 10:37 PM
> To: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; santosh.shilimkar@ti.com;
> tony@atomide.com; b-cousson@ti.com; r.sricharan@ti.com; paul@pswan.com
> Subject: [PATCH 0/4] ARM: OMAP2+: Misc cleanup part2
>
> This is a continuation of the previous cleanup series from
> santosh.shilimkar@ti.com [1]. Patches are outcome of the OMAP5
> review suggestions from Tony/Benoit/Santosh/Rajendra.
>
> [1]  http://www.spinics.net/lists/linux-omap/msg69730.html
>
> R Sricharan (4):
>   ARM: OMAP2+: Introduce CONFIG_SOC_HAS_OMAP_DPLL macro
>   ARM: OMAP2+: Move the stubbed prm and cm functions to prcm.c file and
>     make them __weak.
>   ARM: OMAP2+: Move stubbed secure_sram_reserve function to a common.c
>     and call it __weak
>   ARM: OMAP: counter-32k: Select the CR register offset using the IP
>     scheme.
>
 Forgot to add the below reviewed-by tag.
   Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks,
 Sricharan
