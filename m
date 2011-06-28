From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v3 8/8] OMAP2+: hwmod: Follow the recommended PRCM module
 enable sequence
Date: Tue, 28 Jun 2011 15:03:32 -0700
Message-ID: <4E0A4FB4.70404@ti.com>
References: <1309191103-8817-1-git-send-email-b-cousson@ti.com>	<1309191103-8817-9-git-send-email-b-cousson@ti.com> <87iprq4xx2.fsf@ti.com> <4E09D19E.2020409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:55469 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752513Ab1F1WDj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Jun 2011 18:03:39 -0400
Received: by mail-yx0-f171.google.com with SMTP id 35so352010yxh.2
        for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 15:03:36 -0700 (PDT)
In-Reply-To: <4E09D19E.2020409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "toddpoynor@google.com" <toddpoynor@google.com>

On 6/28/2011 6:05 AM, Cousson, Benoit wrote:
> Hi Kevin,
>
> On 6/28/2011 2:11 AM, Hilman, Kevin wrote:
>> Benoit Cousson<b-cousson@ti.com>   writes:
>>
>>> From: Rajendra Nayak<rnayak@ti.com>
>>>
>>> On OMAP4, the PRCM recommended sequence for enabling
>>> a module after power-on-reset is:
>>> -1- Force clkdm to SW_WKUP
>>> -2- Enabling the clocks
>>> -3- Configure desired module mode to "enable" or "auto"
>>> -4- Wait for the desired module idle status to be FUNC
>>> -5- Program clkdm in HW_AUTO(if supported)
>>>
>>> This sequence applies to all older OMAPs' as well,
>>> however since they use autodeps, it makes sure that
>>> no clkdm is in IDLE, and hence not requiring a force
>>> SW_WKUP when a module is being enabled.
>>>
>>> OMAP4 does not need to support autodeps, because
>>> of the dyanamic dependency feature, wherein
>>> the HW takes care of waking up a clockdomain from
>>> idle and hence the module, whenever an interconnect
>>> access happens to the given module.
>>>
>>> Implementing the sequence for OMAP4 requires
>>> the clockdomain handling that is currently done in
>>> clock framework to be done as part of hwmod framework
>>> since the step -4- above to "Wait for the desired
>>> module idle status to be FUNC" is done as part of
>>> hwmod framework.
>>>
>>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>>> [b-cousson@ti.com: Adapt it to the new clkdm hwmod attribute and API]
>>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>>> Cc: Paul Walmsley<paul@pwsan.com>
>>
>> [...]
>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>>> index 3eef106..3538805 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>> @@ -1360,6 +1360,7 @@ static int _reset(struct omap_hwmod *oh)
>>>    static int _enable(struct omap_hwmod *oh)
>>>    {
>>>    	int r;
>>> +	int hwsup = 0;
>>>
>>>    	if (oh->_state != _HWMOD_STATE_INITIALIZED&&
>>>    	oh->_state != _HWMOD_STATE_IDLE&&
>>> @@ -1378,6 +1379,19 @@ static int _enable(struct omap_hwmod *oh)
>>>    		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
>>>
>>>    	_add_initiator_dep(oh, mpu_oh);
>>> +
>>> +	/*
>>> +	 * A clockdomain must be in SW_SUP before enabling completely the
>>> +	 * module. The clockdomain can be set in HW_AUTO only when the module
>>> +	 * become ready.
>>> +	 */
>>> +	hwsup = clkdm_allows_idle(oh->clkdm);
>>> +	r = clkdm_hwmod_enable(oh->clkdm, oh);
>>> +	if (r) {
>>> +		WARN(1, "omap_hwmod: %s: could not enable clockdomain %s: %d\n",
>>> +		     oh->name, oh->clkdm->name, r);
>>> +		return r;
>>> +	}
>>
>> If oh->clkdm == NULL (as it is on OMAP3 since the hwmod data has no
>> clkdms yet), this hangs trying to dereference oh->clkdm->name.
>>
>> Simple fix below, but probably better is to not call any of these
>> functions if oh->clkdm == NULL, otherwise this is very noisy on OMAP3
>> since that WARN is printed for every hwmod.
>
> I can as well prevent the clkdm_hwmod_enable function to return any errors in case of omap2&  omap3...

Is'nt it best to do this..

if (oh->clkdm)
	hwsup = clkdm_allows_idle(oh->clkdm);
	r = clkdm_hwmod_enable(oh->clkdm, oh);
	...

My original patch infact had this check :-)

>
>> Is anyone planning to add the clkdms to OMAP3 hwmod data?
>
> Euh, I'm not sure:-) So I've just updated the OMAP3.
> I guess the next question will be: Is anyone planning to add the clkdms to OMAP2 hwmod data?
>
> Regards,
> Benoit
>
> ---
>  From 14916037799ed0d516c8c335f861d2d5248d1c33 Mon Sep 17 00:00:00 2001
> From: Benoit Cousson<b-cousson@ti.com>
> Date: Tue, 28 Jun 2011 14:53:28 +0200
> Subject: [PATCH] OMAP3: hwmod data: Add clock domain attribute
>
> Add a clkdm_name attribute to provide this information per hwmod.
>
> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> Cc: Rajendra Nayak<rnayak@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   60 ++++++++++++++++++++++++++++
>   1 files changed, 60 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index d0c82de..91e75cf 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -149,6 +149,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l3_main_masters[] = {
>   /* L3 */
>   static struct omap_hwmod omap3xxx_l3_main_hwmod = {
>   	.name		= "l3_main",
> +	.clkdm_name	= "core_l3_clkdm",
>   	.class		=&l3_hwmod_class,
>   	.mpu_irqs       = omap3xxx_l3_main_irqs,
>   	.mpu_irqs_cnt   = ARRAY_SIZE(omap3xxx_l3_main_irqs),
> @@ -495,6 +496,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
>   /* L4 CORE */
>   static struct omap_hwmod omap3xxx_l4_core_hwmod = {
>   	.name		= "l4_core",
> +	.clkdm_name	= "core_l4_clkdm",
>   	.class		=&l4_hwmod_class,
>   	.slaves		= omap3xxx_l4_core_slaves,
>   	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l4_core_slaves),
> @@ -510,6 +512,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_per_slaves[] = {
>   /* L4 PER */
>   static struct omap_hwmod omap3xxx_l4_per_hwmod = {
>   	.name		= "l4_per",
> +	.clkdm_name	= "per_clkdm",
>   	.class		=&l4_hwmod_class,
>   	.slaves		= omap3xxx_l4_per_slaves,
>   	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l4_per_slaves),
> @@ -525,6 +528,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup_slaves[] = {
>   /* L4 WKUP */
>   static struct omap_hwmod omap3xxx_l4_wkup_hwmod = {
>   	.name		= "l4_wkup",
> +	.clkdm_name	= "wkup_clkdm",
>   	.class		=&l4_hwmod_class,
>   	.slaves		= omap3xxx_l4_wkup_slaves,
>   	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l4_wkup_slaves),
> @@ -540,6 +544,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_mpu_masters[] = {
>   /* MPU */
>   static struct omap_hwmod omap3xxx_mpu_hwmod = {
>   	.name		= "mpu",
> +	.clkdm_name	= "mpu_clkdm",
>   	.class		=&mpu_hwmod_class,
>   	.main_clk	= "arm_fck",
>   	.masters	= omap3xxx_mpu_masters,
> @@ -569,6 +574,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_iva_masters[] = {
>
>   static struct omap_hwmod omap3xxx_iva_hwmod = {
>   	.name		= "iva",
> +	.clkdm_name	= "iva2_clkdm",
>   	.class		=&iva_hwmod_class,
>   	.masters	= omap3xxx_iva_masters,
>   	.masters_cnt	= ARRAY_SIZE(omap3xxx_iva_masters),
> @@ -641,6 +647,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer1_slaves[] = {
>   /* timer1 hwmod */
>   static struct omap_hwmod omap3xxx_timer1_hwmod = {
>   	.name		= "timer1",
> +	.clkdm_name	= "wkup_clkdm",
>   	.mpu_irqs	= omap3xxx_timer1_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer1_mpu_irqs),
>   	.main_clk	= "gpt1_fck",
> @@ -691,6 +698,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer2_slaves[] = {
>   /* timer2 hwmod */
>   static struct omap_hwmod omap3xxx_timer2_hwmod = {
>   	.name		= "timer2",
> +	.clkdm_name	= "per_clkdm",
>   	.mpu_irqs	= omap3xxx_timer2_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer2_mpu_irqs),
>   	.main_clk	= "gpt2_fck",
> @@ -741,6 +749,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer3_slaves[] = {
>   /* timer3 hwmod */
>   static struct omap_hwmod omap3xxx_timer3_hwmod = {
>   	.name		= "timer3",
> +	.clkdm_name	= "per_clkdm",
>   	.mpu_irqs	= omap3xxx_timer3_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer3_mpu_irqs),
>   	.main_clk	= "gpt3_fck",
> @@ -791,6 +800,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer4_slaves[] = {
>   /* timer4 hwmod */
>   static struct omap_hwmod omap3xxx_timer4_hwmod = {
>   	.name		= "timer4",
> +	.clkdm_name	= "per_clkdm",
>   	.mpu_irqs	= omap3xxx_timer4_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer4_mpu_irqs),
>   	.main_clk	= "gpt4_fck",
> @@ -841,6 +851,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer5_slaves[] = {
>   /* timer5 hwmod */
>   static struct omap_hwmod omap3xxx_timer5_hwmod = {
>   	.name		= "timer5",
> +	.clkdm_name	= "per_clkdm",
>   	.mpu_irqs	= omap3xxx_timer5_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer5_mpu_irqs),
>   	.main_clk	= "gpt5_fck",
> @@ -891,6 +902,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer6_slaves[] = {
>   /* timer6 hwmod */
>   static struct omap_hwmod omap3xxx_timer6_hwmod = {
>   	.name		= "timer6",
> +	.clkdm_name	= "per_clkdm",
>   	.mpu_irqs	= omap3xxx_timer6_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer6_mpu_irqs),
>   	.main_clk	= "gpt6_fck",
> @@ -941,6 +953,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer7_slaves[] = {
>   /* timer7 hwmod */
>   static struct omap_hwmod omap3xxx_timer7_hwmod = {
>   	.name		= "timer7",
> +	.clkdm_name	= "per_clkdm",
>   	.mpu_irqs	= omap3xxx_timer7_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer7_mpu_irqs),
>   	.main_clk	= "gpt7_fck",
> @@ -991,6 +1004,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer8_slaves[] = {
>   /* timer8 hwmod */
>   static struct omap_hwmod omap3xxx_timer8_hwmod = {
>   	.name		= "timer8",
> +	.clkdm_name	= "per_clkdm",
>   	.mpu_irqs	= omap3xxx_timer8_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer8_mpu_irqs),
>   	.main_clk	= "gpt8_fck",
> @@ -1041,6 +1055,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer9_slaves[] = {
>   /* timer9 hwmod */
>   static struct omap_hwmod omap3xxx_timer9_hwmod = {
>   	.name		= "timer9",
> +	.clkdm_name	= "per_clkdm",
>   	.mpu_irqs	= omap3xxx_timer9_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer9_mpu_irqs),
>   	.main_clk	= "gpt9_fck",
> @@ -1091,6 +1106,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer10_slaves[] = {
>   /* timer10 hwmod */
>   static struct omap_hwmod omap3xxx_timer10_hwmod = {
>   	.name		= "timer10",
> +	.clkdm_name	= "core_l4_clkdm",
>   	.mpu_irqs	= omap3xxx_timer10_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer10_mpu_irqs),
>   	.main_clk	= "gpt10_fck",
> @@ -1141,6 +1157,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer11_slaves[] = {
>   /* timer11 hwmod */
>   static struct omap_hwmod omap3xxx_timer11_hwmod = {
>   	.name		= "timer11",
> +	.clkdm_name	= "core_l4_clkdm",
>   	.mpu_irqs	= omap3xxx_timer11_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer11_mpu_irqs),
>   	.main_clk	= "gpt11_fck",
> @@ -1191,6 +1208,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer12_slaves[] = {
>   /* timer12 hwmod */
>   static struct omap_hwmod omap3xxx_timer12_hwmod = {
>   	.name		= "timer12",
> +	.clkdm_name	= "wkup_clkdm",
>   	.mpu_irqs	= omap3xxx_timer12_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer12_mpu_irqs),
>   	.main_clk	= "gpt12_fck",
> @@ -1271,6 +1289,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_wd_timer2_slaves[] = {
>   static struct omap_hwmod omap3xxx_wd_timer2_hwmod = {
>   	.name		= "wd_timer2",
>   	.class		=&omap3xxx_wd_timer_hwmod_class,
> +	.clkdm_name	= "wkup_clkdm",
>   	.main_clk	= "wdt2_fck",
>   	.prcm		= {
>   		.omap2 = {
> @@ -1326,6 +1345,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_uart1_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_uart1_hwmod = {
>   	.name		= "uart1",
> +	.clkdm_name	= "core_l4_clkdm",
>   	.mpu_irqs	= uart1_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(uart1_mpu_irqs),
>   	.sdma_reqs	= uart1_sdma_reqs,
> @@ -1363,6 +1383,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_uart2_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_uart2_hwmod = {
>   	.name		= "uart2",
> +	.clkdm_name	= "core_l4_clkdm",
>   	.mpu_irqs	= uart2_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(uart2_mpu_irqs),
>   	.sdma_reqs	= uart2_sdma_reqs,
> @@ -1400,6 +1421,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_uart3_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_uart3_hwmod = {
>   	.name		= "uart3",
> +	.clkdm_name	= "per_clkdm",
>   	.mpu_irqs	= uart3_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(uart3_mpu_irqs),
>   	.sdma_reqs	= uart3_sdma_reqs,
> @@ -1437,6 +1459,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_uart4_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_uart4_hwmod = {
>   	.name		= "uart4",
> +	.clkdm_name	= "per_clkdm",
>   	.mpu_irqs	= uart4_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(uart4_mpu_irqs),
>   	.sdma_reqs	= uart4_sdma_reqs,
> @@ -1549,6 +1572,7 @@ static struct omap_hwmod_opt_clk dss_opt_clks[] = {
>
>   static struct omap_hwmod omap3430es1_dss_core_hwmod = {
>   	.name		= "dss_core",
> +	.clkdm_name	= "dss_clkdm",
>   	.class		=&omap3xxx_dss_hwmod_class,
>   	.main_clk	= "dss1_alwon_fck", /* instead of dss_fck */
>   	.sdma_reqs	= omap3xxx_dss_sdma_chs,
> @@ -1575,6 +1599,7 @@ static struct omap_hwmod omap3430es1_dss_core_hwmod = {
>
>   static struct omap_hwmod omap3xxx_dss_core_hwmod = {
>   	.name		= "dss_core",
> +	.clkdm_name	= "dss_clkdm",
>   	.class		=&omap3xxx_dss_hwmod_class,
>   	.main_clk	= "dss1_alwon_fck", /* instead of dss_fck */
>   	.sdma_reqs	= omap3xxx_dss_sdma_chs,
> @@ -1658,6 +1683,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_dispc_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_dss_dispc_hwmod = {
>   	.name		= "dss_dispc",
> +	.clkdm_name	= "dss_clkdm",
>   	.class		=&omap3xxx_dispc_hwmod_class,
>   	.mpu_irqs	= omap3xxx_dispc_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_dispc_irqs),
> @@ -1722,6 +1748,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_dsi1_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_dss_dsi1_hwmod = {
>   	.name		= "dss_dsi1",
> +	.clkdm_name	= "dss_clkdm",
>   	.class		=&omap3xxx_dsi_hwmod_class,
>   	.mpu_irqs	= omap3xxx_dsi1_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_dsi1_irqs),
> @@ -1793,6 +1820,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_rfbi_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_dss_rfbi_hwmod = {
>   	.name		= "dss_rfbi",
> +	.clkdm_name	= "dss_clkdm",
>   	.class		=&omap3xxx_rfbi_hwmod_class,
>   	.main_clk	= "dss1_alwon_fck",
>   	.prcm		= {
> @@ -1853,6 +1881,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_venc_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
>   	.name		= "dss_venc",
> +	.clkdm_name	= "dss_clkdm",
>   	.class		=&omap3xxx_venc_hwmod_class,
>   	.main_clk	= "dss1_alwon_fck",
>   	.prcm		= {
> @@ -1891,6 +1920,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_i2c1_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_i2c1_hwmod = {
>   	.name		= "i2c1",
> +	.clkdm_name	= "core_l4_clkdm",
>   	.mpu_irqs	= i2c1_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(i2c1_mpu_irqs),
>   	.sdma_reqs	= i2c1_sdma_reqs,
> @@ -1933,6 +1963,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_i2c2_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_i2c2_hwmod = {
>   	.name		= "i2c2",
> +	.clkdm_name	= "core_l4_clkdm",
>   	.mpu_irqs	= i2c2_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(i2c2_mpu_irqs),
>   	.sdma_reqs	= i2c2_sdma_reqs,
> @@ -1975,6 +2006,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_i2c3_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_i2c3_hwmod = {
>   	.name		= "i2c3",
> +	.clkdm_name	= "core_l4_clkdm",
>   	.mpu_irqs	= i2c3_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(i2c3_mpu_irqs),
>   	.sdma_reqs	= i2c3_sdma_reqs,
> @@ -2141,6 +2173,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio1_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_gpio1_hwmod = {
>   	.name		= "gpio1",
> +	.clkdm_name	= "wkup_clkdm",
>   	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
>   	.mpu_irqs	= omap3xxx_gpio1_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio1_irqs),
> @@ -2178,6 +2211,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio2_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_gpio2_hwmod = {
>   	.name		= "gpio2",
> +	.clkdm_name	= "per_clkdm",
>   	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
>   	.mpu_irqs	= omap3xxx_gpio2_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio2_irqs),
> @@ -2215,6 +2249,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio3_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_gpio3_hwmod = {
>   	.name		= "gpio3",
> +	.clkdm_name	= "per_clkdm",
>   	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
>   	.mpu_irqs	= omap3xxx_gpio3_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio3_irqs),
> @@ -2252,6 +2287,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio4_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_gpio4_hwmod = {
>   	.name		= "gpio4",
> +	.clkdm_name	= "per_clkdm",
>   	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
>   	.mpu_irqs	= omap3xxx_gpio4_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio4_irqs),
> @@ -2289,6 +2325,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio5_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_gpio5_hwmod = {
>   	.name		= "gpio5",
> +	.clkdm_name	= "per_clkdm",
>   	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
>   	.mpu_irqs	= omap3xxx_gpio5_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio5_irqs),
> @@ -2326,6 +2363,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_gpio6_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_gpio6_hwmod = {
>   	.name		= "gpio6",
> +	.clkdm_name	= "per_clkdm",
>   	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
>   	.mpu_irqs	= omap3xxx_gpio6_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio6_irqs),
> @@ -2419,6 +2457,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_dma_system_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_dma_system_hwmod = {
>   	.name		= "dma",
> +	.clkdm_name	= "core_l3_clkdm",
>   	.class		=&omap3xxx_dma_hwmod_class,
>   	.mpu_irqs	= omap3xxx_dma_system_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_dma_system_irqs),
> @@ -2499,6 +2538,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_mcbsp1_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_mcbsp1_hwmod = {
>   	.name		= "mcbsp1",
> +	.clkdm_name	= "core_l4_clkdm",
>   	.class		=&omap3xxx_mcbsp_hwmod_class,
>   	.mpu_irqs	= omap3xxx_mcbsp1_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp1_irqs),
> @@ -2561,6 +2601,7 @@ static struct omap_mcbsp_dev_attr omap34xx_mcbsp2_dev_attr = {
>
>   static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
>   	.name		= "mcbsp2",
> +	.clkdm_name	= "per_clkdm",
>   	.class		=&omap3xxx_mcbsp_hwmod_class,
>   	.mpu_irqs	= omap3xxx_mcbsp2_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp2_irqs),
> @@ -2624,6 +2665,7 @@ static struct omap_mcbsp_dev_attr omap34xx_mcbsp3_dev_attr = {
>
>   static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
>   	.name		= "mcbsp3",
> +	.clkdm_name	= "per_clkdm",
>   	.class		=&omap3xxx_mcbsp_hwmod_class,
>   	.mpu_irqs	= omap3xxx_mcbsp3_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp3_irqs),
> @@ -2683,6 +2725,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_mcbsp4_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_mcbsp4_hwmod = {
>   	.name		= "mcbsp4",
> +	.clkdm_name	= "per_clkdm",
>   	.class		=&omap3xxx_mcbsp_hwmod_class,
>   	.mpu_irqs	= omap3xxx_mcbsp4_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp4_irqs),
> @@ -2741,6 +2784,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_mcbsp5_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_mcbsp5_hwmod = {
>   	.name		= "mcbsp5",
> +	.clkdm_name	= "core_l4_clkdm",
>   	.class		=&omap3xxx_mcbsp_hwmod_class,
>   	.mpu_irqs	= omap3xxx_mcbsp5_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp5_irqs),
> @@ -2804,6 +2848,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_mcbsp2_sidetone_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod = {
>   	.name		= "mcbsp2_sidetone",
> +	.clkdm_name	= "per_clkdm",
>   	.class		=&omap3xxx_mcbsp_sidetone_hwmod_class,
>   	.mpu_irqs	= omap3xxx_mcbsp2_sidetone_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp2_sidetone_irqs),
> @@ -2853,6 +2898,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_mcbsp3_sidetone_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_mcbsp3_sidetone_hwmod = {
>   	.name		= "mcbsp3_sidetone",
> +	.clkdm_name	= "per_clkdm",
>   	.class		=&omap3xxx_mcbsp_sidetone_hwmod_class,
>   	.mpu_irqs	= omap3xxx_mcbsp3_sidetone_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp3_sidetone_irqs),
> @@ -2916,6 +2962,7 @@ static struct omap_hwmod_ocp_if *omap3_sr1_slaves[] = {
>
>   static struct omap_hwmod omap34xx_sr1_hwmod = {
>   	.name		= "sr1_hwmod",
> +	.clkdm_name	= "wkup_clkdm",
>   	.class		=&omap34xx_smartreflex_hwmod_class,
>   	.main_clk	= "sr1_fck",
>   	.vdd_name	= "mpu",
> @@ -2938,6 +2985,7 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
>
>   static struct omap_hwmod omap36xx_sr1_hwmod = {
>   	.name		= "sr1_hwmod",
> +	.clkdm_name	= "wkup_clkdm",
>   	.class		=&omap36xx_smartreflex_hwmod_class,
>   	.main_clk	= "sr1_fck",
>   	.vdd_name	= "mpu",
> @@ -2962,6 +3010,7 @@ static struct omap_hwmod_ocp_if *omap3_sr2_slaves[] = {
>
>   static struct omap_hwmod omap34xx_sr2_hwmod = {
>   	.name		= "sr2_hwmod",
> +	.clkdm_name	= "wkup_clkdm",
>   	.class		=&omap34xx_smartreflex_hwmod_class,
>   	.main_clk	= "sr2_fck",
>   	.vdd_name	= "core",
> @@ -2984,6 +3033,7 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
>
>   static struct omap_hwmod omap36xx_sr2_hwmod = {
>   	.name		= "sr2_hwmod",
> +	.clkdm_name	= "wkup_clkdm",
>   	.class		=&omap36xx_smartreflex_hwmod_class,
>   	.main_clk	= "sr2_fck",
>   	.vdd_name	= "core",
> @@ -3051,6 +3101,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_mailbox_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_mailbox_hwmod = {
>   	.name		= "mailbox",
> +	.clkdm_name	= "core_l4_clkdm",
>   	.class		=&omap3xxx_mailbox_hwmod_class,
>   	.mpu_irqs	= omap3xxx_mailbox_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_mailbox_irqs),
> @@ -3190,6 +3241,7 @@ static struct omap2_mcspi_dev_attr omap_mcspi1_dev_attr = {
>
>   static struct omap_hwmod omap34xx_mcspi1 = {
>   	.name		= "mcspi1",
> +	.clkdm_name	= "core_l4_clkdm",
>   	.mpu_irqs	= omap34xx_mcspi1_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap34xx_mcspi1_mpu_irqs),
>   	.sdma_reqs	= omap34xx_mcspi1_sdma_reqs,
> @@ -3233,6 +3285,7 @@ static struct omap2_mcspi_dev_attr omap_mcspi2_dev_attr = {
>
>   static struct omap_hwmod omap34xx_mcspi2 = {
>   	.name		= "mcspi2",
> +	.clkdm_name	= "core_l4_clkdm",
>   	.mpu_irqs	= omap34xx_mcspi2_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap34xx_mcspi2_mpu_irqs),
>   	.sdma_reqs	= omap34xx_mcspi2_sdma_reqs,
> @@ -3276,6 +3329,7 @@ static struct omap2_mcspi_dev_attr omap_mcspi3_dev_attr = {
>
>   static struct omap_hwmod omap34xx_mcspi3 = {
>   	.name		= "mcspi3",
> +	.clkdm_name	= "core_l4_clkdm",
>   	.mpu_irqs	= omap34xx_mcspi3_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap34xx_mcspi3_mpu_irqs),
>   	.sdma_reqs	= omap34xx_mcspi3_sdma_reqs,
> @@ -3317,6 +3371,7 @@ static struct omap2_mcspi_dev_attr omap_mcspi4_dev_attr = {
>
>   static struct omap_hwmod omap34xx_mcspi4 = {
>   	.name		= "mcspi4",
> +	.clkdm_name	= "core_l4_clkdm",
>   	.mpu_irqs	= omap34xx_mcspi4_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap34xx_mcspi4_mpu_irqs),
>   	.sdma_reqs	= omap34xx_mcspi4_sdma_reqs,
> @@ -3366,6 +3421,7 @@ static struct omap_hwmod_irq_info omap3xxx_usbhsotg_mpu_irqs[] = {
>
>   static struct omap_hwmod omap3xxx_usbhsotg_hwmod = {
>   	.name		= "usb_otg_hs",
> +	.clkdm_name	= "core_l3_clkdm",
>   	.mpu_irqs	= omap3xxx_usbhsotg_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_usbhsotg_mpu_irqs),
>   	.main_clk	= "hsotgusb_ick",
> @@ -3408,6 +3464,7 @@ static struct omap_hwmod_class am35xx_usbotg_class = {
>
>   static struct omap_hwmod am35xx_usbhsotg_hwmod = {
>   	.name		= "am35x_otg_hs",
> +	.clkdm_name	= "core_l3_clkdm",
>   	.mpu_irqs	= am35xx_usbhsotg_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(am35xx_usbhsotg_mpu_irqs),
>   	.main_clk	= NULL,
> @@ -3466,6 +3523,7 @@ static struct omap_mmc_dev_attr mmc1_dev_attr = {
>
>   static struct omap_hwmod omap3xxx_mmc1_hwmod = {
>   	.name		= "mmc1",
> +	.clkdm_name	= "core_l4_clkdm",
>   	.mpu_irqs	= omap34xx_mmc1_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap34xx_mmc1_mpu_irqs),
>   	.sdma_reqs	= omap34xx_mmc1_sdma_reqs,
> @@ -3511,6 +3569,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_mmc2_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_mmc2_hwmod = {
>   	.name		= "mmc2",
> +	.clkdm_name	= "core_l4_clkdm",
>   	.mpu_irqs	= omap34xx_mmc2_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap34xx_mmc2_mpu_irqs),
>   	.sdma_reqs	= omap34xx_mmc2_sdma_reqs,
> @@ -3555,6 +3614,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_mmc3_slaves[] = {
>
>   static struct omap_hwmod omap3xxx_mmc3_hwmod = {
>   	.name		= "mmc3",
> +	.clkdm_name	= "core_l4_clkdm",
>   	.mpu_irqs	= omap34xx_mmc3_mpu_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap34xx_mmc3_mpu_irqs),
>   	.sdma_reqs	= omap34xx_mmc3_sdma_reqs,

