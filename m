From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 6/7] mtd: nand: omap2: Fix high memory dma prefetch
 transfer
Date: Wed, 13 Apr 2016 22:24:51 +0200
Message-ID: <20160413222451.704376b5@bbrezillon>
References: <1457654203-20856-1-git-send-email-fcooper@ti.com>
	<1457654203-20856-7-git-send-email-fcooper@ti.com>
	<20160321160443.0a4165d1@bbrezillon>
	<570EA72C.7000806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <570EA72C.7000806-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Franklin,

On Wed, 13 Apr 2016 15:08:12 -0500
"Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org> wrote:

> 
> 
> On 03/21/2016 10:04 AM, Boris Brezillon wrote:
> > Hi Franklin,
> > 
> > On Thu, 10 Mar 2016 17:56:42 -0600
> > Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org> wrote:
> > 
> >> Based on DMA documentation and testing using high memory buffer when
> >> doing dma transfers can lead to various issues including kernel
> >> panics.
> > 
> > I guess it all comes from the vmalloced buffer case, which are not
> > guaranteed to be physically contiguous (one of the DMA requirement,
> > unless you have an iommu).
> > 
> >>
> >> To workaround this simply use cpu copy. The amount of high memory
> >> buffers used are very uncommon so no noticeable performance hit should
> >> be seen.
> > 
> > Hm, that's not necessarily true. UBI and UBIFS allocate their buffers
> > using vmalloc (vmalloced buffers fall in the high_memory region), and
> > those are likely to be dis-contiguous if you have NANDs with pages > 4k.
> > 
> > I recently posted patches to ease sg_table creation from any kind of
> > virtual address [1][2]. Can you try them and let me know if it fixes
> > your problem?
> 
> It looks like you won't be going forward with your patchset based on
> this thread [1].

Nope. According to Russell it's unsafe to do that.

> I can probably reword the patch description to avoid
> implying that it is uncommon to run into high mem buffers. Also DMA with
> NAND prefetch suffers from a reduction of performance compared to CPU
> polling with prefetch. This is largely due to the significant over head
> required to read such a small amount of data at a time. The
> optimizations I've worked on all revolved around reducing the cycles
> spent before executing the DMA request. Trying to make a high memory
> buffer able to be used by the DMA adds significant amount of cycles and
> your better off just using the cpu for performance reasons.

Okay.
One comment though, why not using virt_addr_valid() instead of
addr >= high_memory here?

Best Regards,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
