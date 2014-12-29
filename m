From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v10 2/8] ARM: l2c: Refactor the driver to use commit-like
 interface
Date: Mon, 29 Dec 2014 08:29:58 -0600
Message-ID: <20141229142958.GA10746@kahuna>
References: <1419331716-8972-1-git-send-email-m.szyprowski@samsung.com>
 <1419331716-8972-3-git-send-email-m.szyprowski@samsung.com>
 <20141223170613.GM23854@atomide.com>
 <5499A2B4.2080909@ti.com>
 <549FEABA.10206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <549FEABA.10206@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, lauraa@codeaurora.org, linus.walleij@linaro.org, drake@endlessm.com, loeliger@gmail.com, Mark Rutland <mark.rutland@arm.com>, khilman@linaro.org
List-Id: linux-omap@vger.kernel.org

On 20:34-20141228, Tomasz Figa wrote:
> May I ask you (or anyone else working on OMAP) to try to figure out
> what the issue is? It is stopping L2 cache support for Exynos4 being

http://slexy.org/view/s2BnzxVglj
Took a register dump and compared -> Got the same dump
http://slexy.org/view/s21YRHpzeW .

Basically, this implies: possible sequence change broke AM437x or
some secure function call (which i have'nt dumped).

Is it possible to break up this patch into easier patches?

-- 
Regards,
Nishanth Menon
