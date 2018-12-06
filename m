From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: dmapool regression in next
Date: Thu, 6 Dec 2018 10:25:20 +0100
Message-ID: <CAJKOXPcoK5SsXfXjdAWPHLX2KZRCqOv61HVf2DK9wm4_m+vJ0w@mail.gmail.com>
References: <20181206013054.GI6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206013054.GI6707@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: tonyb@cybernetics.com, akpm@linux-foundation.org, Stephen Rothwell <sfr@canb.auug.org.au>, andy.shevchenko@gmail.com, hch@lst.de, john.garry@huawei.com, Marek Szyprowski <m.szyprowski@samsung.com>, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 6 Dec 2018 at 02:31, Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> Looks like with commit 26abe88e830d ("mm/dmapool.c: improve scalability
> of dma_pool_free()") I'm now getting spammed with lots of "(bad vaddr)"
> on at least omap4 pandaboard, see below.
>
> Any ideas what might be going wrong?
>
> Regards,
>
> Tony
>
> 8< ---------------------
> omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe800000
> omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe80001c
> omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe800038
> ...

I see it as well on all my Exynos boards, since yesterday's next. In
my case it is the USB EHCI driver:
exynos-ehci 12110000.usb: dma_pool_free ehci_qtd, (ptrval) (bad
vaddr)/0xb8844180
Full log here:
https://krzk.eu/#/builders/1/builds/2937/steps/12/logs/serial0

Best regards,
Krzysztof
