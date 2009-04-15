From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: lessen amount of noisy messages
Date: Wed, 15 Apr 2009 11:43:48 -0700
Message-ID: <20090415184347.GJ2167@atomide.com>
References: <1239288072.3390.8.camel@localhost.localdomain> <49E5D188.8060508@yandex.ru> <alpine.DEB.2.00.0904150917520.3313@utopia.booyaka.com> <1239810161.3390.190.camel@localhost.localdomain> <49E605FD.2020509@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53282 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbZDOSnw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2009 14:43:52 -0400
Content-Disposition: inline
In-Reply-To: <49E605FD.2020509@yandex.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind@yandex.ru>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

* Artem Bityutskiy <dedekind@yandex.ru> [090415 09:06]:
> Artem Bityutskiy wrote:
>> Disabling unused clock "gpt2_ick"
>> Disabling unused clock "gpt3_ick"
>> Disabling unused clock "gpt4_ick"
>> Disabling unused clock "gpt5_ick"
>> Disabling unused clock "gpt6_ick"
>> Disabling unused clock "gpt7_ick"
>> Disabling unused clock "gpt8_ick"
>> Disabling unused clock "gpt9_ick"
>> Disabling unused clock "gpio2_dbck"
>> Disabling unused clock "gpio3_dbck"
>> Disabling unused clock "gpio4_dbck"
>> Disabling unused clock "gpio5_dbck"
>> Disabling unused clock "gpio6_dbck"
>> Disabling unused clock "gpt9_fck"
>> Disabling unused clock "gpt8_fck"
>> Disabling unused clock "gpt7_fck"
>> Disabling unused clock "gpt6_fck"
>> Disabling unused clock "gpt5_fck"
>> Disabling unused clock "gpt4_fck"
>> Disabling unused clock "gpt3_fck"
>> Disabling unused clock "gpt2_fck"
>> Disabling unused clock "wdt2_ick"
>> Disabling unused clock "wdt2_fck"
>> Disabling unused clock "gpio1_dbck"
>> Disabling unused clock "rng_ick"
>> Disabling unused clock "ssi_ick"
>> Disabling unused clock "gpt10_ick"
>> Disabling unused clock "gpt11_ick"
>> Disabling unused clock "uart1_ick"
>> Disabling unused clock "uart2_ick"
>> Disabling unused clock "usbtll_ick"
>> Disabling unused clock "ssi_ssr_fck"
>> Disabling unused clock "uart1_fck"
>> Disabling unused clock "uart2_fck"
>> Disabling unused clock "usbtll_fck"
>> Disabling unused clock "ts_fck"
>> Disabling unused clock "cpefuse_fck"
>> Disabling unused clock "gpt11_fck"
>> Disabling unused clock "gpt10_fck"
>> Disabling unused clock "dpll5_ck"
>> Disabling unused clock "dpll4_m6x2_ck"
>> Disabling unused clock "dpll4_m5x2_ck"
>> Disabling unused clock "dpll3_m3x2_ck"
>> Disabling unused clock "sys_clkout1"
>>
>> The messages have KERN_INFO level and if you have serial
>> console, they normally go there. I do not think it is good
>> idea to print that much stuff there. Moreover, messages
>> are not properly prefixed and for mortals it is not
>> immeadietly clear where they come from.
>>
>> Let's give them debugging level instead.
>>
>> Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
>> ---
>>  arch/arm/mach-omap2/clock.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
>> index 4247a15..c4169ee 100644
>> --- a/arch/arm/mach-omap2/clock.c
>> +++ b/arch/arm/mach-omap2/clock.c
>> @@ -1035,7 +1035,7 @@ void omap2_clk_disable_unused(struct clk *clk)
>>  	if ((regval32 & (1 << clk->enable_bit)) == v)
>>  		return;
>>  -	printk(KERN_INFO "Disabling unused clock \"%s\"\n", clk->name);
>> +	printk(KERN_DEBUG "Disabling unused clock \"%s\"\n", clk->name);
>>  	if (cpu_is_omap34xx()) {
>>  		omap2_clk_enable(clk);
>>  		omap2_clk_disable(clk);
>
> Few notes. I'm just trying to clean up our system, because
> it prints too much to serial line. The clocks prints are
> not very bad, but I still find them a little bit excessive.
> Thus, suggested a patch.
>
> But if you think PM is in a stage when it still needs
> some debugging printing, I'm not going to insist, of course.
> You could do this later, when stuff is more stable.

These lines have been very informative when the boot fails
mysteriously. But I'd be fine seeing it only if debug is
specified in cmdline.

Tony
