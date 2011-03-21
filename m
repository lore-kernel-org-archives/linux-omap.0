From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/7] OMAP2+: voltage: move PRCM mod offets into VDD structure
Date: Mon, 21 Mar 2011 08:21:12 -0700
Message-ID: <87ei60h53r.fsf@ti.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com>
	<1300493932-17362-3-git-send-email-khilman@ti.com>
	<6002d9aa481856ee6e703e8f6cbda767@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:45348 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751492Ab1CUPVV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Mar 2011 11:21:21 -0400
Received: by mail-pw0-f53.google.com with SMTP id 7so993895pwj.12
        for <linux-omap@vger.kernel.org>; Mon, 21 Mar 2011 08:21:17 -0700 (PDT)
In-Reply-To: <6002d9aa481856ee6e703e8f6cbda767@mail.gmail.com> (Santosh
	Shilimkar's message of "Sat, 19 Mar 2011 10:11:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Minor comment.
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Kevin Hilman
>> Sent: Saturday, March 19, 2011 5:49 AM
>> To: linux-omap@vger.kernel.org
>> Cc: Paul Walmsely; Benoit Cousson
>> Subject: [PATCH 2/7] OMAP2+: voltage: move PRCM mod offets into VDD
>> structure
>>
>> Eliminate need for global variables for the various PRM module
>> offsets by
>> making them part of the VDD structure.
>>
>> Eventually, these will likely be moved again, or more likely
>> removed,
>> but for now just getting rid of them as global variabes so that the
>> voltage domain initialization can be cleaned up.
>>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>>  arch/arm/mach-omap2/voltage.c                 |  109 ++++++++++++--
>> -----------
>>  arch/arm/mach-omap2/voltage.h                 |    6 +-
>>  arch/arm/mach-omap2/voltagedomains3xxx_data.c |   10 +-
>>  arch/arm/mach-omap2/voltagedomains44xx_data.c |   12 ++-
>>  4 files changed, 67 insertions(+), 70 deletions(-)
>>
> [....]
>
>> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-
>> omap2/voltage.h
>> index e9f5408..44edc1e 100644
>> --- a/arch/arm/mach-omap2/voltage.h
>> +++ b/arch/arm/mach-omap2/voltage.h
>> @@ -133,6 +133,9 @@ struct omap_vdd_info {
>>  	struct dentry *debug_dir;
>>  	u32 curr_volt;
>>  	bool vp_enabled;
>> +
>> +	s16 prm_mod;
>> +	s16 prm_irqst_mod;
>
> Can you also add kernel doc for above two
> entries?
>

Yes, thanks.

Kevin
