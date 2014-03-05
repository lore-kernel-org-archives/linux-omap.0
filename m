From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v4 4/4] ARM: OMAP2+: Add pdata quirk for sys_clkout2 for
 omap3 DBB056
Date: Wed, 5 Mar 2014 15:07:01 +0200
Message-ID: <53172175.5060603@ti.com>
References: <1392387656-15186-1-git-send-email-chf.fritz@googlemail.com> <1392387656-15186-5-git-send-email-chf.fritz@googlemail.com> <20140228223741.GM13624@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35097 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569AbaCENHi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Mar 2014 08:07:38 -0500
In-Reply-To: <20140228223741.GM13624@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Christoph Fritz <chf.fritz@googlemail.com>
Cc: bcousson@baylibre.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Nishanth Menon <nm@ti.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Daniel Mack <zonque@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 03/01/2014 12:37 AM, Tony Lindgren wrote:
> * Christoph Fritz <chf.fritz@googlemail.com> [140214 06:24]:
>> Full device tree support for clock control, especially to set frequencies,
>> is not yet accomplished. Until then, configure the 24Mhz of sys_clkout2 to
>> feed an USB-Hub here.
>
> Hmm would like to see Tero's comments on this, I wonder if we should
> wait on this to avoid extra churn?

Well, the set I posted that adds default clock parenting / default rate 
support to DT hasn't actually moved forward, so you might want to take 
this in as is now if it should be rushed. The clk-enable part isn't done 
currently by anything anyway. Just wondering though, should you create 
some sort of driver for your usb-hub which would control these clocks?

-Tero


>
> Regards,
>
> Tony
>
>> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
>> ---
>>   arch/arm/mach-omap2/pdata-quirks.c |   37 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
>> index 435a823..e36ac3f 100644
>> --- a/arch/arm/mach-omap2/pdata-quirks.c
>> +++ b/arch/arm/mach-omap2/pdata-quirks.c
>> @@ -172,6 +172,43 @@ static void __init am3517_evm_legacy_init(void)
>>
>>   static void __init omap3_dbb056_legacy_init(void)
>>   {
>> +	struct clk *clkout2;
>> +	struct clk *cm96fck;
>> +
>> +	/* Reparent clkout2 to 96M_FCK */
>> +	pr_info("%s: Late Reparent clkout2 to 96M_FCK\n", __func__);
>> +	clkout2 = clk_get(NULL, "clkout2_src_ck");
>> +	if (clkout2 < 0) {
>> +		pr_err("a83x-quirk: couldn't get clkout2_src_ck\n");
>> +		return;
>> +	}
>> +	cm96fck = clk_get(NULL, "cm_96m_fck");
>> +	if (cm96fck < 0) {
>> +		pr_err("a83x-quirk: couldn't get cm_96m_fck\n");
>> +		return;
>> +	}
>> +	if (clk_set_parent(clkout2, cm96fck) < 0) {
>> +		pr_err("a83x-quirk: couldn't reparent clkout2_src_ck\n");
>> +		return;
>> +	}
>> +
>> +	/* Set clkout2 to 24MHz for internal usb hub*/
>> +	pr_info("%s: Set clkout2 to 24MHz for internal usb hub\n", __func__);
>> +	clkout2 = clk_get(NULL, "sys_clkout2");
>> +	if (clkout2 < 0) {
>> +		pr_err("%s: couldn't get sys_clkout2\n", __func__);
>> +		return;
>> +	}
>> +	if (clk_set_rate(clkout2, 24000000) < 0) {
>> +		pr_err("%s: couldn't set sys_clkout2 rate\n", __func__);
>> +		return;
>> +	}
>> +	if (clk_prepare_enable(clkout2) < 0) {
>> +		pr_err("%s: couldn't enable sys_clkout2\n", __func__);
>> +		return;
>> +	}
>> +
>> +	/* Initialize display */
>>   	omap3_dbb056_display_init_of();
>>   }
>>   #endif /* CONFIG_ARCH_OMAP3 */
>> --
>> 1.7.10.4
>>

