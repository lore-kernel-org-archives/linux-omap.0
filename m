From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 6/7] mtd: nand: omap2: Fix high memory dma prefetch
 transfer
Date: Mon, 21 Mar 2016 16:04:43 +0100
Message-ID: <20160321160443.0a4165d1@bbrezillon>
References: <1457654203-20856-1-git-send-email-fcooper@ti.com>
	<1457654203-20856-7-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457654203-20856-7-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Cc: nsekhar-l0cyMroinI0@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Franklin,

On Thu, 10 Mar 2016 17:56:42 -0600
Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org> wrote:

> Based on DMA documentation and testing using high memory buffer when
> doing dma transfers can lead to various issues including kernel
> panics.

I guess it all comes from the vmalloced buffer case, which are not
guaranteed to be physically contiguous (one of the DMA requirement,
unless you have an iommu).

> 
> To workaround this simply use cpu copy. The amount of high memory
> buffers used are very uncommon so no noticeable performance hit should
> be seen.

Hm, that's not necessarily true. UBI and UBIFS allocate their buffers
using vmalloc (vmalloced buffers fall in the high_memory region), and
those are likely to be dis-contiguous if you have NANDs with pages > 4k.

I recently posted patches to ease sg_table creation from any kind of
virtual address [1][2]. Can you try them and let me know if it fixes
your problem?

Thanks,

Boris

[1]https://lkml.org/lkml/2016/3/8/276
[2]https://lkml.org/lkml/2016/3/8/277


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
