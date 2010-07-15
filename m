From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: Power managment on Overo
Date: Thu, 15 Jul 2010 05:29:42 -0500
Message-ID: <4C3EE316.5000506@gmail.com>
References: <loom.20100715T065056-117@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50521 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933031Ab0GOK3z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jul 2010 06:29:55 -0400
Received: by yxn35 with SMTP id 35so18608yxn.19
        for <linux-omap@vger.kernel.org>; Thu, 15 Jul 2010 03:29:54 -0700 (PDT)
In-Reply-To: <loom.20100715T065056-117@post.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Han Wang <hw342@cornell.edu>
Cc: linux-omap@vger.kernel.org

On 07/15/2010 12:00 AM, Han Wang wrote:
> Hi, All,
>
>     I am running the linux-pm-kernel v2.35.rc3 on Overo Earth. I have managed to
> suspend the system using "echo mem>  /sys/power/state" with "enable_off_mode"
> and "sleep_while_idle" enabled. Currently, I am able to achieve 200mW in suspend
> mode. However, I am seen in other posts, such as this  one  (http://old.nabble.com/
> Overo-boot-time--power-management-ts28402656.html#a28463135), that
> people are able to achieve a much lower power signature.

Did you check if you have actually shut off the voltages on vdd1 and 
vdd2 when you hit OFF? easy to check with a voltmeter/scope on vdd1&vdd2 
capcacitors.

>
>     I am particularly interested to know what mode has the SDRAM on Overo  been set to
> during suspend mode? Is it auto-refresh or self-refresh? And whether the TPS/TWL
> power management chip is set to low power mode during suspend mode by the pm
> kernel, if not, how to set it?
>
> Thanks,
> Han
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

