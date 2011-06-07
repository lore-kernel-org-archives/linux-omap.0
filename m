From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 19/27] OMAP: DSS2: Use PM runtime & HWMOD support
Date: Tue, 7 Jun 2011 13:37:34 +0200
Message-ID: <4DEE0D7E.6090309@ti.com>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>	 <1307095237-14805-20-git-send-email-tomi.valkeinen@ti.com>	 <871uzahnib.fsf@ti.com> <1307122985.2016.72.camel@deskari>	 <87hb86a5mm.fsf@ti.com> <1307174504.1777.24.camel@lappyti>	 <4DECCE90.6070201@ti.com> <1307365290.1910.39.camel@deskari>	 <4DECD2D7.6030207@ti.com> <1307366474.1910.44.camel@deskari>	 <4DECDA3A.7080808@ti.com> <1307368525.1910.50.camel@deskari>	 <4DECF215.5020505@ti.com> <1307429547.1858.10.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58022 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab1FGLhq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jun 2011 07:37:46 -0400
In-Reply-To: <1307429547.1858.10.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>

On 6/7/2011 8:52 AM, Valkeinen, Tomi wrote:
> On Mon, 2011-06-06 at 17:28 +0200, Cousson, Benoit wrote:
>
>> Before doing that, could you maybe just try something to make OMAP4
>> looks a little bit more like OMAP3?
>>
>> dss_fck ->  ick
>> dss_dss_fck ->  main_clk
>>
>> That should ensure that both modulemode and the PRCM fclk will be
>> managed by pm_runtime.
>
> I made the changes as you suggested, and while I haven't made the
> changes to omapdss yet to see if I can remove the dispc_runtime_get/put
> style function, I can boot up and start the dss.
>
> However, after booting up but before enabling the dss driver, I can see
> that the clock counts are:
>
> dss_tv_clk 0
> dss_sys_clk 0
> dss_fck 7
> dss_dss_clk 0
> dss_48mhz_clk 0
>
> So the modulemode is set for all dss hwmods? Isn't this exactly how it's
> _not_ meant to be, as modulemode should be set only after enabling the
> fck?

The issue is that there is only one modulemode for the whole DSS.
Potentially only the dss_hwmod should have it. But then you have to 
ensure that this device is enabled before any other DSS devices.

If you cannot do that at your level, we will have to set a hwmod 
dependency between DSS modules and the main DSS subsystem.
For the moment we do not have such HW dependencies.

Benoit

>
>   Tomi
>
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index b374cd0..d7d86b6 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -1133,7 +1133,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_dma_addrs[] = {
>   static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss = {
>   	.master		=&omap44xx_l3_main_2_hwmod,
>   	.slave		=&omap44xx_dss_hwmod,
> -	.clk		= "l3_div_ck",
> +	.clk		= "dss_fck",
>   	.addr		= omap44xx_dss_dma_addrs,
>   	.addr_cnt	= ARRAY_SIZE(omap44xx_dss_dma_addrs),
>   	.user		= OCP_USER_SDMA,
> @@ -1170,7 +1170,7 @@ static struct omap_hwmod_opt_clk dss_opt_clks[] = {
>   static struct omap_hwmod omap44xx_dss_hwmod = {
>   	.name		= "dss_core",
>   	.class		=&omap44xx_dss_hwmod_class,
> -	.main_clk	= "dss_fck",
> +	.main_clk	= "dss_dss_clk",
>   	.prcm = {
>   		.omap4 = {
>   			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
> @@ -1230,7 +1230,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_dispc_dma_addrs[] = {
>   static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dispc = {
>   	.master		=&omap44xx_l3_main_2_hwmod,
>   	.slave		=&omap44xx_dss_dispc_hwmod,
> -	.clk		= "l3_div_ck",
> +	.clk		= "dss_fck",
>   	.addr		= omap44xx_dss_dispc_dma_addrs,
>   	.addr_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_dma_addrs),
>   	.user		= OCP_USER_SDMA,
> @@ -1279,7 +1279,7 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_irqs),
>   	.sdma_reqs	= omap44xx_dss_dispc_sdma_reqs,
>   	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_sdma_reqs),
> -	.main_clk	= "dss_fck",
> +	.main_clk	= "dss_dss_clk",
>   	.prcm = {
>   		.omap4 = {
>   			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
> @@ -1335,7 +1335,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_dsi1_dma_addrs[] = {
>   static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dsi1 = {
>   	.master		=&omap44xx_l3_main_2_hwmod,
>   	.slave		=&omap44xx_dss_dsi1_hwmod,
> -	.clk		= "l3_div_ck",
> +	.clk		= "dss_fck",
>   	.addr		= omap44xx_dss_dsi1_dma_addrs,
>   	.addr_cnt	= ARRAY_SIZE(omap44xx_dss_dsi1_dma_addrs),
>   	.user		= OCP_USER_SDMA,
> @@ -1377,7 +1377,7 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dss_dsi1_irqs),
>   	.sdma_reqs	= omap44xx_dss_dsi1_sdma_reqs,
>   	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_dsi1_sdma_reqs),
> -	.main_clk	= "dss_fck",
> +	.main_clk	= "dss_dss_clk",
>   	.prcm = {
>   		.omap4 = {
>   			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
> @@ -1412,7 +1412,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_dsi2_dma_addrs[] = {
>   static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dsi2 = {
>   	.master		=&omap44xx_l3_main_2_hwmod,
>   	.slave		=&omap44xx_dss_dsi2_hwmod,
> -	.clk		= "l3_div_ck",
> +	.clk		= "dss_fck",
>   	.addr		= omap44xx_dss_dsi2_dma_addrs,
>   	.addr_cnt	= ARRAY_SIZE(omap44xx_dss_dsi2_dma_addrs),
>   	.user		= OCP_USER_SDMA,
> @@ -1449,7 +1449,7 @@ static struct omap_hwmod omap44xx_dss_dsi2_hwmod = {
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dss_dsi2_irqs),
>   	.sdma_reqs	= omap44xx_dss_dsi2_sdma_reqs,
>   	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_dsi2_sdma_reqs),
> -	.main_clk	= "dss_fck",
> +	.main_clk	= "dss_dss_clk",
>   	.prcm = {
>   		.omap4 = {
>   			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
> @@ -1502,7 +1502,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_hdmi_dma_addrs[] = {
>   static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_hdmi = {
>   	.master		=&omap44xx_l3_main_2_hwmod,
>   	.slave		=&omap44xx_dss_hdmi_hwmod,
> -	.clk		= "l3_div_ck",
> +	.clk		= "dss_fck",
>   	.addr		= omap44xx_dss_hdmi_dma_addrs,
>   	.addr_cnt	= ARRAY_SIZE(omap44xx_dss_hdmi_dma_addrs),
>   	.user		= OCP_USER_SDMA,
> @@ -1544,7 +1544,7 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dss_hdmi_irqs),
>   	.sdma_reqs	= omap44xx_dss_hdmi_sdma_reqs,
>   	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_hdmi_sdma_reqs),
> -	.main_clk	= "dss_fck",
> +	.main_clk	= "dss_dss_clk",
>   	.prcm = {
>   		.omap4 = {
>   			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
> @@ -1595,7 +1595,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_rfbi_dma_addrs[] = {
>   static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_rfbi = {
>   	.master		=&omap44xx_l3_main_2_hwmod,
>   	.slave		=&omap44xx_dss_rfbi_hwmod,
> -	.clk		= "l3_div_ck",
> +	.clk		= "dss_fck",
>   	.addr		= omap44xx_dss_rfbi_dma_addrs,
>   	.addr_cnt	= ARRAY_SIZE(omap44xx_dss_rfbi_dma_addrs),
>   	.user		= OCP_USER_SDMA,
> @@ -1634,7 +1634,7 @@ static struct omap_hwmod omap44xx_dss_rfbi_hwmod = {
>   	.class		=&omap44xx_rfbi_hwmod_class,
>   	.sdma_reqs	= omap44xx_dss_rfbi_sdma_reqs,
>   	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_rfbi_sdma_reqs),
> -	.main_clk	= "dss_fck",
> +	.main_clk	= "dss_dss_clk",
>   	.prcm = {
>   		.omap4 = {
>   			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
> @@ -1670,7 +1670,7 @@ static struct omap_hwmod_addr_space omap44xx_dss_venc_dma_addrs[] = {
>   static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_venc = {
>   	.master		=&omap44xx_l3_main_2_hwmod,
>   	.slave		=&omap44xx_dss_venc_hwmod,
> -	.clk		= "l3_div_ck",
> +	.clk		= "dss_fck",
>   	.addr		= omap44xx_dss_venc_dma_addrs,
>   	.addr_cnt	= ARRAY_SIZE(omap44xx_dss_venc_dma_addrs),
>   	.user		= OCP_USER_SDMA,
> @@ -1707,7 +1707,7 @@ static struct omap_hwmod_opt_clk venc_opt_clks[] = {
>   static struct omap_hwmod omap44xx_dss_venc_hwmod = {
>   	.name		= "dss_venc",
>   	.class		=&omap44xx_venc_hwmod_class,
> -	.main_clk	= "dss_fck",
> +	.main_clk	= "dss_dss_clk",
>   	.prcm = {
>   		.omap4 = {
>   			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
>
>

