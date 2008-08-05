From: "Bryan Wu" <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] MUSB: Workaround for simultaneous TX and RX usage
Date: Tue, 5 Aug 2008 11:13:17 +0800
Message-ID: <386072610808042013w524d534r15ff8546ea1decd5@mail.gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02568EBABF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02568EBABF-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 4, 2008 at 9:18 PM, Gadiyar, Anand <gadiyar-l0cyMroinI0@public.gmane.org> wrote:
> MUSB RTL v1.4 has a hardware issue which results in a DMA controller
> hang when TX and RX DMA channels are simultaneously enabled. This
> affects at least OMAP2430 and OMAP34XX.
>
> Since RX transfers are in Mode 0 and anyway result in one DMA interrupt
> per packet, we can use System DMA to unload the RX fifos. MUSB DMA can
> be used for all TX channels as before.
>

Hi Gadiyar,

We also found some similar issue on Blackfin with the MUSB+musbhsdma.
Some time DMA mode 1 interrupt lost and system hang.

But if we use the PIO mode and rewrite the
musb_read_fifo/musb_write_fifo to use DMA polling method,
the issue is gone.

Any idea about this?

-Bryan

> Tested with full-duplex TX and RX transfers using g_ether. Runs for 24
> hours without a hang. Without this patch, the hang occurs within minutes.
>
> Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
> ---
> This issue was first reported by Jon Hunter on [1]
>
> [1] http://marc.info/?l=linux-omap&m=119634480534453&w=2
>
>  drivers/usb/musb/Kconfig     |    8 +
>  drivers/usb/musb/musbhsdma.c |  174 +++++++++++++++++++++++++++++++++++--------
>  2 files changed, 153 insertions(+), 29 deletions(-)
>
> Index: testing/drivers/usb/musb/musbhsdma.c
> ===================================================================
> --- testing.orig/drivers/usb/musb/musbhsdma.c
> +++ testing/drivers/usb/musb/musbhsdma.c
> @@ -34,6 +34,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
>  #include "musb_core.h"
> +#include <asm/arch/dma.h>
>
>  #if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430)
>  #include "omap2430.h"
> @@ -64,6 +65,9 @@
>
>  #define MUSB_HSDMA_CHANNELS            8
>
> +#define MUSB_FIFO_ADDRESS(epnum)       \
> +       ((unsigned long) (OMAP_HSOTG_BASE + MUSB_FIFO_OFFSET(epnum)))
> +
>  struct musb_dma_controller;
>
>  struct musb_dma_channel {
> @@ -75,6 +79,10 @@ struct musb_dma_channel {
>        u8                              bIndex;
>        u8                              epnum;
>        u8                              transmit;
> +
> +#ifdef CONFIG_MUSB_USE_SYSTEM_DMA_RX
> +       int                             sysdma_channel;
> +#endif
>  };
>
>  struct musb_dma_controller {
> @@ -93,6 +101,10 @@ static int dma_controller_start(struct d
>        return 0;
>  }
>
> +#ifdef CONFIG_MUSB_USE_SYSTEM_DMA_RX
> +static void musb_sysdma_completion(int lch, u16 ch_status, void *data);
> +#endif
> +
>  static void dma_channel_release(struct dma_channel *pChannel);
>
>  static int dma_controller_stop(struct dma_controller *c)
> @@ -144,6 +156,30 @@ static struct dma_channel *dma_channel_a
>                        /* Tx => mode 1; Rx => mode 0 */
>                        pChannel->desired_mode = transmit;
>                        pChannel->actual_len = 0;
> +                       pImplChannel->sysdma_channel = -1;
> +
> +#ifdef CONFIG_MUSB_USE_SYSTEM_DMA_RX
> +                       if (!transmit) {
> +                               int ret;
> +                               ret = omap_request_dma(OMAP24XX_DMA_NO_DEVICE,
> +                                       "MUSB SysDMA", musb_sysdma_completion,
> +                                       (void *) pImplChannel,
> +                                       &(pImplChannel->sysdma_channel));
> +/* FIXME: Decide on the correct private data to use */
> +
> +                               if (ret) {
> +                                       printk(KERN_ERR "request_dma failed:"
> +                                                       " %d\n", ret);
> +                                       controller->bmUsedChannels &=
> +                                                               ~(1 << bBit);
> +                                       pChannel->status =
> +                                                       MUSB_DMA_STATUS_UNKNOWN;
> +                                       pImplChannel->sysdma_channel = -1;
> +                                       pChannel = NULL;
> +                               }
> +                       }
> +#endif
> +
>                        break;
>                }
>        }
> @@ -163,6 +199,14 @@ static void dma_channel_release(struct d
>                ~(1 << pImplChannel->bIndex);
>
>        pChannel->status = MUSB_DMA_STATUS_UNKNOWN;
> +
> +#ifdef CONFIG_MUSB_USE_SYSTEM_DMA_RX
> +       if (pImplChannel->sysdma_channel != -1) {
> +               omap_stop_dma(pImplChannel->sysdma_channel);
> +               omap_free_dma(pImplChannel->sysdma_channel);
> +               pImplChannel->sysdma_channel = -1;
> +       }
> +#endif
>  }
>
>  static void configure_channel(struct dma_channel *pChannel,
> @@ -179,43 +223,108 @@ static void configure_channel(struct dma
>        DBG(4, "%p, pkt_sz %d, addr 0x%x, len %d, mode %d\n",
>                        pChannel, packet_sz, dma_addr, len, mode);
>
> -       if (mode) {
> -               csr |= 1 << MUSB_HSDMA_MODE1_SHIFT;
> -               BUG_ON(len < packet_sz);
> +#ifdef CONFIG_MUSB_USE_SYSTEM_DMA_RX
> +       if (pImplChannel->sysdma_channel != -1) {
> +       /* System DMA */
> +       /* RX: set src = FIFO */
> +
> +               omap_set_dma_transfer_params(pImplChannel->sysdma_channel,
> +                                       OMAP_DMA_DATA_TYPE_S8,
> +                                       len, 1, /* One frame */
> +                                       OMAP_DMA_SYNC_ELEMENT,
> +                                       OMAP24XX_DMA_NO_DEVICE,
> +                                       0); /* Src Sync */
> +
> +               omap_set_dma_src_params(pImplChannel->sysdma_channel, 0,
> +                                       OMAP_DMA_AMODE_CONSTANT,
> +                                       MUSB_FIFO_ADDRESS(pImplChannel->epnum),
> +                                       0, 0);
> +
> +               omap_set_dma_dest_params(pImplChannel->sysdma_channel, 0,
> +                                       OMAP_DMA_AMODE_POST_INC, dma_addr,
> +                                       0, 0);
> +
> +               omap_set_dma_dest_data_pack(pImplChannel->sysdma_channel, 1);
> +               omap_set_dma_dest_burst_mode(pImplChannel->sysdma_channel,
> +                                       OMAP_DMA_DATA_BURST_16);
>
> -               if (packet_sz >= 64) {
> -                       csr |= MUSB_HSDMA_BURSTMODE_INCR16
> +               omap_start_dma(pImplChannel->sysdma_channel);
> +
> +       } else
> +#endif
> +       { /* Mentor DMA */
> +               if (mode) {
> +                       csr |= 1 << MUSB_HSDMA_MODE1_SHIFT;
> +                       BUG_ON(len < packet_sz);
> +
> +                       if (packet_sz >= 64) {
> +                               csr |= MUSB_HSDMA_BURSTMODE_INCR16
>                                        << MUSB_HSDMA_BURSTMODE_SHIFT;
> -               } else if (packet_sz >= 32) {
> -                       csr |= MUSB_HSDMA_BURSTMODE_INCR8
> +                       } else if (packet_sz >= 32) {
> +                               csr |= MUSB_HSDMA_BURSTMODE_INCR8
>                                        << MUSB_HSDMA_BURSTMODE_SHIFT;
> -               } else if (packet_sz >= 16) {
> -                       csr |= MUSB_HSDMA_BURSTMODE_INCR4
> +                       } else if (packet_sz >= 16) {
> +                               csr |= MUSB_HSDMA_BURSTMODE_INCR4
>                                        << MUSB_HSDMA_BURSTMODE_SHIFT;
> +                       }
>                }
> -       }
>
> -       csr |= (pImplChannel->epnum << MUSB_HSDMA_ENDPOINT_SHIFT)
> -               | (1 << MUSB_HSDMA_ENABLE_SHIFT)
> -               | (1 << MUSB_HSDMA_IRQENABLE_SHIFT)
> -               | (pImplChannel->transmit
> -                               ? (1 << MUSB_HSDMA_TRANSMIT_SHIFT)
> -                               : 0);
> -
> -       /* address/count */
> -       musb_writel(mbase,
> -               MUSB_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_ADDRESS),
> -               dma_addr);
> -       musb_writel(mbase,
> -               MUSB_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_COUNT),
> -               len);
> -
> -       /* control (this should start things) */
> -       musb_writew(mbase,
> -               MUSB_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_CONTROL),
> -               csr);
> +               csr |= (pImplChannel->epnum << MUSB_HSDMA_ENDPOINT_SHIFT)
> +                       | (1 << MUSB_HSDMA_ENABLE_SHIFT)
> +                       | (1 << MUSB_HSDMA_IRQENABLE_SHIFT)
> +                       | (pImplChannel->transmit
> +                                       ? (1 << MUSB_HSDMA_TRANSMIT_SHIFT)
> +                                       : 0);
> +
> +               /* address/count */
> +               musb_writel(mbase,
> +                       MUSB_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_ADDRESS),
> +                       dma_addr);
> +               musb_writel(mbase,
> +                       MUSB_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_COUNT),
> +                       len);
> +
> +               /* control (this should start things) */
> +               musb_writew(mbase,
> +                       MUSB_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_CONTROL),
> +                       csr);
> +       } /* Mentor DMA */
>  }
>
> +#ifdef CONFIG_MUSB_USE_SYSTEM_DMA_RX
> +static void musb_sysdma_completion(int lch, u16 ch_status, void *data)
> +{
> +       u32 dwAddress;
> +       unsigned long flags;
> +
> +       struct dma_channel *pChannel;
> +
> +       struct musb_dma_channel *pImplChannel =
> +                                       (struct musb_dma_channel *) data;
> +       struct musb_dma_controller *controller = pImplChannel->controller;
> +       struct musb *musb = controller->pDmaPrivate;
> +       pChannel = &pImplChannel->Channel;
> +
> +       DBG(2, "lch = 0x%d, ch_status = 0x%x\n", lch, ch_status);
> +       spin_lock_irqsave(&musb->lock, flags);
> +
> +       dwAddress = (u32) omap_get_dma_dst_pos(pImplChannel->sysdma_channel);
> +       pChannel->actual_len = dwAddress - pImplChannel->dwStartAddress;
> +
> +       DBG(2, "ch %p, 0x%x -> 0x%x (%d / %d) %s\n",
> +               pChannel, pImplChannel->dwStartAddress, dwAddress,
> +               pChannel->actual_len, pImplChannel->len,
> +               (pChannel->actual_len < pImplChannel->len) ?
> +               "=> reconfig 0": "=> complete");
> +
> +       pChannel->status = MUSB_DMA_STATUS_FREE;
> +       musb_dma_completion(musb, pImplChannel->epnum, pImplChannel->transmit);
> +
> +       spin_unlock_irqrestore(&musb->lock, flags);
> +       return;
> +}
> +#endif
> +
>  static int dma_channel_program(struct dma_channel *pChannel,
>                                u16 packet_sz, u8 mode,
>                                dma_addr_t dma_addr, u32 len)
> @@ -265,6 +374,13 @@ static int dma_channel_abort(struct dma_
>                                MUSB_EP_OFFSET(pImplChannel->epnum, MUSB_TXCSR),
>                                csr);
>                } else {
> +#ifdef CONFIG_MUSB_USE_SYSTEM_DMA_RX
> +                       if (pImplChannel->sysdma_channel != -1) {
> +                               omap_stop_dma(pImplChannel->sysdma_channel);
> +                               omap_free_dma(pImplChannel->sysdma_channel);
> +                               pImplChannel->sysdma_channel = -1;
> +                       }
> +#endif
>                        csr = musb_readw(mbase,
>                                MUSB_EP_OFFSET(pImplChannel->epnum, MUSB_RXCSR));
>                        csr &= ~(MUSB_RXCSR_AUTOCLEAR |
> Index: testing/drivers/usb/musb/Kconfig
> ===================================================================
> --- testing.orig/drivers/usb/musb/Kconfig
> +++ testing/drivers/usb/musb/Kconfig
> @@ -150,6 +150,14 @@ config USB_INVENTRA_DMA
>        help
>          Enable DMA transfers using Mentor's engine.
>
> +config MUSB_USE_SYSTEM_DMA_RX
> +       bool 'Use System DMA for RX endpoints'
> +       depends on USB_MUSB_HDRC && USB_INVENTRA_DMA
> +       help
> +         MUSB RTL version 1.4 has a hardware issue when TX and RX DMA
> +         channels are simultaneously enabled. To work around this issue,
> +         you can choose to use System DMA for RX channels.
> +
>  config USB_TI_CPPI_DMA
>        bool
>        depends on USB_MUSB_HDRC && !MUSB_PIO_ONLY
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
