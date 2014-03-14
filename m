From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/5] OMAP IOMMU fixes and IOMMU architecture questions
Date: Thu, 13 Mar 2014 21:33:37 -0500
Message-ID: <53226A81.3090501@ti.com>
References: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1394239574-2389-1-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sakari.ailus-X3B1VOXEql0@public.gmane.org, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

On 03/07/2014 06:46 PM, Laurent Pinchart wrote:
> Hello,
>
> This patch set fixes miscellaneous issues with the OMAP IOMMU driver, found
> when trying to port the OMAP3 ISP away from omap-iovmm to the ARM DMA API. The
> biggest issue is fixed by patch 5/5, while the other patches fix smaller
> problems that I've noticed when reading the code, without experiencing them at
> runtime.
>
> I'd like to take this as an opportunity to discuss OMAP IOMMU integration with
> the ARM DMA mapping implementation. The idea is to hide the IOMMU completely
> behind the DMA mapping API, making it completely transparent to drivers.

Thanks for starting the discussion.

>
> A drivers will only need to allocate memory with dma_alloc_*, and behind the
> scene the ARM DMA mapping implementation will find out that the device is
> behind an IOMMU and will map the buffers through the IOMMU, returning an I/O
> VA address to the driver. No direct call to the OMAP IOMMU driver or to the
> IOMMU core should be necessary anymore.
>
> To use the IOMMU the ARM DMA implementation requires a VA mapping to be
> created with a call to arm_iommu_create_mapping() and to then be attached to
> the device with arm_iommu_attach_device(). This is currently not performed by
> the OMAP IOMMU driver, I have thus added that code to the OMAP3 ISP driver for
> now. I believe this to still be an improvement compared to the current
> situation, as it allows getting rid of custom memory allocation code in the
> OMAP3 ISP driver and custom I/O VA space management in omap-iovmm. However,
> that code should ideally be removed from the driver. The question is, where
> should it be moved to ?
>
> One possible solution would be to add the code to the OMAP IOMMU driver.
> However, this would require all OMAP IOMMU users to be converted to the ARM
> DMA API. I assume there would be issues that I don't foresee though.

Yeah, I think this will pose some problems for the other main user of 
IOMMUs - the remoteproc devices (DSP, Dual-Cortex M3/M4 processors in 
OMAP4 and beyond). A remoteproc device also needs to map memory at 
specific addresses for its code and data sections, and not rely on a I/O 
VA address being given to it. The firmware sections are already linked 
at specific addresses, and so remoteproc needs to allocate memory, load 
the firmware and map into appropriate device addresses. We are doing 
this currently usage a combination of CMA memory to get contiguous 
memory (there are some restrictions for certain sections) and 
iommu_map/unmap API to program the MMU with these pages. This usage is 
different from what is expected from exchanging buffers, which can be 
allocated from a predefined mapping range. Even that one is tricky if we 
need to support different cache properties/attributes as the cache 
configuration is in general local to these processors.

>
> I'm not even sure whether the OMAP IOMMU driver would be the best place to put
> that code. Ideally VA spaces should be created by the platform somehow, and
> mapping of devices to IOMMUs should be handled by the IOMMU core instead of
> the IOMMU drivers. We're not there yet, and the path might not be
> straightforward, hence this attempt to start a constructive discussion.
>
> A second completely unrelated problem that I'd like to get feedback on is the
> suspend/resume support in the OMAP IOMMU driver, or rather the lack thereof.
> The driver exports omap_iommu_save_ctx() and omap_iommu_restore_ctx()
> functions and expects the IOMMU users to call them directly. This is really
> hackish to say the least. A proper suspend/resume implementation shouldn't be
> difficult to implement, and I'm wondering whether the lack of proper power
> management support comes from historical reasons only, or if there are
> problems I might not have considered.

Agreed, the current code definitely needs a cleanup and better 
organization (like folding into runtime suspend ops). The main thing is 
that we need the IOMMU to be activated as long as its parent device is 
active (like the omap3isp or a remoteproc device). And this behaviour 
needs separation from configuring it and programming for the first time. 
Only a user can dictate when an IOMMU is not needed. So we either need 
an API to activate or have access to the iommu's dev object somehow so 
that we can use the pm_runtime_get/put API to hold a usage counter and 
let the runtime suspend ops take care of save/restore without tearing 
down the domain or detaching the device.

>
> Last but not least, the patches are available at
>
> 	git://linuxtv.org/pinchartl/media.git omap3isp/dma
>
> along with a patch series that ports the OMAP3 ISP driver to the DMA API. I
> will submit that one for review once the IOMMU patches get accepted and after
> fixing a couple of remaining bugs (I'm aware that I have broken userspace
> PFNMAP buffers).

I have looked at your tree, and as you already stated, it seems to be 
right intermediate solution for now to get rid of omap-iovmm.

regards
Suman

>
> Laurent Pinchart (5):
>    iommu/omap: Use the cache cleaning API
>    iommu/omap: Fix 'no page for' debug message in flush_iotlb_page()
>    iommu/omap: Flush the TLB only after updating translation table
>      entries
>    iommu/omap: Remove comment about supporting single page mappings only
>    iommu/omap: Fix map protection value handling
>
>   drivers/iommu/omap-iommu.c | 68 ++++++++++++++++------------------------------
>   1 file changed, 23 insertions(+), 45 deletions(-)
>
