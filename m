From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: fix incorrect INT_DMA_LCD
Date: Wed, 28 Oct 2015 10:10:15 -0700
Message-ID: <20151028171003.GD3078@atomide.com>
References: <1445883833-12179-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1445883833-12179-1-git-send-email-aaro.koskinen@iki.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [151026 11:24]:
> Commit 685e2d08c54b ("ARM: OMAP1: Change interrupt numbering for
> sparse IRQ") turned on SPARSE_IRQ on OMAP1, but forgot to change
> the number of INT_DMA_LCD. This broke the boot at least on Nokia 770,
> where the device hangs during framebuffer initialization.
> 
> Fix by defining INT_DMA_LCD like the other interrupts.

OK good to hear, applying into omap-for-v4.3/fixes. If it does not get
pulled for v4.3, then it's already tagged cc: stable. BTW, you should
not send mail to cc stable when posting patches, Greg will send you
a note on that.

I'm having hard time booting 770 and n800 after I had to change my motherboard
last sring.

Somehow 0xFFFF can't get anything loaded over USB. I even installed a new
PCIe OHCI + EHCI adapter but still no luck.

Regards,

Tony

> Cc: stable@vger.kernel.org # v4.2+
> Fixes: 685e2d08c54b ("ARM: OMAP1: Change interrupt numbering for sparse IRQ")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  include/linux/omap-dma.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
> index e5a7013..88fa8af 100644
> --- a/include/linux/omap-dma.h
> +++ b/include/linux/omap-dma.h
> @@ -17,7 +17,7 @@
>  
>  #include <linux/platform_device.h>
>  
> -#define INT_DMA_LCD			25
> +#define INT_DMA_LCD			(NR_IRQS_LEGACY + 25)
>  
>  #define OMAP1_DMA_TOUT_IRQ		(1 << 0)
>  #define OMAP_DMA_DROP_IRQ		(1 << 1)
> -- 
> 2.4.0
> 
