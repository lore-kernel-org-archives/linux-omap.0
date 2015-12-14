From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V02 0/5] dmaengine: New 'universal' API for requesting channel
Date: Mon, 14 Dec 2015 12:32:23 +0100
Message-ID: <1533685.J1X7ETnh7U@wuerfel>
References: <1450092140-31602-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450092140-31602-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On Monday 14 December 2015 13:22:15 Peter Ujfalusi wrote:
> 
> Changes since v1:
> - Added Reviewed-by from Andy for patch 1-2, I decided to not add the reviewed-by
>   to patch 3 due to the changes since v1
> - patch for omap-dma to support passing the filter setup to the core
> - dma_request_slave_channel_reason() remeved and it is now defines as
>   dma_request_chan()
> - Print of warning removed when DT or ACPI lookup fails and we are going to
>   Fallback to legacy lookup
> - members of struct dma_filter has been revised for simplicity.

Whole series

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Looks all great to me now.
