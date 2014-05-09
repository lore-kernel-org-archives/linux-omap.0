From: George Cherian <george.cherian@ti.com>
Subject: Re: [PATCH v2] ARM: dts: am33xx: Move the cppi41dma node so it's
 probed early
Date: Fri, 9 May 2014 15:37:30 +0530
Message-ID: <536CA8E2.9010707@ti.com>
References: <1398373881-23369-1-git-send-email-ezequiel@vanguardiasur.com.ar>	<CAGm1_kvHtSLNEfkJ24xZGGzsqAjHDTM1XztnX-QGs4iM5voMUw@mail.gmail.com>	<535F5BA5.6000903@ti.com> <CAAEAJfCG3c++WBgeipF6sCE1-9pHgU80t2Mpz0Y4koU5-uEwSA@mail.gmail.com> <536C7443.4000805@ti.com> <536C82F1.6020809@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35129 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174AbaEIKIL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 06:08:11 -0400
In-Reply-To: <536C82F1.6020809@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, =?UTF-8?B?RXplcXVp?= =?UTF-8?B?ZWwgR2FyY8OtYQ==?= <ezequiel@vanguardiasur.com.ar>
Cc: Yegor Yefremov <yegorslists@googlemail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

On 5/9/2014 12:55 PM, Sebastian Andrzej Siewior wrote:
> On 05/09/2014 08:22 AM, George Cherian wrote:
>> Just by remodelling the dt the whole problem can be solved.
>> I am still not convinced why we should not be doing it?
>> Because neither ways its not the exact representation of the H/W.
> Ha. Now I am confused. First I assumed that the musb_am335x module is
> built-in only to duct-tape the bug you are seeing. So this patch never
> made it mainline then.
> The problem is as far as I remember the way the phy-core does things
> and should be fixed. Re-arranging does not help because you can still
> oops the kernel (the same oops you have now) by removing the devices
> manually via sysfs.
Okay...
So, You mean to say if I unbind the phy device  and then try to remove 
musb_am335x module,
then it will oops.
Now I got it...
>
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
-George

