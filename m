From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: Regression in Linux next with dma cma changes
Date: Tue, 26 Feb 2019 12:15:19 -0800
Message-ID: <20190226201518.GA3205@Asurada-Nvidia.nvidia.com>
References: <20190226200155.GE39872@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190226200155.GE39872@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 26, 2019 at 12:01:55PM -0800, Tony Lindgren wrote:
> Looks like commit d222e42e8816 ("dma-contiguous: do not allocate a
> single page from CMA area") caused a regression at least for
> omap dss where we now get the following error on init:
> 
> omapdss_dispc 58001000.dispc:
> dispc_errata_i734_wa_init: dma_alloc_writecombine failed
> 
> Any ideas what might be going wrong?

It's probably because the dma_alloc_from_contiguous() call in
this path doesn't rebound to allocate a normal single page.

And I guess we should have left the change within dma-direct.

Christoph, do you agree?

I am submitting a revert first.
