From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 01/28] OMAP3: PM: GPMC context save/restore
Date: Mon, 5 Oct 2009 12:58:04 -0500
Message-ID: <4ACA33AC.4070704@ti.com>
References: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com>	<1254441538-9257-2-git-send-email-khilman@deeprootsystems.com>	<4AC76454.20605@gmail.com> <87ws39yciw.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55662 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293AbZJER6n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Oct 2009 13:58:43 -0400
In-Reply-To: <87ws39yciw.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin Hilman had written, on 10/05/2009 12:29 PM, the following:
> Nishanth Menon <menon.nishanth@gmail.com> writes:

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
> 
> Not sure I follow the problem here.  What do you mean by "rename".
> The saved context will have values for 2 and 3, but the is_valid
> flag will not be set, so they shouldn't be used.
My bad.. s/rename/enable/ for 2,3 ->definitely not something I would 
like to see.

> 
> Rajendra was the original author of these, so maybe I'm not fully
> understanding here, but disabling a GPMC looks to me like it
> will disable both the save and restore.

Yes, anyone else has an opinion, please pop them here.

-- 
Regards,
Nishanth Menon
