From: =?ISO-8859-1?Q?Anders_Grafstr=F6m?= <grfstrm@users.sourceforge.net>
Subject: Re: [RFC] ARM: DMA coherent allocator: align remapped addresses
Date: Wed, 22 Sep 2010 16:49:22 +0200
Message-ID: <4C9A1772.4000502@users.sourceforge.net>
References: <20100725135024.GA6609@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100725135024.GA6609@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 2010-07-25 15:50, Russell King - ARM Linux wrote:
> +	 * Align the virtual region allocation - maximum alignment is
> +	 * a section size, minimum is a page size.  This helps reduce
> +	 * fragmentation of the DMA space, and also prevents allocations
> +	 * smaller than a section from crossing a section boundary.
> +	 */
> +	bit = fls(size - 1) + 1;
> +	if (bit > SECTION_SHIFT)
> +		bit = SECTION_SHIFT;
> +	align = 1 << bit;

A size of 4096 results in an alignment of 8192. Is that really intended?
ixp4xx seems to run out of vmregion due to this. The patch below makes it work again.

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 4bc43e5..7012105 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -198,7 +198,7 @@ __dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot)
 	 * fragmentation of the DMA space, and also prevents allocations
 	 * smaller than a section from crossing a section boundary.
 	 */
-	bit = fls(size - 1) + 1;
+	bit = fls(size - 1);
 	if (bit > SECTION_SHIFT)
 		bit = SECTION_SHIFT;
 	align = 1 << bit;
