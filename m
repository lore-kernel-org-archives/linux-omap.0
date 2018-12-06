From: Tony Lindgren <tony@atomide.com>
Subject: dmapool regression in next
Date: Wed, 5 Dec 2018 17:30:54 -0800
Message-ID: <20181206013054.GI6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Battersby <tonyb@cybernetics.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Christoph Hellwig <hch@lst.de>, John Garry <john.garry@huawei.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Looks like with commit 26abe88e830d ("mm/dmapool.c: improve scalability
of dma_pool_free()") I'm now getting spammed with lots of "(bad vaddr)"
on at least omap4 pandaboard, see below.

Any ideas what might be going wrong?

Regards,

Tony

8< ---------------------
omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe800000
omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe80001c
omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe800038
...
