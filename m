From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 0/6] usb: musb: cppi41: Add a way to manage DMA irq
Date: Mon, 23 Jan 2017 15:26:33 -0600
Message-ID: <20170123212633.GC1609@uda0271908>
References: <20170123164808.27936-1-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170123164808.27936-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 23, 2017 at 05:48:02PM +0100, Alexandre Bailon wrote:
> This series was "dmaengine: cppi41: Make the driver more generic".
> I have tried to separate as munch I could CPPI 4.1 MUSB driver changes.
> 
> Currently, the DMA interrupt is managed by the CPPI 4.1 driver.
> The issue here is the CPPI 4.1 driver must access to MUSB glue registers
> to manage its interrupt.
> In order to move the interrupts management from CPPI 4.1 driver to MUSB
> (and then make it more generic), update the MUSB CPPI 4.1 driver with
> changes that will help to manage DMA interrupt from MUSB driver.
> 
> Changes in v4:
> - Remove musb pointer from struct cppi, cppi41_dma_controller and
>   tusb_omap_dma.
> 
> Changes in v3:
> - Move a patch from another series to this one to avoid build error report
>   from kbuild test robot
> - Instead of adding and exporting function, add one callback and a pointer
>   to musb in struct dma_controller
> - Surround the DMA function introduced in musb_dsps with #ifdef / #endif.
> 
> Changes in v2:
> - Fix some typo in commit messages
> - Add more explanation about some changes made by patch 2 in commit message
> 
> Alexandre Bailon (6):
>   usb: musb: dma: Add a DMA completion platform callback
>   usb: musb: cppi41: Detect aborted transfers in cppi41_dma_callback()
>   usb: musb: cppi_dma: Clean up cppi structure
>   usb: musb: cppi_dma: Clean up cppi41_dma_controller structure
>   usb: musb: cppi_dma: Clean up tusb_omap_dma structure
>   usb: musb: dsps: Manage CPPI 4.1 DMA interrupt in DSPS
> 
>  drivers/dma/cppi41.c             | 28 ++++----------
>  drivers/usb/musb/cppi_dma.c      | 26 ++++++-------
>  drivers/usb/musb/cppi_dma.h      |  1 -
>  drivers/usb/musb/musb_cppi41.c   | 48 +++++++++++++-----------
>  drivers/usb/musb/musb_dma.h      |  5 +++
>  drivers/usb/musb/musb_dsps.c     | 81 +++++++++++++++++++++++++++++++++++++++-
>  drivers/usb/musb/tusb6010_omap.c |  7 ++--
>  7 files changed, 134 insertions(+), 62 deletions(-)
> 

Please keep linux-usb list cc'd.

Regards,
-Bin.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
