From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 0/7] Enable L2 cache support on Exynos4210/4x12 SoCs
Date: Fri, 14 Nov 2014 15:51:39 +0100
Message-ID: <2593372.vOeyyAKq5M@wuerfel>
References: <1415884694-5868-1-git-send-email-m.szyprowski@samsung.com> <54660DAE.9090601@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <54660DAE.9090601@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Olof Johansson <olof@lixom.net>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, lauraa@codeaurora.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, tony@atomide.com, drake@endlessm.com, loeliger@gmail.com, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-omap@vger.kernel.org

On Friday 14 November 2014 15:11:58 Marek Szyprowski wrote:
> 
> I assume that after all comments from previous versions, no more changes 
> are needed
> to this patchset and I would really like to have it queued to v3.19.
> 
> Arnd, Olof: could you take this patchset thought arm-soc tree? It already
> contains all dependencies.
> 
> Kukjin: could you ack this patchset?

I'd rather see this merged through Russell's tree, as most of the patches
are for core code, and only three are for the platform.

For the exynos patches:

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
