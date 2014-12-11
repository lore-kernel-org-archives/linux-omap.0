From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: regression: OMAP4 (next-20141204) (bisect to: ARM: 8208/1: l2c:
 Refactor the driver to use commit-like)
Date: Thu, 11 Dec 2014 09:29:45 +0000
Message-ID: <20141211092945.GE11502@n2100.arm.linux.org.uk>
References: <5481D913.9040109@ti.com>
 <5481D9BF.2090007@ti.com>
 <20141209165746.GA29935@kahuna>
 <54881589.20105@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54881589.20105@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-omap <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-next <linux-next@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 10, 2014 at 10:42:33AM +0100, Marek Szyprowski wrote:
> I assume that now it won't be possible to get l2c patches back to -next,
> so I will resend them (again...) with the omap related fix.

What, you mean you don't know the fundamental rules of kernel development?

No one should ever dump any new code into linux-next during a merge
window which is not a fix for a regression or a bug fix, period.

Linus has in the past taken a snapshot of linux-next at the beginning
of a merge window, and then threatened to refuse to merge anything that
wasn't in his local snapshot, or which doesn't qualify as the above.

So no, it won't be possible, because I play by the community rules when
it comes to what gets merged and at what time in the cycle.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
