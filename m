From: Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v2] ARM: dts: am33xx: Move the cppi41dma node so it's
 probed early
Date: Fri, 9 May 2014 10:26:51 -0300
Message-ID: <20140509132651.GD764@arch.cereza>
References: <1398373881-23369-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <CAGm1_kvHtSLNEfkJ24xZGGzsqAjHDTM1XztnX-QGs4iM5voMUw@mail.gmail.com>
 <535F5BA5.6000903@ti.com>
 <CAAEAJfCG3c++WBgeipF6sCE1-9pHgU80t2Mpz0Y4koU5-uEwSA@mail.gmail.com>
 <536C7443.4000805@ti.com>
 <536C82F1.6020809@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f49.google.com ([209.85.213.49]:59679 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbaEIN1Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2014 09:27:24 -0400
Received: by mail-yh0-f49.google.com with SMTP id c41so3661668yho.22
        for <linux-omap@vger.kernel.org>; Fri, 09 May 2014 06:27:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <536C82F1.6020809@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: George Cherian <george.cherian@ti.com>, Yegor Yefremov <yegorslists@googlemail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

On 09 May 09:25 AM, Sebastian Andrzej Siewior wrote:
> On 05/09/2014 08:22 AM, George Cherian wrote:
> > Just by remodelling the dt the whole problem can be solved.
> > I am still not convinced why we should not be doing it?
> > Because neither ways its not the exact representation of the H/W.
> 
> Ha. Now I am confused. First I assumed that the musb_am335x module is
> built-in only to duct-tape the bug you are seeing. So this patch never
> made it mainline then.

Mainline panics easily upon module removal: 

$ modprobe musb_am335x
$ modprobe musb_dsps

Here you insert something to the USB

$ modprobe musb_am335x -r ... bang! the kernel panics.

It works fine if you remove the musb_dsps and musb_am335x in that order,
but the dependency is not enforced anywhere.

So I guess preventing the module removal should be fine for now.
In that case, mind testing/acking/whatever this patch:

http://www.spinics.net/lists/linux-usb/msg107244.html

Regards,
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
