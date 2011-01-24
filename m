From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 5/5] ARM: smp: Skip secondary cpu calibration to speed-up boot
Date: Mon, 24 Jan 2011 14:25:21 +0530
Message-ID: <5b88d3a0315edf957c62a8b34622ae8c@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com> <1295859080-15259-7-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:53610 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751375Ab1AXIzZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 03:55:25 -0500
Received: by fxm9 with SMTP id 9so4115798fxm.31
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 00:55:23 -0800 (PST)
In-Reply-To: <1295859080-15259-7-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, ccross@android.com, catalin.marinas@arm.com, linux@arm.linux.org.uk, linus.ml.walleij@gmail.com

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Santosh Shilimkar
> Sent: Monday, January 24, 2011 2:21 PM
> To: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org; ccross@android.com;
> catalin.marinas@arm.com; linux@arm.linux.org.uk;
> linus.ml.walleij@gmail.com
> Subject: [PATCH 5/5] ARM: smp: Skip secondary cpu calibration to
> speed-up boot
>
>  	if (!skip_secondary_calibrate) {
>  		for_each_online_cpu(cpu)
> -			bogosum += per_cpu(cpu_data, cpu).loops_per_jiffy;
> +			bogosums += per_cpu(cpu_data,
> cpu).loops_per_jiffy;
>
> -		snprintf(bogosum, sizeof(bogosum), " (%lu.%02lu
> BogoMIPS).\n",
> -			bogosum / (500000/HZ), (bogosum / (5000/HZ)) %
> 100);
> +		snprintf(bogosum, sizeof(bogosums), " (%lu.%02lu
> BogoMIPS).\n",
> +			bogosums / (500000/HZ), (bogosums / (5000/HZ)) %
> 100);
>  	} else
>  		bogosum[0] = '\0';
>
Ignore this change please.
