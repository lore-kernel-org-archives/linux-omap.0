From: Tony Lindgren <tony@atomide.com>
Subject: Regression in Linux next with dma cma changes
Date: Tue, 26 Feb 2019 12:01:55 -0800
Message-ID: <20190226200155.GE39872@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

Hi,

Looks like commit d222e42e8816 ("dma-contiguous: do not allocate a
single page from CMA area") caused a regression at least for
omap dss where we now get the following error on init:

omapdss_dispc 58001000.dispc:
dispc_errata_i734_wa_init: dma_alloc_writecombine failed

Any ideas what might be going wrong?

Regards,

Tony
