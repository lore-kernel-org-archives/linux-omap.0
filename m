From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/28] OMAP3: PM: GPMC context save/restore
Date: Mon, 05 Oct 2009 10:29:59 -0700
Message-ID: <87ws39yciw.fsf@deeprootsystems.com>
References: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com>
	<1254441538-9257-2-git-send-email-khilman@deeprootsystems.com>
	<4AC76454.20605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:63826 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754336AbZJERaj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Oct 2009 13:30:39 -0400
Received: by pxi9 with SMTP id 9so3172538pxi.4
        for <linux-omap@vger.kernel.org>; Mon, 05 Oct 2009 10:30:01 -0700 (PDT)
In-Reply-To: <4AC76454.20605@gmail.com> (Nishanth Menon's message of "Sat\, 03 Oct 2009 09\:48\:52 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>, Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Nishanth Menon <menon.nishanth@gmail.com> writes:

[...]

>> +void omap3_gpmc_save_context()
>> +{
>> +	int i;
>> +	gpmc_context.sysconfig = gpmc_read_reg(GPMC_SYSCONFIG);
>> +	gpmc_context.irqenable = gpmc_read_reg(GPMC_IRQENABLE);
>> +	gpmc_context.timeout_ctrl = gpmc_read_reg(GPMC_TIMEOUT_CONTROL);
>> +	gpmc_context.config = gpmc_read_reg(GPMC_CONFIG);
>> +	gpmc_context.prefetch_config1 = gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
>> +	gpmc_context.prefetch_config2 = gpmc_read_reg(GPMC_PREFETCH_CONFIG2);
>> +	gpmc_context.prefetch_control = gpmc_read_reg(GPMC_PREFETCH_CONTROL);
>> +	for (i = 0; i < GPMC_CS_NUM; i++) {
>> +		gpmc_context.cs_context[i].is_valid =
>> +				(gpmc_cs_read_reg(i, GPMC_CS_CONFIG7))
>> +							& GPMC_CONFIG7_CSVALID;
>> +		if (gpmc_context.cs_context[i].is_valid) {
>> +			gpmc_context.cs_context[i].config1 =
>> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG1);
>> +			gpmc_context.cs_context[i].config2 =
>> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG2);
>> +			gpmc_context.cs_context[i].config3 =
>> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG3);
>> +			gpmc_context.cs_context[i].config4 =
>> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG4);
>> +			gpmc_context.cs_context[i].config5 =
>> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG5);
>> +			gpmc_context.cs_context[i].config6 =
>> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG6);
>> +			gpmc_context.cs_context[i].config7 =
>> +				gpmc_cs_read_reg(i, GPMC_CS_CONFIG7);
>> +		}
>>   
> here is a theoretical bug:
> 1: GPMC, 1, 2, 3 4 5 configured 6 7 not configured.
> 2. Save and restore 1: save and restore variables which are static will
> contain 1-5 and not 6&7
> 3. next I disable 2,3
> 3. save will save 1,4,5 BUT my variable will contain 1,2,3,4,5 ->
> restore will rename 2,3 (which I did not intend)..

Not sure I follow the problem here.  What do you mean by "rename".
The saved context will have values for 2 and 3, but the is_valid
flag will not be set, so they shouldn't be used.

Rajendra was the original author of these, so maybe I'm not fully
understanding here, but disabling a GPMC looks to me like it
will disable both the save and restore.

Kevin
