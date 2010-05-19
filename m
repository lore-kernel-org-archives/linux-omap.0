From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 2/4] OMAP: mcbsp - add smart idle
	configuration API
Date: Wed, 19 May 2010 13:46:28 +0300
Message-ID: <20100519104628.GJ4265@besouro.research.nokia.com>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
	<1274213594-26554-3-git-send-email-lrg@slimlogic.co.uk>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1274213594-26554-3-git-send-email-lrg@slimlogic.co.uk>
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

Hello Lian,

On Tue, May 18, 2010 at 10:13:12PM +0200, Liam Girdwood wrote:
> Add a small API to configure McBSP smart idle modes
> to conserve power.

I'm sorry but I didn't get the point of this patch, as you didn't add any wider
description why you need to export this feature. Why do you think mcbsp clients
should be aware of these bit? Would it make sense to mask it behind other feature?
like the threshold size for instance..

> 
> Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
> ---
>  arch/arm/plat-omap/include/plat/mcbsp.h |   15 ++++
>  arch/arm/plat-omap/mcbsp.c              |  122 +++++++++++++++++++++++++++++++
>  2 files changed, 137 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
> index f8823f4..3f9fb71 100644
> --- a/arch/arm/plat-omap/include/plat/mcbsp.h
> +++ b/arch/arm/plat-omap/include/plat/mcbsp.h
> @@ -278,6 +278,15 @@
>  #define ENAWAKEUP		0x0004
>  #define SOFTRST			0x0002
>  
> +#define MCBSP_CLK_ACT_IOFF_POFF		0
> +#define MCBSP_CLK_ACT_ION_POFF		1
> +#define MCBSP_CLK_ACT_IOFF_PON		2
> +#define MCBSP_CLK_ACT_ION_PON			3
> +
> +#define MCBSP_IDLE_FORCE	0
> +#define MCBSP_IDLE_NONE		1
> +#define MCBSP_IDLE_SMART	2
> +
>  /********************** McBSP SSELCR bit definitions ***********************/
>  #define SIDETONEEN		0x0400
>  
> @@ -456,6 +465,7 @@ struct omap_mcbsp {
>  #ifdef CONFIG_ARCH_OMAP3
>  	struct omap_mcbsp_st_data *st_data;
>  	int dma_op_mode;
> +	int idle_mode;
>  	u16 max_tx_thres;
>  	u16 max_rx_thres;
>  #endif
> @@ -477,6 +487,11 @@ u16 omap_mcbsp_get_tx_delay(unsigned int id);
>  u16 omap_mcbsp_get_rx_delay(unsigned int id);
>  int omap_mcbsp_get_dma_op_mode(unsigned int id);
>  int omap_mcbsp_set_dma_op_mode(unsigned int id, unsigned int mode);
> +int omap_mcbsp_set_idle_smart(unsigned int id, unsigned int clk_activity,
> +		unsigned int wake);
> +int omap_mcbsp_set_idle_none(unsigned int id);
> +int omap_mcbsp_set_idle_force(unsigned int id);
> +int omap_mcbsp_get_idle_mode(unsigned int id);
>  #else
>  static inline void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
>  { }
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index cc2b73c..7785050 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -1743,6 +1743,128 @@ static inline void __devexit omap34xx_device_exit(struct omap_mcbsp *mcbsp)
>  			omap_st_remove(mcbsp);
>  	}
>  }
> +
> +/* assert standby requests when idle */
> +int omap_mcbsp_set_idle_smart(unsigned int id, unsigned int clk_activity,
> +		u32 wakeup)
> +{
> +	struct omap_mcbsp *mcbsp;
> +	u16 syscon;
> +	int ret = 0;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		printk(KERN_ERR "%s: Invalid id (%u)\n", __func__, id + 1);
> +		return -ENODEV;
> +	}
> +	mcbsp = id_to_mcbsp_ptr(id);
> +
> +	spin_lock_irq(&mcbsp->lock);
> +	if (!mcbsp->free) {
> +		ret = -EBUSY;
> +		goto unlock;
> +	}
> +
> +	syscon = MCBSP_READ(mcbsp, SYSCON) &
> +			~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
> +	MCBSP_WRITE(mcbsp, WAKEUPEN, wakeup);
> +	MCBSP_WRITE(mcbsp, SYSCON,
> +			syscon | SIDLEMODE(MCBSP_IDLE_SMART) |
> +			CLOCKACTIVITY(clk_activity) | ENAWAKEUP);
> +	mcbsp->idle_mode = MCBSP_IDLE_SMART;
> +
> +unlock:
> +	spin_unlock_irq(&mcbsp->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL(omap_mcbsp_set_idle_smart);
> +
> +/* never assert standby requests */
> +int omap_mcbsp_set_idle_none(unsigned int id)
> +{
> +	struct omap_mcbsp *mcbsp;
> +	u16 syscon;
> +	int ret = 0;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		printk(KERN_ERR "%s: Invalid id (%u)\n", __func__, id + 1);
> +		return -ENODEV;
> +	}
> +	mcbsp = id_to_mcbsp_ptr(id);
> +
> +	spin_lock_irq(&mcbsp->lock);
> +	if (!mcbsp->free) {
> +		ret = -EBUSY;
> +		goto unlock;
> +	}
> +
> +	syscon = MCBSP_READ(mcbsp, SYSCON) &
> +			~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
> +
> +	MCBSP_WRITE(mcbsp, SYSCON, syscon | SIDLEMODE(MCBSP_IDLE_NONE));
> +	MCBSP_WRITE(mcbsp, WAKEUPEN, 0);
> +	mcbsp->idle_mode = MCBSP_IDLE_NONE;
> +
> +unlock:
> +	spin_unlock_irq(&mcbsp->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL(omap_mcbsp_set_idle_none);
> +
> +/* unconditionally assert standby requests */
> +int omap_mcbsp_set_idle_force(unsigned int id)
> +{
> +	struct omap_mcbsp *mcbsp;
> +	u16 syscon;
> +	int ret = 0;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		printk(KERN_ERR "%s: Invalid id (%u)\n", __func__, id + 1);
> +		return -ENODEV;
> +	}
> +	mcbsp = id_to_mcbsp_ptr(id);
> +
> +	spin_lock_irq(&mcbsp->lock);
> +	if (!mcbsp->free) {
> +		ret = -EBUSY;
> +		goto unlock;
> +	}
> +
> +	syscon = MCBSP_READ(mcbsp, SYSCON) &
> +			~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
> +	/*
> +	 * HW bug workaround - If no_idle mode is taken, we need to
> +	 * go to smart_idle before going to always_idle, or the
> +	 * device will not hit retention anymore.
> +	 */
> +	syscon |= SIDLEMODE(MCBSP_IDLE_SMART);
> +	MCBSP_WRITE(mcbsp, SYSCON, syscon);
> +	syscon &= ~(SIDLEMODE(0x03));
> +
> +	MCBSP_WRITE(mcbsp, SYSCON, syscon | SIDLEMODE(MCBSP_IDLE_FORCE));
> +	MCBSP_WRITE(mcbsp, WAKEUPEN, 0);
> +	mcbsp->idle_mode = MCBSP_IDLE_FORCE;
> +
> +unlock:
> +	spin_unlock_irq(&mcbsp->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL(omap_mcbsp_set_idle_force);
> +
> +int omap_mcbsp_get_idle_mode(unsigned int id)
> +{
> +	struct omap_mcbsp *mcbsp;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		printk(KERN_ERR "%s: Invalid id (%u)\n", __func__, id + 1);
> +		return -ENODEV;
> +	}
> +	mcbsp = id_to_mcbsp_ptr(id);
> +
> +	return mcbsp->idle_mode;
> +}
> +EXPORT_SYMBOL(omap_mcbsp_get_idle_mode);
> +
> +
>  #else
>  static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp) {}
>  static inline void __devexit omap34xx_device_exit(struct omap_mcbsp *mcbsp) {}
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
