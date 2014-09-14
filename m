From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v4 0/7] Enable L2 cache support on Exynos4210/4x12 SoCs
Date: Sun, 14 Sep 2014 19:50:32 +0200
Message-ID: <5415D568.60802@gmail.com>
References: <1409062680-15906-1-git-send-email-t.figa@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1409062680-15906-1-git-send-email-t.figa@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, linux-samsung-soc@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, lauraa@codeaurora.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, santosh.shilimkar@ti.com, tony@atomide.com, drake@endlessm.com, Marek Szyprowski <m.szyprowski@samsung.com>, loeliger@gmail.com
List-Id: linux-omap@vger.kernel.org

Russell, Olof, Kukjin,

On 26.08.2014 16:17, Tomasz Figa wrote:
> This series intends to add support for L2 cache on Exynos4 SoCs on boards
> running under secure firmware, which requires certain initialization steps
> to be done with help of firmware, as selected registers are writable only
> from secure mode.

I assume that since there has not been any input for almost 3 weeks,
this series can be merged. How should we proceed with it? Note that it
touches both core ARM and Exynos-specific areas and depends on another
Exynos-specific series [1].

[1] [PATCH v3 0/5] Firmware-assisted suspend/resume of Exynos SoCs
    (https://lkml.org/lkml/2014/8/26/445)

Best regards,
Tomasz
