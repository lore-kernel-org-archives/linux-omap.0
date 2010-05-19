From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 1/4] OMAP: mcbsp - add
	omap_mcbsp_set_dma_op_mode()
Date: Wed, 19 May 2010 13:50:56 +0300
Message-ID: <20100519105056.GK4265@besouro.research.nokia.com>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
	<1274213594-26554-2-git-send-email-lrg@slimlogic.co.uk>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1274213594-26554-2-git-send-email-lrg@slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, May 18, 2010 at 10:13:11PM +0200, Liam Girdwood wrote:
> This adds a method to set the MCBSP DMA OP mode.

OK. good. But again, why do you need set dma op mode other than inside mcbsp code?

Right, so, from what I have read briefly, the idea is to remove the user space ability to set the mode and
let mcbsp clients to do it. What is not clear to me is how mcbsp clients (inside kernel) will determine if they want
short delay or pm friendly. That usually is bound to upper use case though.

It would be really nice if you improve your patch descriptions.

> 
> Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
> ---
>  arch/arm/plat-omap/include/plat/mcbsp.h |    2 ++
>  arch/arm/plat-omap/mcbsp.c              |   31 +++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
> index 1bd7021..f8823f4 100644
> --- a/arch/arm/plat-omap/include/plat/mcbsp.h
> +++ b/arch/arm/plat-omap/include/plat/mcbsp.h
> @@ -476,6 +476,7 @@ u16 omap_mcbsp_get_max_rx_threshold(unsigned int id);
>  u16 omap_mcbsp_get_tx_delay(unsigned int id);
>  u16 omap_mcbsp_get_rx_delay(unsigned int id);
>  int omap_mcbsp_get_dma_op_mode(unsigned int id);
> +int omap_mcbsp_set_dma_op_mode(unsigned int id, unsigned int mode);
>  #else
>  static inline void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
>  { }
> @@ -486,6 +487,7 @@ static inline u16 omap_mcbsp_get_max_rx_threshold(unsigned int id) { return 0; }
>  static inline u16 omap_mcbsp_get_tx_delay(unsigned int id) { return 0; }
>  static inline u16 omap_mcbsp_get_rx_delay(unsigned int id) { return 0; }
>  static inline int omap_mcbsp_get_dma_op_mode(unsigned int id) { return 0; }
> +static inline int omap_mcbsp_set_dma_op_mode(unsigned int id, unsigned int mode) {return 0;}
>  #endif
>  int omap_mcbsp_request(unsigned int id);
>  void omap_mcbsp_free(unsigned int id);
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index 4820cab..cc2b73c 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -635,6 +635,37 @@ int omap_mcbsp_get_dma_op_mode(unsigned int id)
>  }
>  EXPORT_SYMBOL(omap_mcbsp_get_dma_op_mode);
>  
> +/*
> + * omap_mcbsp_set_dma_op_mode set the current DMA
> + * operating mode for the mcbsp channel
> + */
> +int omap_mcbsp_set_dma_op_mode(unsigned int id, unsigned int mode)
> +{
> +	struct omap_mcbsp *mcbsp;
> +	int ret = 0;
> +
> +	if (mode > MCBSP_DMA_MODE_FRAME)
> +		return -EINVAL;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
> +		return -ENODEV;
> +	}
> +	mcbsp = id_to_mcbsp_ptr(id);
> +
> +	spin_lock_irq(&mcbsp->lock);
> +	if (!mcbsp->free) {
> +		ret = -EBUSY;
> +		goto unlock;
> +	}
> +	mcbsp->dma_op_mode = mode;
> +
> +unlock:
> +	spin_unlock_irq(&mcbsp->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL(omap_mcbsp_set_dma_op_mode);
> +
>  static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
>  {
>  	/*
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
