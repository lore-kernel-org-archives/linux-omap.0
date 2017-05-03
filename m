From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/4] usb: musb: tusb6010_omap: Convert to DMAengine
Date: Wed, 3 May 2017 13:57:22 +0300
Message-ID: <34c1f818-8aa9-5240-e881-9de85e449191@ti.com>
References: <20170503105406.25125-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170503105406.25125-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: b-liu@ti.com, tony@atomide.com, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Sorry,

I have forgot to update the commit message for the last patch.

On 2017-05-03 13:54, Peter Ujfalusi wrote:
> Hi,
>
> With port_window support implemented in DMAengine and the sDMA DMAengine driver,
> the tusb6010_omap driver can be converted away from the custom legacy omap-dma
> API to generic DMAengine.
>
> The first two patch is to prepare the tusb6010_omap driver for the conversion.
> The third one adds the needed entries for the dma_slave_map so we can request
> the DMA channels. This can be reverted when the stack is converted to DT.
>
> The last patch does the main work to move the driver to DMAengine API.
>
> I have tested the set on top of next-20170503 on Nokia n810 with nfsroot using
> CDC Ethernet (g_cdc) and copying files with scp to/form my host.
>
> To force that the DMA is actually used I have:
> diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
> index 05aefcad40b5..a5fc2a6bdad3 100644
> --- a/drivers/usb/musb/tusb6010_omap.c
> +++ b/drivers/usb/musb/tusb6010_omap.c
> @@ -216,8 +216,8 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
>  	 * use a timer for the callback, but it is unsafe as the XFR_SIZE
>  	 * register is corrupt, and we won't know if the DMA worked.
>  	 */
> -	if (dma_addr & 0x2)
> -		return false;
> +// 	if (dma_addr & 0x2)
> +// 		return false;
>
>  	/*
>  	 * Because of HW issue #10, it seems like mixing sync DMA and async
>
> Since this condition will almost all the time was true - effectively disabling
> the DMA use.
>
> Regards.
> Peter
> ---
> Peter Ujfalusi (4):
>   usb: musb: tusb6010_omap: Create new struct for DMA data/parameters
>   usb: musb: tusb6010_omap: Allocate DMA channels upfront
>   ARM: OMAP2+: DMA: Add slave map entries for 24xx external request
>     lines
>   usb: musb: tusb6010_omap: Convert to dmaengine WIP
>
>  arch/arm/mach-omap2/dma.c        |  24 +++
>  drivers/usb/musb/tusb6010_omap.c | 342 ++++++++++++++++++---------------------
>  2 files changed, 177 insertions(+), 189 deletions(-)
>

- Péter
