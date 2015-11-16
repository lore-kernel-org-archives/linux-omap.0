From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: edma: fix build without CONFIG_OF
Date: Mon, 16 Nov 2015 09:06:07 +0530
Message-ID: <20151116033607.GV25173@localhost>
References: <17811472.bY8CqmdEVy@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <17811472.bY8CqmdEVy@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-arm-kernel@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 03, 2015 at 03:00:57PM +0100, Arnd Bergmann wrote:
> During the edma rework, a build error was introduced for the
> case that CONFIG_OF is disabled:
> 
> drivers/built-in.o: In function `edma_tc_set_pm_state':
> :(.text+0x43bf0): undefined reference to `of_find_device_by_node'
> 
> As the edma_tc_set_pm_state() function does nothing in case
> we are running without OF, this adds an IS_ENABLED() check
> that turns the function into an empty stub then and avoids the
> link error.

Applied, thanks

-- 
~Vinod
