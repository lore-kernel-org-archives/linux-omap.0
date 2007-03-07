From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: Fw: [PATCH 0/3] OMAP MMU framework patches
Date: Wed, 7 Mar 2007 17:17:29 +0900
Message-ID: <20070307081729.GA12467@linux-sh.org>
References: <20070306.110121.34761109.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070306.110121.34761109.Hiroshi.DOYU@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Resending due to the list auto-rejecting..

On Tue, Mar 06, 2007 at 11:01:21AM +0200, Hiroshi DOYU wrote:
> Date: Mon, 5 Mar 2007 13:31:09 -0600
> From: "ext Zhang, Jian" <jzhang@ti.com>
> To: linux-omap-open-source@linux.omap.com
> Subject: RE: [PATCH 0/3] OMAP MMU framework patches
> 
> - omap_mmu_exmap(): It either maps a physically contiguous buffer to a
> virtually contiguous space (when type!=EXMAP_TYPE_MEM), or allocates a
> set of 1M/64K/4K buffers and maps these buffers to a virtually
> contiguous space (when type==EXMAP_TYPE_MEM). It doesn't seem to me that
> this API can map a set of dis-contiguous pages to a contiguous virtual
> space. The typical camera use case is that we need to map a
> scatter-gather list to a contiguous virtual space. I don't see this is
> supported. Do I miss something here?
> 
That's intentional, if it's not contiguous you're going to have to build
it up with multiple TLB entries anyways equating to the page size. The
scatterlist case is definitely something where wiring up the TWL really
makes sense.

You can trivially write something like omap_mmu_map_sg() that does the
scatterlist enumeration and exmap mapping, there's no reason to do this
in struct omap_mmu_ops since it's purely a software management issue.

> - The same API also checks the TLB. A mapping request is denied if TLB
> is full. Camera MMU has only 8 TLB entries. TLB-only approach is almost
> certainly impossible. Is the framework allowing the underlying MMU
> driver to use table walking logic? This is not clear to me as the struct
> omap_mmu_ops doesn't have enough comments. 
> 
That was the direction this work was going, but it hasn't been
implemented generically yet. The intent was to have process context
visibility for each one of the users where the translation table base
for the TWL would be reloaded on a context switch, using something like
the unused MPU-side stack pages for building the per-process page tables.

There's nothing that really stops you from using the exmap interface for
building on top of this though, you basically need a ranged remapper and
a software pgprot flag for determining whether the entry is statically
wired (and thus preserved across a TLB flush) or whether you rely on the
TWL to service the miss. So you can of course build a camera page table
and hand that off directly with minimal impact, it's certainly the
easiest case for the TWL, since you don't have the codec context
switching to worry about.
