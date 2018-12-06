From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: dmapool regression in next
Date: Thu, 6 Dec 2018 15:51:43 +0000
Message-ID: <451215b8-548a-eff7-9e96-0ff5f8cbb614@arm.com>
References: <20181206013054.GI6707@atomide.com>
 <CAJKOXPcoK5SsXfXjdAWPHLX2KZRCqOv61HVf2DK9wm4_m+vJ0w@mail.gmail.com>
 <09e73d24-467a-52bb-0433-a9596d4d6f02@cybernetics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <09e73d24-467a-52bb-0433-a9596d4d6f02@cybernetics.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Battersby <tonyb@cybernetics.com>, Krzysztof Kozlowski <krzk@kernel.org>, tony@atomide.com
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, john.garry@huawei.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, akpm@linux-foundation.org, linux-omap@vger.kernel.org, hch@lst.de, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

On 06/12/2018 15:11, Tony Battersby wrote:
> On 12/6/18 4:25 AM, Krzysztof Kozlowski wrote:
>> On Thu, 6 Dec 2018 at 02:31, Tony Lindgren <tony@atomide.com> wrote:
>>> Hi,
>>>
>>> Looks like with commit 26abe88e830d ("mm/dmapool.c: improve scalability
>>> of dma_pool_free()") I'm now getting spammed with lots of "(bad vaddr)"
>>> on at least omap4 pandaboard, see below.
>>>
>>> Any ideas what might be going wrong?
>>>
>>> Regards,
>>>
>>> Tony
>>>
>>> 8< ---------------------
>>> omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe800000
>>> omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe80001c
>>> omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe800038
>>> ...
>> I see it as well on all my Exynos boards, since yesterday's next. In
>> my case it is the USB EHCI driver:
>> exynos-ehci 12110000.usb: dma_pool_free ehci_qtd, (ptrval) (bad
>> vaddr)/0xb8844180
>> Full log here:
>> https://krzk.eu/#/builders/1/builds/2937/steps/12/logs/serial0
>>
>> Best regards,
>> Krzysztof
>>
> Here is the prototype:
> 
> void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma);
> 
> With the old code, the 'dma' value had to be correct for use with
> pool_find_page(), or else you would get an error.  If the 'vaddr' value
> was incorrect, it would corrupt the dmapool freelist, but you wouldn't
> get an error unless DMAPOOL_DEBUG was enabled.
> 
> With my patch applied, 'vaddr' has to be correct for virt_to_page().  My
> code also checks that 'dma' is consistent with 'vaddr' even if
> DMAPOOL_DEBUG is disabled, since the check is fast and it will prevent
> problems like this in the future.

Unfortunately that logic has a fatal flaw - DMA pools are backed by 
dma_alloc_coherent(), and there is absolutely no guarantee that the 
memory dma_alloc_coherent() returns is backed by a struct page at all. 
Even if it is, there is still absolutely no guarantee that the vaddr 
value it returns is valid for virt_to_page() - on many systems it will 
be in vmalloc or some architecture-specific region of address space.

The problem is not that these drivers are buggy (they're not - the arch 
code is returning a vmalloc()ed non-cacheable remap in the first place), 
it's that 26abe88e830d is fundamentally unworkable and needs reverting. 
Apparently the original patches managed not to catch my eye as something 
I needed to review, sorry about that :(

Robin.

> 
> So if a buggy driver passes in a good value for 'dma' but a bad value
> for 'vaddr', then it may have appeared to work previously (but with
> possible data corruption, depending on the circumstances), but my patch
> will expose the problem.  You can confirm by reverting my dmapool
> patches and enabling DMAPOOL_DEBUG, which is at the top of mm/dmapool.c:
> 
> #if defined(CONFIG_DEBUG_SLAB) || defined(CONFIG_SLUB_DEBUG_ON)
> #define DMAPOOL_DEBUG 1
> #endif
> 
> Tony Battersby
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
