From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 6/7] [RFC] OMAP: hwmod: SYSCONFIG register modification
 for MCBSP
Date: Fri, 8 Oct 2010 09:42:40 +0200
Message-ID: <4CAECB70.4030705@ti.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com> <1286296662-7639-6-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53723 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753763Ab0JHHmo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Oct 2010 03:42:44 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o987ghOa015260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 8 Oct 2010 02:42:43 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id o987ghiJ009904
	for <linux-omap@vger.kernel.org>; Fri, 8 Oct 2010 02:42:43 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o987ghcK025233
	for <linux-omap@vger.kernel.org>; Fri, 8 Oct 2010 02:42:43 -0500 (CDT)
In-Reply-To: <1286296662-7639-6-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "Basak, Partha" <p-basak2@ti.com>

Hi Kishon,

On 10/5/2010 6:37 PM, ABRAHAM, KISHON VIJAY wrote:
> MCBSP 2 and 3 in OMAP3 has sidetone feature which requires
> autoidle to be disabled before starting the sidetone. Also SYSCONFIG
> register has to be set with smart idle or no idle depending on the
> dma op mode (threshold or element sync). For doing these operations
> dynamically at runtime, hwmod API'S are used to modify SYSCONFIG register
> directly.

OK, it looks like we don't have the choice... But for the 
implementation, please discussed with Manju on that, He is doing the 
similar thing for the smartstandby issue on SDMA.

>
> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
> Signed-off-by: Charulatha V<charu@ti.com>
> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
> Cc: Partha Basak<p-basak2@ti.com>
> ---
>   arch/arm/plat-omap/mcbsp.c |   69 ++++++++++++++++++++++++++------------------
>   1 files changed, 41 insertions(+), 28 deletions(-)
>
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index c7c6a83..6b705e1 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -228,10 +228,21 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
>   EXPORT_SYMBOL(omap_mcbsp_config);
>
>   #ifdef CONFIG_ARCH_OMAP3
> +static struct omap_hwmod **find_hwmods_by_dev(struct device *dev)
> +{
> +	struct platform_device *pdev;
> +	struct omap_device *od;
> +	pdev = container_of(dev, struct platform_device, dev);
> +	od = container_of(pdev, struct omap_device, pdev);
> +	return od->hwmods;

Rule #1, don't touch oh in your code. The device should be the only 
interface.
If such API is needed, it should be in omap_device. But in your case, I 
don't thing it is needed.

> +}
> +
>   static void omap_st_on(struct omap_mcbsp *mcbsp)
>   {
>   	unsigned int w;
> +	struct omap_hwmod **oh;
>
> +	oh = find_hwmods_by_dev(mcbsp->dev);
>   	/*
>   	 * Sidetone uses McBSP ICLK - which must not idle when sidetones
>   	 * are enabled or sidetones start sounding ugly.
> @@ -244,8 +255,7 @@ static void omap_st_on(struct omap_mcbsp *mcbsp)
>   	w = MCBSP_READ(mcbsp, SSELCR);
>   	MCBSP_WRITE(mcbsp, SSELCR, w | SIDETONEEN);
>
> -	w = MCBSP_ST_READ(mcbsp, SYSCONFIG);
> -	MCBSP_ST_WRITE(mcbsp, SYSCONFIG, w&  ~(ST_AUTOIDLE));
> +	omap_hwmod_set_module_autoidle(oh[1], 0);

Don't use internal hwmod API. You have to create a similar omap_device API.
You don't have to select only one hwmod in this case, just change the 
sysconfig setting for all hwmod that belong to the omap_device, and it 
will be fine. It will avoid you to access one hwmod in particular.
This is the implementation that Manju is doing.

>
>   	/* Enable Sidetone from Sidetone Core */
>   	w = MCBSP_ST_READ(mcbsp, SSELCR);
> @@ -255,12 +265,14 @@ static void omap_st_on(struct omap_mcbsp *mcbsp)
>   static void omap_st_off(struct omap_mcbsp *mcbsp)
>   {
>   	unsigned int w;
> +	struct omap_hwmod **oh;
> +
> +	oh = find_hwmods_by_dev(mcbsp->dev);
>
>   	w = MCBSP_ST_READ(mcbsp, SSELCR);
>   	MCBSP_ST_WRITE(mcbsp, SSELCR, w&  ~(ST_SIDETONEEN));
>
> -	w = MCBSP_ST_READ(mcbsp, SYSCONFIG);
> -	MCBSP_ST_WRITE(mcbsp, SYSCONFIG, w | ST_AUTOIDLE);
> +	omap_hwmod_set_module_autoidle(oh[1], 1);
>
>   	w = MCBSP_READ(mcbsp, SSELCR);
>   	MCBSP_WRITE(mcbsp, SSELCR, w&  ~(SIDETONEEN));
> @@ -273,9 +285,11 @@ static void omap_st_off(struct omap_mcbsp *mcbsp)
>   static void omap_st_fir_write(struct omap_mcbsp *mcbsp, s16 *fir)
>   {
>   	u16 val, i;
> +	struct omap_hwmod **oh;
>
> -	val = MCBSP_ST_READ(mcbsp, SYSCONFIG);
> -	MCBSP_ST_WRITE(mcbsp, SYSCONFIG, val&  ~(ST_AUTOIDLE));
> +	oh = find_hwmods_by_dev(mcbsp->dev);
> +
> +	omap_hwmod_set_module_autoidle(oh[1], 0);
>
>   	val = MCBSP_ST_READ(mcbsp, SSELCR);
>
> @@ -303,9 +317,11 @@ static void omap_st_chgain(struct omap_mcbsp *mcbsp)
>   {
>   	u16 w;
>   	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
> +	struct omap_hwmod **oh;
> +
> +	oh = find_hwmods_by_dev(mcbsp->dev);
>
> -	w = MCBSP_ST_READ(mcbsp, SYSCONFIG);
> -	MCBSP_ST_WRITE(mcbsp, SYSCONFIG, w&  ~(ST_AUTOIDLE));
> +	omap_hwmod_set_module_autoidle(oh[1], 0);
>
>   	w = MCBSP_ST_READ(mcbsp, SSELCR);
>
> @@ -648,49 +664,46 @@ EXPORT_SYMBOL(omap_mcbsp_get_dma_op_mode);
>
>   static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
>   {
> +	struct omap_hwmod **oh;
> +
> +	oh = find_hwmods_by_dev(mcbsp->dev);
>   	/*
>   	 * Enable wakup behavior, smart idle and all wakeups
>   	 * REVISIT: some wakeups may be unnecessary
>   	 */
>   	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
> -		u16 syscon;
> -
> -		syscon = MCBSP_READ(mcbsp, SYSCON);
> -		syscon&= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
>
>   		if (mcbsp->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD) {
> -			syscon |= (ENAWAKEUP | SIDLEMODE(0x02) |
> -					CLOCKACTIVITY(0x02));
> -			MCBSP_WRITE(mcbsp, WAKEUPEN, XRDYEN | RRDYEN);
> +			omap_hwmod_enable_wakeup(oh[0]);

Thanks to the patch done by Rajendra, the wakeup should enable based on 
smartidle config.

> +			omap_hwmod_set_slave_idlemode(oh[0],
> +						HWMOD_IDLEMODE_SMART);
>   		} else {
> -			syscon |= SIDLEMODE(0x01);
> +			omap_hwmod_disable_wakeup(oh[0]);
> +			omap_hwmod_set_slave_idlemode(oh[0],
> +						HWMOD_IDLEMODE_NO);
>   		}
> -
> -		MCBSP_WRITE(mcbsp, SYSCON, syscon);
>   	}
>   }
>
>   static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp)
>   {
> +	struct omap_hwmod **oh;
> +
> +	oh = find_hwmods_by_dev(mcbsp->dev);
>   	/*
>   	 * Disable wakup behavior, smart idle and all wakeups
>   	 */
>   	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {

Please try to avoid this cpu_is_xxx checks. You should identified the IP 
version if possible or add some SW rev, features or errata in hwmod and 
retrieve them during omap_device_build.

> -		u16 syscon;
> -
> -		syscon = MCBSP_READ(mcbsp, SYSCON);
> -		syscon&= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
>   		/*
>   		 * HW bug workaround - If no_idle mode is taken, we need to
>   		 * go to smart_idle before going to always_idle, or the
>   		 * device will not hit retention anymore.
>   		 */

What is that other bug? The changelog does not mention it?

> -		syscon |= SIDLEMODE(0x02);
> -		MCBSP_WRITE(mcbsp, SYSCON, syscon);
> -
> -		syscon&= ~(SIDLEMODE(0x03));
> -		MCBSP_WRITE(mcbsp, SYSCON, syscon);
> -
> +		omap_hwmod_disable_wakeup(oh[0]);
> +		omap_hwmod_set_slave_idlemode(oh[0],
> +					HWMOD_IDLEMODE_SMART);
> +		omap_hwmod_set_slave_idlemode(oh[0],
> +					HWMOD_IDLEMODE_FORCE);
>   		MCBSP_WRITE(mcbsp, WAKEUPEN, 0);
>   	}
>   }

Regards,
Benoit
