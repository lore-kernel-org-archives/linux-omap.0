From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCH] drm/omap: gem: Fix tearing with BO_TILED
Date: Mon, 6 Jan 2020 19:06:31 +0100
Message-ID: <20200106180631.GA30670@chinchilla>
References: <20191221005711.47314-1-tony@atomide.com>
 <20191221164141.GI35479@atomide.com>
 <20200104050950.GA11429@chinchilla>
 <20200104055011.GA5885@atomide.com>
 <20200105203704.GD5885@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20200105203704.GD5885@atomide.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tony Lindgren <tony@atomide.com>
Cc: "H . Nikolaus Schaller" <hns@goldelico.com>, Merlijn Wajer <merlijn@wizzup.org>, Sebastian Reichel <sre@kernel.org>, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun, Jan 05, 2020 at 12:37:04PM -0800, Tony Lindgren wrote:
> - Linux use of tiler aligned to 128 bytes

which is presumably a simplification of the alignment imposed by hardware:
-  64 bytes (64 pixels) for 8bpp
- 128 bytes (64 pixels) for 16bpp
- 128 bytes (32 pixels) for 32bpp


> - Fast userspace mapping aligned to 4096 bytes

Also for kernel mapping (vmap), e.g. for supporting a rotated fbdev


> 2. The alignment need may need to be configured by the tiler consumer

I guess omap_gem_pin should check for the alignment requirement by
iterating over all dma_buf attachments and intersecting their
attach->dev->dma_parms.segment_boundary_mask or something like that?
Since I feel like this is something more dma_buf exporters presumably
need, is there no existing utility function for this?


Of course in principle it ought to be possible (modulo bugs and API
restrictions) to use buffers that aren't aligned to MMU page size if
either

a. hardware is trusted to not read or touch data from unrelated buffers
that share MMU pages, or

b. buffers are only permitted to share MMU pages if they belong to the
same security context (though this is something that could also be done
in userspace: e.g. instead of allocating three separate 720-pixel wide
buffers, each one page per line, allocate one buffer that's 720*3 pixels
wide (2 pages per line) and use three slices thereof).


> - SGX use of tiler aligned to 4096 bytes (or 512 bytes?)
> 
> ...
> 
> 3. The alignment need for SGX seems to be based on SGX MMU page size

which is 4096 bytes apparently:

#define SGX_MMU_PAGE_SHIFT	(12)
#define SGX_MMU_PAGE_SIZE	(1U<<SGX_MMU_PAGE_SHIFT)

or rather, this is the smallest page size it supports:
#define SGX_MMU_PDE_PAGE_SIZE_4K	(0x00000000U)
#define SGX_MMU_PDE_PAGE_SIZE_16K	(0x00000002U)
#define SGX_MMU_PDE_PAGE_SIZE_64K	(0x00000004U)
#define SGX_MMU_PDE_PAGE_SIZE_256K	(0x00000006U)
#define SGX_MMU_PDE_PAGE_SIZE_1M	(0x00000008U)
#define SGX_MMU_PDE_PAGE_SIZE_4M	(0x0000000AU)
#define SGX_MMU_PDE_PAGE_SIZE_MASK	(0x0000000EU)


> 4. The issue I'm seeing with stellarium on droid4 may be a stride
>    issue as about one out of 3 or 4 frames is OK and aligning to
>    512 also fixes the issue maybe because it happens to make
>    multiple frames align to 4096

Yeah if your buffers are 960 pixels wide (assuming the droid4's screen
is natively portrait) and 32bpp then 512-byte alignment suffices to
automatically make them 4KB alignment.

The most obvious thing I can think of that could do wrong is that it
might contiguously map the pages that cover each line, which is what
will happen if they use e.g. for_each_sg_page, but subsequently assume
that the stride in sgx virtual memory is ALIGN( width * cpp, PAGE_SIZE )
without taking the offset of the buffer inside the mapping into account.

If each line is at most 4KB (i.e. 1024 pixels @ 32bpp) but each line
straddles an MMU page boundary, then the result would be that the even
lines of the frame are written to the top half of the buffer, causing it
to be scaled to 50% vertically, while the odd lines are "lost" (written
outside the buffer, either to a different buffer or unmapped tiler
memory).  This sounds like what you described on irc?


Matthijs
