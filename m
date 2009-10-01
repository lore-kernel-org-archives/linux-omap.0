From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 02/04] OMAP4: PMIC: Add support for twl6030 RTC
Date: Thu, 01 Oct 2009 11:35:19 -0700
Message-ID: <87ws3fc68o.fsf@deeprootsystems.com>
References: <1254399821-3982-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:36444 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471AbZJASfU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 14:35:20 -0400
Received: by pzk7 with SMTP id 7so333846pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 11:35:24 -0700 (PDT)
In-Reply-To: <1254399821-3982-1-git-send-email-balajitk@ti.com> (balajitk@ti.com's message of "Thu\,  1 Oct 2009 17\:53\:41 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balajitk@ti.com
Cc: linux-omap@vger.kernel.org, sameo@linux.intel.com, wim@iguana.be, timo.t.kokkonen@nokia.com, ben-linux@fluff.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, p_gortmaker@yahoo.com, a.zummo@towertech.it, rtc-linux@googlegroups.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

balajitk@ti.com writes:

> From: Balaji T K <balajitk@ti.com>
>
> This version of patch series enables RUN TIME selection of TWL4030 or TWL6030.
>
> This patch adds support for RTC in phoenix TWL6030.
> Register offset addresses have changed in TWL6030
> rtc-twl.c will hence forth support all twl RTC (4030, 5030, 6030 ..)
>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reviewed-by: Tony Lindgren <tony@atomide.com>

[...]

> @@ -352,6 +401,7 @@ static irqreturn_t twl_rtc_interrupt(int irq, void *rtc)
>  	if (res)
>  		goto out;
>  
> +if (twl_class_is_4030()) {

indentation?

>  	/* Clear on Read enabled. RTC_IT bit of TWL4030_INT_PWR_ISR1
>  	 * needs 2 reads to clear the interrupt. One read is done in
>  	 * do_twl_pwrirq(). Doing the second read, to clear
> @@ -367,6 +417,7 @@ static irqreturn_t twl_rtc_interrupt(int irq, void *rtc)
>  			&rd_reg, TWL4030_INT_PWR_ISR1);
>  	if (res)
>  		goto out;
> +}

and here?

after that,

Reviewed-by: Kevin Hilman <khilman@deeprootsystems.com>


