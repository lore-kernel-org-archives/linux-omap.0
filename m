From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 10/24] ARM: davinci: Add set dma_mask to eDMA devices
Date: Wed, 23 Sep 2015 10:25:19 -0700
Message-ID: <20150923172518.GH23801@atomide.com>
References: <1442915675-7121-1-git-send-email-peter.ujfalusi@ti.com>
 <1442915675-7121-11-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442915675-7121-11-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk, olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [150922 03:01]:
> The upcoming change to merge the arch/arm/common/edma.c into
> drivers/dma/edma.c will need this change when booting daVinci devices in
> no DT mode.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/Kconfig                      |    1 -
>  arch/arm/common/Kconfig               |    3 -
>  arch/arm/common/Makefile              |    1 -
>  arch/arm/common/edma.c                | 1431 --------------------------------
>  arch/arm/mach-davinci/devices-da8xx.c |    2 +
>  arch/arm/mach-davinci/dm355.c         |    1 +
>  arch/arm/mach-davinci/dm644x.c        |    1 +
>  arch/arm/mach-davinci/dm646x.c        |    1 +
>  arch/arm/mach-omap2/Kconfig           |    1 -
>  drivers/dma/Kconfig                   |    1 -
>  drivers/dma/edma.c                    | 1447 +++++++++++++++++++++++++++++++--
>  include/linux/platform_data/edma.h    |   74 --
>  12 files changed, 1394 insertions(+), 1570 deletions(-)
>  delete mode 100644 arch/arm/common/edma.c

Hmm I think I already acked the mach-omap2/Kconfig change,
but if not, here you are:

Acked-by: Tony Lindgren <tony@atomide.com>
