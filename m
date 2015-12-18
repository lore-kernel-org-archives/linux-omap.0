From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH V03 0/5] dmaengine: New 'universal' API for requesting
 channel
Date: Fri, 18 Dec 2015 11:19:09 +0530
Message-ID: <20151218054908.GV1854@localhost>
References: <1450126062-8063-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450126062-8063-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: arnd@arndb.de, andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 14, 2015 at 10:47:37PM +0200, Peter Ujfalusi wrote:
> Hi,
> 
> As it has been discussed in the following thread:
> http://www.gossamer-threads.com/lists/linux/kernel/2181487#2181487
> 
> With this series I have taken a path which would result two new API, which can
> be used to convert most of the current users already and with some work all
> users might be able to move to this set.
> With this set the filter_fn used for legacy (non DT/ACPI) channel request is no
> longer needed to be exported to client drivers since the selection of the
> correct filter_fn will be done in the core.

Applied now,

Thanks for this rework, much appreciated :-)

-- 
~Vinod
