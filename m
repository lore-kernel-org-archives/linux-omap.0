From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 4/7] OMAP4: hwmod data: Replace main_clk with the real
 input clock
Date: Tue, 28 Jun 2011 10:10:17 +0200
Message-ID: <4E098C69.90203@ti.com>
References: <1309192391-12410-1-git-send-email-b-cousson@ti.com>	 <1309192391-12410-5-git-send-email-b-cousson@ti.com> <1309243240.1825.24.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48539 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756441Ab1F1IKW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Jun 2011 04:10:22 -0400
In-Reply-To: <1309243240.1825.24.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,

On 6/28/2011 8:40 AM, Valkeinen, Tomi wrote:
> On Mon, 2011-06-27 at 18:33 +0200, Benoit Cousson wrote:
>> Previously, main_clk was a fake clock node that was accessing the
>> PRCM modulemode register. Since the module mode is directly
>> controlled by the hwmod fmwk, these fake clock node are not
>> needed anymore. The hwmod main_clk will point directly to the
>> input clock node if applicable.
>> For example, some IPs, like the GPIOs, do not have any functional
>> clock and are using only the iclk. In that case, the main_clk
>> field will be empty.
>>
>> In the case of the DSS, we can now consider all the optional clock as
>> main clock.
>> That will simplify greatly the driver management and the integration
>> with hwmod.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Tomi Valkeinen<tomi.valkeinen@ti.com>
>> Cc: Paul Walmsley<paul@pwsan.com>
>> Cc: Rajendra Nayak<rnayak@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  111 +++++++++++++---------------
>>   1 files changed, 51 insertions(+), 60 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> index e10d3f7..5c196a1 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>
> <snip>
>
>> @@ -1263,7 +1263,6 @@ static struct omap_hwmod omap44xx_dss_hwmod = {
>>   	.name		= "dss_core",
>>   	.class		=&omap44xx_dss_hwmod_class,
>>   	.clkdm_name	= "l3_dss_clkdm",
>> -	.main_clk	= "dss_fck",
>>   	.prcm = {
>>   		.omap4 = {
>>   			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
>
> Why dss_core doesn't need a mainclock? Shouldn't it have dss_dss_clk as
> a mainclock?

Yep, good point.

>
>> @@ -1363,7 +1362,7 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
>>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_irqs),
>>   	.sdma_reqs	= omap44xx_dss_dispc_sdma_reqs,
>>   	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_sdma_reqs),
>> -	.main_clk	= "dss_fck",
>> +	.main_clk	= "dss_dss_clk",
>>   	.prcm = {
>>   		.omap4 = {
>>   			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
>> @@ -1456,7 +1455,7 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
>>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dss_dsi1_irqs),
>>   	.sdma_reqs	= omap44xx_dss_dsi1_sdma_reqs,
>>   	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_dss_dsi1_sdma_reqs),
>> -	.main_clk	= "dss_fck",
>> +	.main_clk	= "dss_sys_clk",
>>   	.prcm = {
>>   		.omap4 = {
>>   			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
>
> Hmm... I don't think this is right. By default the DSI uses dss_dss_clk
> as the functional clock. sys_clk goes to the DSI PLL, and the output of
> which can be later used as the fclk for DSI. But that requires setup.

OK, it was not super clear from the DSS clock tree which one should be 
the main one.
So you'd prefer to have the dss_dss_clk as main clock and keep the 
dss_sys_clk as a opt_clock?

Benoit

