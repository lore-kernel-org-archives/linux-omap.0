From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] ARM: dts: am33xx: Move the cppi41dma node so it's
 probed early
Date: Fri, 09 May 2014 09:25:37 +0200
Message-ID: <536C82F1.6020809@linutronix.de>
References: <1398373881-23369-1-git-send-email-ezequiel@vanguardiasur.com.ar>	<CAGm1_kvHtSLNEfkJ24xZGGzsqAjHDTM1XztnX-QGs4iM5voMUw@mail.gmail.com>	<535F5BA5.6000903@ti.com> <CAAEAJfCG3c++WBgeipF6sCE1-9pHgU80t2Mpz0Y4koU5-uEwSA@mail.gmail.com> <536C7443.4000805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60827 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbaEIHZk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2014 03:25:40 -0400
In-Reply-To: <536C7443.4000805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: George Cherian <george.cherian@ti.com>, =?UTF-8?B?RXplcXVpZWwgR2FyY8Ot?= =?UTF-8?B?YQ==?= <ezequiel@vanguardiasur.com.ar>
Cc: Yegor Yefremov <yegorslists@googlemail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

On 05/09/2014 08:22 AM, George Cherian wrote:
> Just by remodelling the dt the whole problem can be solved.
> I am still not convinced why we should not be doing it?
> Because neither ways its not the exact representation of the H/W.

Ha. Now I am confused. First I assumed that the musb_am335x module is
built-in only to duct-tape the bug you are seeing. So this patch never
made it mainline then.
The problem is as far as I remember the way the phy-core does things
and should be fixed. Re-arranging does not help because you can still
oops the kernel (the same oops you have now) by removing the devices
manually via sysfs.

Sebastian
