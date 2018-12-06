From: Tony Battersby <tonyb@cybernetics.com>
Subject: Re: dmapool regression in next
Date: Thu, 6 Dec 2018 11:13:16 -0500
Message-ID: <9187bbd9-3aaf-c1b3-16a3-4e1b3356c52e@cybernetics.com>
References: <20181206013054.GI6707@atomide.com>
 <CAJKOXPcoK5SsXfXjdAWPHLX2KZRCqOv61HVf2DK9wm4_m+vJ0w@mail.gmail.com>
 <09e73d24-467a-52bb-0433-a9596d4d6f02@cybernetics.com>
 <451215b8-548a-eff7-9e96-0ff5f8cbb614@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <451215b8-548a-eff7-9e96-0ff5f8cbb614@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>, tony@atomide.com, akpm@linux-foundation.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, john.garry@huawei.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, linux-omap@vger.kernel.org, hch@lst.de, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>, Matthew Wilcox <willy@infradead.org>
List-Id: linux-omap@vger.kernel.org

On 12/6/18 10:51 AM, Robin Murphy wrote:
>> Here is the prototype:
>>
>> void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma);
>>
>> With the old code, the 'dma' value had to be correct for use with
>> pool_find_page(), or else you would get an error.  If the 'vaddr' value
>> was incorrect, it would corrupt the dmapool freelist, but you wouldn't
>> get an error unless DMAPOOL_DEBUG was enabled.
>>
>> With my patch applied, 'vaddr' has to be correct for virt_to_page().  My
>> code also checks that 'dma' is consistent with 'vaddr' even if
>> DMAPOOL_DEBUG is disabled, since the check is fast and it will prevent
>> problems like this in the future.
> Unfortunately that logic has a fatal flaw - DMA pools are backed by 
> dma_alloc_coherent(), and there is absolutely no guarantee that the 
> memory dma_alloc_coherent() returns is backed by a struct page at all. 
> Even if it is, there is still absolutely no guarantee that the vaddr 
> value it returns is valid for virt_to_page() - on many systems it will 
> be in vmalloc or some architecture-specific region of address space.
>
> The problem is not that these drivers are buggy (they're not - the arch 
> code is returning a vmalloc()ed non-cacheable remap in the first place), 
> it's that 26abe88e830d is fundamentally unworkable and needs reverting. 
> Apparently the original patches managed not to catch my eye as something 
> I needed to review, sorry about that :(
>
> Robin.
>
Thanks for the info; the inner workings of the vm system are a bit out
of my area of expertise.  My first version of the patch series used a
different method that didn't rely on virt_to_page(); I will go back to
that version, clean it up, and resubmit when I have time.

Andrew, please revert all 9 patches.  I will resubmit the set when I
have a workable solution.

Tony Battersby
