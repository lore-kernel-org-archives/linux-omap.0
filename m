From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 07/10 V3] omap3: clk: use pm accessor functions for cpufreq
 table
Date: Tue, 08 Dec 2009 05:09:27 -0600
Message-ID: <4B1E33E7.7030109@ti.com>
References: <1259122159-1583-1-git-send-email-nm@ti.com> <1259122159-1583-2-git-send-email-nm@ti.com> <1259122159-1583-3-git-send-email-nm@ti.com> <1259122159-1583-4-git-send-email-nm@ti.com> <1259122159-1583-5-git-send-email-nm@ti.com> <1259122159-1583-6-git-send-email-nm@ti.com> <1259122159-1583-7-git-send-email-nm@ti.com> <1259122159-1583-8-git-send-email-nm@ti.com> <1F18D6510CF0474A8C9500565A7E41A2236EC92019@NOK-EUMSG-02.mgdnok.nokia.com>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:37105 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794AbZLHLJZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 06:09:25 -0500
Received: by ywh36 with SMTP id 36so5276099ywh.15
        for <linux-omap@vger.kernel.org>; Tue, 08 Dec 2009 03:09:30 -0800 (PST)
In-Reply-To: <1F18D6510CF0474A8C9500565A7E41A2236EC92019@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@deeprootsystems.com, madhu.cr@ti.com, paul@pwsan.com, romit@ti.com, premi@ti.com, santosh.shilimkar@ti.com, saaguirre@ti.com, thara@ti.com, vishwanath.bs@ti.com

Tero.Kristo@nokia.com said the following on 12/07/2009 10:54 AM:
> Hi,
>
> One comment below.
>
>   
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org 
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of ext 
>> Nishanth Menon
>> Sent: 25 November, 2009 06:09
>> To: linux-omap
>> Cc: Nishanth Menon; Benoit Cousson; Kevin Hilman; Madhusudhan 
>> Chikkature Rajashekar; Paul Walmsley; Romit Dasgupta; Sanjeev 
>> Premi; Santosh Shilimkar; Sergio Alberto Aguirre Rodriguez; 
>> Thara Gopinath; Vishwanath Sripathy
>> Subject: [PATCH 07/10 V3] omap3: clk: use pm accessor 
>> functions for cpufreq table
>>
>> omap2_clk_init_cpufreq_table currently directly accesses the opp
>> table, making it unscalable to various OMAPs. Instead use the
>> accessor functions to populate the cpufreq table
>>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Romit Dasgupta <romit@ti.com>
>> Cc: Sanjeev Premi <premi@ti.com>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
>> Cc: Thara Gopinath <thara@ti.com>
>> Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>> arch/arm/mach-omap2/clock34xx.c |   32 
>> +++++++++++++++++++-------------
>> 1 files changed, 19 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/clock34xx.c 
>> b/arch/arm/mach-omap2/clock34xx.c
>> index 5150939..d07f1c1 100644
>> --- a/arch/arm/mach-omap2/clock34xx.c
>> +++ b/arch/arm/mach-omap2/clock34xx.c
>> @@ -1042,30 +1042,36 @@ static unsigned long 
>> omap3_clkoutx2_recalc(struct clk *clk)
>> #if defined(CONFIG_ARCH_OMAP3)
>>
>> #ifdef CONFIG_CPU_FREQ
>> -static struct cpufreq_frequency_table freq_table[MAX_VDD1_OPP+1];
>> +
>> +static struct cpufreq_frequency_table *freq_table;
>>
>> void omap2_clk_init_cpufreq_table(struct 
>> cpufreq_frequency_table **table)
>> {
>> -	struct omap_opp *prcm;
>> 	int i = 0;
>> +	u8 opp_num;
>> +	struct omap_opp *opp = NULL;
>> +	unsigned long freq = ULONG_MAX;
>>
>> -	if (!mpu_opps)
>> +	if (!mpu_opps || opp_get_opp_count(&opp_num, mpu_opps)) {
>> +		pr_warning("%s: failed to initialize frequency"
>> +				"table\n", __func__);
>> 		return;
>> -
>> -	prcm = mpu_opps + MAX_VDD1_OPP;
>> -	for (; prcm->rate; prcm--) {
>> -		freq_table[i].index = i;
>> -		freq_table[i].frequency = prcm->rate / 1000;
>> -		i++;
>> 	}
>>
>> -	if (i == 0) {
>> -		printk(KERN_WARNING "%s: failed to initialize 
>> frequency \
>> -								
>> table\n",
>> -								
>> __func__);
>> +	freq_table = kmalloc(sizeof(struct cpufreq_frequency_table) *
>> +			(opp_num + 1), GFP_KERNEL);
>>     
>
> I guess this should be GFP_ATOMIC, we have clockfw spinlock reserved when this is called (gave me a runtime warning.)
>   
Thanks.. I must have missed the warning.. :( will check and add..

>   
>> +	if (!freq_table) {
>> +		pr_warning("%s: failed to allocate frequency"
>> +				"table\n", __func__);
>> 		return;
>> 	}
>>
>> +	while (!opp_get_lower_opp(&opp, &freq, mpu_opps)) {
>> +		freq_table[i].index = i;
>> +		freq_table[i].frequency =  freq / 1000;
>> +		i++;
>> +	}
>> +
>> 	freq_table[i].index = i;
>> 	freq_table[i].frequency = CPUFREQ_TABLE_END;
>>
>> -- 
>> 1.6.3.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>>     
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   

