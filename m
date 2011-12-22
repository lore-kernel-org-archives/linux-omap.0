From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [RFC PATCH v2 4/8] media: videobuf2: introduce VIDEOBUF2_PAGE
 memops
Date: Thu, 22 Dec 2011 10:28:49 +0100
Message-ID: <010501ccc08c$1c7b7870$55726950$%szyprowski@samsung.com>
References: <1323871214-25435-1-git-send-email-ming.lei@canonical.com>
 <1323871214-25435-5-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1323871214-25435-5-git-send-email-ming.lei@canonical.com>
Content-language: pl
Sender: linux-kernel-owner@vger.kernel.org
To: 'Ming Lei' <ming.lei@canonical.com>, 'Mauro Carvalho Chehab' <mchehab@infradead.org>, 'Tony Lindgren' <tony@atomide.com>
Cc: 'Sylwester Nawrocki' <snjw23@gmail.com>, 'Alan Cox' <alan@lxorguk.ukuu.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 'Pawel Osciak' <p.osciak@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hello,

On Wednesday, December 14, 2011 3:00 PM Ming Lei wrote:

> DMA contig memory resource is very limited and precious, also
> accessing to it from CPU is very slow on some platform.
> 
> For some cases(such as the comming face detection driver), DMA Streaming
> buffer is enough, so introduce VIDEOBUF2_PAGE to allocate continuous
> physical memory but letting video device driver to handle DMA buffer mapping
> and unmapping things.
> 
> Signed-off-by: Ming Lei <ming.lei@canonical.com>

Could you elaborate a bit why do you think that DMA contig memory resource
is so limited? If dma_alloc_coherent fails because of the memory fragmentation,
the alloc_pages() call with order > 0 will also fail.

I understand that there might be some speed issues with coherent (uncached)
userspace mappings, but I would solve it in completely different way. The interface
for both coherent/uncached and non-coherent/cached contig allocator should be the
same, so exchanging them is easy and will not require changes in the driver.
I'm planning to introduce some design changes in memory allocator api and introduce
prepare and finish callbacks in allocator ops. I hope to post the rfc after
Christmas. For your face detection driver using standard dma-contig allocator
shouldn't be a big issue.

Your current implementation also abuses the design and api of videobuf2 memory
allocators. If the allocator needs to return a custom structure to the driver
you should use cookie method. vaddr is intended to provide only a pointer to
kernel virtual mapping, but you pass a struct page * there.

(snipped)

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
