From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 01/28] OMAP3: PM: GPMC context save/restore
Date: Mon, 5 Oct 2009 12:31:52 -0500
Message-ID: <4ACA2D88.4090402@ti.com>
References: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com>	<1254441538-9257-2-git-send-email-khilman@deeprootsystems.com>	<4AC76454.20605@gmail.com> <87eiphzrnf.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36337 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753839AbZJERcd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Oct 2009 13:32:33 -0400
In-Reply-To: <87eiphzrnf.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>

Kevin Hilman had written, on 10/05/2009 12:17 PM, the following:

>>> +#ifdef CONFIG_ARCH_OMAP3
>>>   
>> apologies if this is a dumb question - why is this under #ifdef -> if
>> the save save restore structures are not under #ifdef?
> 
> Not a dumb question, good catch.  I'll move the struct inside
> this #ifdef.
Thanks.. would you consider the theoretical issue below?
> 
>>> +void omap3_gpmc_save_context()
>>> +{
>>> +	int i;
>>> +	gpmc_context.sysconfig = gpmc_read_reg(GPMC_SYSCONFIG);
>>> +	gpmc_context.irqenable = gpmc_read_reg(GPMC_IRQENABLE);
>>> +	gpmc_context.timeout_ctrl = gpmc_read_reg(GPMC_TIMEOUT_CONTROL);
>>> +	gpmc_context.config = gpmc_read_reg(GPMC_CONFIG);
>>> +	gpmc_context.prefetch_config1 = gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
>>> +	gpmc_context.prefetch_config2 = gpmc_read_reg(GPMC_PREFETCH_CONFIG2);
>>> +	gpmc_context.prefetch_control = gpmc_read_reg(GPMC_PREFETCH_CONTROL);
>>> +	for (i = 0; i < GPMC_CS_NUM; i++) {
>>> +		gpmc_context.cs_context[i].is_valid =
>>> +				(gpmc_cs_read_reg(i, GPMC_CS_CONFIG7))
>>> +							& GPMC_CONFIG7_CSVALID;
>>> +		if (gpmc_context.cs_context[i].is_valid) {
>>> +			gpmc_context.cs_context[i].config1 =
>>> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG1);
>>> +			gpmc_context.cs_context[i].config2 =
>>> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG2);
>>> +			gpmc_context.cs_context[i].config3 =
>>> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG3);
>>> +			gpmc_context.cs_context[i].config4 =
>>> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG4);
>>> +			gpmc_context.cs_context[i].config5 =
>>> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG5);
>>> +			gpmc_context.cs_context[i].config6 =
>>> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG6);
>>> +			gpmc_context.cs_context[i].config7 =
>>> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG7);
>>> +		}
>>>   
>> here is a theoretical bug:
>> 1: GPMC, 1, 2, 3 4 5 configured 6 7 not configured.
>> 2. Save and restore 1: save and restore variables which are static will
>> contain 1-5 and not 6&7
>> 3. next I disable 2,3
>> 3. save will save 1,4,5 BUT my variable will contain 1,2,3,4,5 ->
>> restore will rename 2,3 (which I did not intend)..
I wonder if there should be an else with a memset to 0..

-- 
Regards,
Nishanth Menon
