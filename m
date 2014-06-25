From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v2 0/6] Enable L2 cache support on Exynos4210/4x12 SoCs
Date: Wed, 25 Jun 2014 16:13:16 +0200
Message-ID: <53AAD8FC.9040306@samsung.com>
References: <1403703451-12233-1-git-send-email-t.figa@samsung.com>
 <20140625135039.GM3705@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:20411 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756775AbaFYONn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2014 10:13:43 -0400
In-reply-to: <20140625135039.GM3705@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Laura Abbott <lauraa@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomasz Figa <tomasz.figa@gmail.com>, Daniel Drake <drake@endlessm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On 25.06.2014 15:50, Russell King - ARM Linux wrote:
> On Wed, Jun 25, 2014 at 03:37:25PM +0200, Tomasz Figa wrote:
>> This series intends to add support for L2 cache on Exynos4 SoCs on boards
>> running under secure firmware, which requires certain initialization steps
>> to be done with help of firmware, as selected registers are writable only
>> from secure mode.
> 
> What I said in my message on June 12th applies to this series.  I'm
> not having the virtual address exposed via the write_sec call.
> 
> Yes, you need to read other registers in order to use your secure
> firmware implementation.  Let's fix that by providing a better write_sec
> interface so you don't have to read back these registers, rather than
> working around this short-coming.

Do you have anything in particular in mind? I would be glad to implement
it and send patches.

> 
> That's exactly what I meant when I talked on June 12th about turning
> cache-l2x0.c back into a pile of crap.  You're working around problems
> rather than fixing the underlying issue, as seems to be standard
> platform maintainer behaviour when things like core ARM code is
> concerned.  This is why things devolve over time into piles of crap,
> because platforms just hack around problems rather than fixing the
> root cause of the problem.

I'm not sure what part of my patches exactly is turning cache-l2x0.c
into a pile of crap. On the contrary, I believe that working around the
firmware brokenness on platform level, while keeping the core code
simple does the opposite.

However, I'll be happy to rework my series if you have some more
specific suggestions.

> So... I'm NAKing the entire series.

Your opinion is always appreciated, thanks.

Best regards,
Tomasz
