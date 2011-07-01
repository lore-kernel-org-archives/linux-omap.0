From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [RFC 11/12] omap: mcbsp: Remove conditional compilation for OMAP3
Date: Fri, 1 Jul 2011 16:30:09 +0530
Message-ID: <CA+HSevqQhPP9YD=m_1Z7E=44hY0i4FFSoq7C1uP-aTsNXcMsiw@mail.gmail.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com> <1309510356-27147-12-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:40619 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754693Ab1GALAv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 07:00:51 -0400
Received: by mail-qy0-f176.google.com with SMTP id 4so1788194qyk.7
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 04:00:49 -0700 (PDT)
In-Reply-To: <1309510356-27147-12-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Peter Ujfalusi <peter.ujfalusi@ti.com>

Jarkko,

On Fri, Jul 1, 2011 at 14:22, Jarkko Nikula <jhnikula@gmail.com> wrote:
> Although this increases the build size a little for !OMAP3 builds it =
makes
> the code one step more generic. For instance the threshold based DMA
> transfers seems to be possible with OMAP4 too from quick look of the =
TRM.
>
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
> =A0arch/arm/plat-omap/include/plat/mcbsp.h | =A0 35 ++++-------------=
-------------
> =A0arch/arm/plat-omap/mcbsp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 13 ---=
--------
> =A02 files changed, 5 insertions(+), 43 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-=
omap/include/plat/mcbsp.h
> index 2a7e8d5..720461c 100644
> --- a/arch/arm/plat-omap/include/plat/mcbsp.h
> +++ b/arch/arm/plat-omap/include/plat/mcbsp.h
> @@ -26,9 +26,6 @@
>
> =A0#include <linux/spinlock.h>
>
> -#include <mach/hardware.h>
> -#include <plat/clock.h>
> -
> =A0/* macro for building platform_device for McBSP ports */
> =A0#define OMAP_MCBSP_PLATFORM_DEVICE(port_nr) =A0 =A0 =A0 =A0 =A0 =A0=
\
> =A0static struct platform_device omap_mcbsp##port_nr =3D { =A0\
> @@ -314,11 +311,11 @@ struct omap_mcbsp_platform_data {
> =A0 =A0 =A0 =A0u8 dma_rx_sync, dma_tx_sync;
> =A0 =A0 =A0 =A0u16 rx_irq, tx_irq;
> =A0 =A0 =A0 =A0struct omap_mcbsp_ops *ops;
> -#ifdef CONFIG_ARCH_OMAP3
> +
> =A0 =A0 =A0 =A0/* Sidetone block for McBSP 2 and 3 */
> =A0 =A0 =A0 =A0unsigned long phys_base_st;
> =A0 =A0 =A0 =A0int (*enable_st_clock)(unsigned int, bool);
> -#endif
> +
> =A0 =A0 =A0 =A0u16 buffer_size;
> =A0 =A0 =A0 =A0unsigned int mcbsp_config_type;
> =A0 =A0 =A0 =A0u8 reg_size;
> @@ -354,12 +351,12 @@ struct omap_mcbsp {
> =A0 =A0 =A0 =A0spinlock_t lock;
> =A0 =A0 =A0 =A0struct omap_mcbsp_platform_data *pdata;
> =A0 =A0 =A0 =A0struct clk *fclk;
> -#ifdef CONFIG_ARCH_OMAP3
> +
> =A0 =A0 =A0 =A0struct omap_mcbsp_st_data *st_data;
> =A0 =A0 =A0 =A0int dma_op_mode;
> =A0 =A0 =A0 =A0u16 max_tx_thres;
> =A0 =A0 =A0 =A0u16 max_rx_thres;
> -#endif
> +
> =A0 =A0 =A0 =A0void *reg_cache;
> =A0 =A0 =A0 =A0unsigned int mcbsp_config_type;
> =A0};
> @@ -380,7 +377,6 @@ extern int omap_mcbsp_count, omap_mcbsp_cache_siz=
e;
>
> =A0int omap_mcbsp_init(void);
> =A0void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_re=
g_cfg * config);
> -#ifdef CONFIG_ARCH_OMAP3
> =A0void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold);
> =A0void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold);
> =A0u16 omap_mcbsp_get_max_tx_threshold(unsigned int id);
> @@ -389,18 +385,7 @@ u16 omap_mcbsp_get_fifo_size(unsigned int id);
> =A0u16 omap_mcbsp_get_tx_delay(unsigned int id);
> =A0u16 omap_mcbsp_get_rx_delay(unsigned int id);
> =A0int omap_mcbsp_get_dma_op_mode(unsigned int id);
> -#else
> -static inline void omap_mcbsp_set_tx_threshold(unsigned int id, u16 =
threshold)
> -{ }
> -static inline void omap_mcbsp_set_rx_threshold(unsigned int id, u16 =
threshold)
> -{ }
> -static inline u16 omap_mcbsp_get_max_tx_threshold(unsigned int id) {=
 return 0; }
> -static inline u16 omap_mcbsp_get_max_rx_threshold(unsigned int id) {=
 return 0; }
> -static inline u16 omap_mcbsp_get_fifo_size(unsigned int id) { return=
 0; }
> -static inline u16 omap_mcbsp_get_tx_delay(unsigned int id) { return =
0; }
> -static inline u16 omap_mcbsp_get_rx_delay(unsigned int id) { return =
0; }
> -static inline int omap_mcbsp_get_dma_op_mode(unsigned int id) { retu=
rn 0; }
> -#endif
> +
> =A0int omap_mcbsp_request(unsigned int id);
> =A0void omap_mcbsp_free(unsigned int id);
> =A0void omap_mcbsp_start(unsigned int id, int tx, int rx);
> @@ -416,21 +401,11 @@ void omap2_mcbsp1_mux_fsr_src(u8 mux);
> =A0int omap_mcbsp_dma_ch_params(unsigned int id, unsigned int stream)=
;
> =A0int omap_mcbsp_dma_reg_params(unsigned int id, unsigned int stream=
);
>
> -#ifdef CONFIG_ARCH_OMAP3
> =A0/* Sidetone specific API */
> =A0int omap_st_set_chgain(unsigned int id, int channel, s16 chgain);
> =A0int omap_st_get_chgain(unsigned int id, int channel, s16 *chgain);
> =A0int omap_st_enable(unsigned int id);
> =A0int omap_st_disable(unsigned int id);
> =A0int omap_st_is_enabled(unsigned int id);
> -#else
> -static inline int omap_st_set_chgain(unsigned int id, int channel,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0s16 chgain) { return 0; }
> -static inline int omap_st_get_chgain(unsigned int id, int channel,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0s16 *chgain) { return 0; }
> -static inline int omap_st_enable(unsigned int id) { return 0; }
> -static inline int omap_st_disable(unsigned int id) { return 0; }
> -static inline int omap_st_is_enabled(unsigned int id) { =A0return 0;=
 }
> -#endif
>
> =A0#endif
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index 1a7cfb3..d565b36 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -63,7 +63,6 @@ static int omap_mcbsp_read(struct omap_mcbsp *mcbsp=
, u16 reg, bool from_cache)
> =A0 =A0 =A0 =A0}
> =A0}
>
> -#ifdef CONFIG_ARCH_OMAP3

Are there any plans to move the functions  omap_mcbsp_st_*
to mach-omap2/* as they are specific to OMAP3 only?

-V Charulatha

> =A0static void omap_mcbsp_st_write(struct omap_mcbsp *mcbsp, u16 reg,=
 u32 val)
> =A0{
> =A0 =A0 =A0 =A0__raw_writel(val, mcbsp->st_data->io_base_st + reg);
> @@ -73,7 +72,6 @@ static int omap_mcbsp_st_read(struct omap_mcbsp *mc=
bsp, u16 reg)
> =A0{
> =A0 =A0 =A0 =A0return __raw_readl(mcbsp->st_data->io_base_st + reg);
> =A0}
> -#endif
>
> =A0#define MCBSP_READ(mcbsp, reg) \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_mcbsp_read(mcbsp, OMAP_MCBSP_REG_=
##reg, 0)
> @@ -258,7 +256,6 @@ int omap_mcbsp_dma_reg_params(unsigned int id, un=
signed int stream)
> =A0}
> =A0EXPORT_SYMBOL(omap_mcbsp_dma_reg_params);
>
> -#ifdef CONFIG_ARCH_OMAP3
> =A0static void omap_st_on(struct omap_mcbsp *mcbsp)
> =A0{
> =A0 =A0 =A0 =A0unsigned int w;
> @@ -657,11 +654,6 @@ int omap_mcbsp_get_dma_op_mode(unsigned int id)
> =A0}
> =A0EXPORT_SYMBOL(omap_mcbsp_get_dma_op_mode);
>
> -#else
> -static inline void omap_st_start(struct omap_mcbsp *mcbsp) {}
> -static inline void omap_st_stop(struct omap_mcbsp *mcbsp) {}
> -#endif
> -
> =A0int omap_mcbsp_request(unsigned int id)
> =A0{
> =A0 =A0 =A0 =A0struct omap_mcbsp *mcbsp;
> @@ -935,7 +927,6 @@ void omap2_mcbsp1_mux_fsr_src(u8 mux)
> =A0}
> =A0#endif
>
> -#ifdef CONFIG_ARCH_OMAP3
> =A0#define max_thres(m) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mcbsp->p=
data->buffer_size)
> =A0#define valid_threshold(m, val) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((v=
al) <=3D max_thres(m))
> =A0#define THRESHOLD_PROP_BUILDER(prop) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> @@ -1205,10 +1196,6 @@ static inline void __devexit omap34xx_device_e=
xit(struct omap_mcbsp *mcbsp)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_st_remove(mcbsp);
> =A0 =A0 =A0 =A0}
> =A0}
> -#else
> -static inline void __devinit omap34xx_device_init(struct omap_mcbsp =
*mcbsp) {}
> -static inline void __devexit omap34xx_device_exit(struct omap_mcbsp =
*mcbsp) {}
> -#endif /* CONFIG_ARCH_OMAP3 */
>
> =A0/*
> =A0* McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
