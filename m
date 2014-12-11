From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: regression: OMAP4 (next-20141204) (bisect to: ARM: 8208/1: l2c:
 Refactor the driver to use commit-like)
Date: Thu, 11 Dec 2014 11:42:48 +0100
Message-ID: <54897528.4030804@samsung.com>
References: <5481D913.9040109@ti.com> <5481D9BF.2090007@ti.com>
 <20141209165746.GA29935@kahuna> <54881589.20105@samsung.com>
 <20141211092945.GE11502@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-reply-to: <20141211092945.GE11502@n2100.arm.linux.org.uk>
Sender: linux-next-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-omap <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-next <linux-next@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 2014-12-11 10:29, Russell King - ARM Linux wrote:
> On Wed, Dec 10, 2014 at 10:42:33AM +0100, Marek Szyprowski wrote:
>> I assume that now it won't be possible to get l2c patches back to -next,
>> so I will resend them (again...) with the omap related fix.
> What, you mean you don't know the fundamental rules of kernel development?
>
> No one should ever dump any new code into linux-next during a merge
> window which is not a fix for a regression or a bug fix, period.
>
> Linus has in the past taken a snapshot of linux-next at the beginning
> of a merge window, and then threatened to refuse to merge anything that
> wasn't in his local snapshot, or which doesn't qualify as the above.
>
> So no, it won't be possible, because I play by the community rules when
> it comes to what gets merged and at what time in the cycle.

I know the rules. It was just my whining, that it is yet another release 
cycle
that got missed. It is really disappointing, that those patches have been
floating for months and noone found issues related to different order of
initialization. It took way to long to get them scheduled for testing in
-next.

Exynos4 platform cannot be considered as fully functional without
proper l2cache support, but I assume that this is once again our fault that
we had to modify the common l2c code.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
