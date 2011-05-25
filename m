From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 07/15] OMAP: GPIO: handle save/restore ctx in GPIO driver
Date: Wed, 25 May 2011 15:36:30 -0700
Message-ID: <87boyqpfv5.fsf@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-8-git-send-email-tarun.kanti@ti.com>
	<87ipsypfzk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:57114 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752296Ab1EYWge (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 18:36:34 -0400
Received: by mail-pz0-f43.google.com with SMTP id 1so79184pzk.16
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 15:36:32 -0700 (PDT)
In-Reply-To: <87ipsypfzk.fsf@ti.com> (Kevin Hilman's message of "Wed, 25 May
	2011 15:33:51 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

Kevin Hilman <khilman@ti.com> writes:

[...]
>> @@ -1394,11 +1409,17 @@ void omap2_gpio_resume_after_idle(void)
>>  		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
>>  			clk_enable(bank->dbck);
>>  
>> -		if (!workaround_enabled)
>> +		pdev = to_platform_device(bank->dev);
>> +		ctx_lost_cnt_after = omap_device_get_context_loss_count(pdev);
>> +
>> +		if (ctx_lost_cnt_after == bank->ctx_lost_cnt_before)
>>  			continue;
>>  
>> +		if (!workaround_enabled)
>> +			goto restore_gpio_ctx;
>
> Now that these functions are all bank-specific, this
> 'workaround_enabled' flag should be made per-bank.

Oops, ignore this comment... I see it's done in the next patch.

Kevin
