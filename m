From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/4] OMAP: mcbsp - add smart idle configuration API
Date: Tue, 18 May 2010 15:42:52 -0500
Message-ID: <4BF2FBCC.8070904@ti.com>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk> <1274213594-26554-3-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35683 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753560Ab0ERUnI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 May 2010 16:43:08 -0400
In-Reply-To: <1274213594-26554-3-git-send-email-lrg@slimlogic.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>

Liam Girdwood had written, on 05/18/2010 03:13 PM, the following:
> Add a small API to configure McBSP smart idle modes
> to conserve power.
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

Just a curious question - how does this work with hwmod infrastructure?

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


-- 
Regards,
Nishanth Menon
