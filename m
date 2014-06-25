From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 0/6] Enable L2 cache support on Exynos4210/4x12 SoCs
Date: Wed, 25 Jun 2014 14:50:39 +0100
Message-ID: <20140625135039.GM3705@n2100.arm.linux.org.uk>
References: <1403703451-12233-1-git-send-email-t.figa@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1403703451-12233-1-git-send-email-t.figa@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Laura Abbott <lauraa@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomasz Figa <tomasz.figa@gmail.com>, Daniel Drake <drake@endlessm.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 25, 2014 at 03:37:25PM +0200, Tomasz Figa wrote:
> This series intends to add support for L2 cache on Exynos4 SoCs on boards
> running under secure firmware, which requires certain initialization steps
> to be done with help of firmware, as selected registers are writable only
> from secure mode.

What I said in my message on June 12th applies to this series.  I'm
not having the virtual address exposed via the write_sec call.

Yes, you need to read other registers in order to use your secure
firmware implementation.  Let's fix that by providing a better write_sec
interface so you don't have to read back these registers, rather than
working around this short-coming.

That's exactly what I meant when I talked on June 12th about turning
cache-l2x0.c back into a pile of crap.  You're working around problems
rather than fixing the underlying issue, as seems to be standard
platform maintainer behaviour when things like core ARM code is
concerned.  This is why things devolve over time into piles of crap,
because platforms just hack around problems rather than fixing the
root cause of the problem.

So... I'm NAKing the entire series.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
