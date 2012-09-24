From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH] arm: make FORCE_MAX_ZONEORDER configurable for TI AM33XX
Date: Mon, 24 Sep 2012 21:05:11 +0200
Message-ID: <CAGm1_ks_GvSTH8DJ6d3R5OjPNEOhQ39hNo4grg1Pn-NqFX5VKQ@mail.gmail.com>
References: <1341325242-17638-1-git-send-email-yegorslists@googlemail.com> <20120924171858.GG28835@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:51258 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757679Ab2IXTFc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 15:05:32 -0400
Received: by wgbdr13 with SMTP id dr13so3976661wgb.1
        for <linux-omap@vger.kernel.org>; Mon, 24 Sep 2012 12:05:31 -0700 (PDT)
In-Reply-To: <20120924171858.GG28835@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Dejan Gacnik <dejan.gacnik@gmail.com>

On Mon, Sep 24, 2012 at 7:18 PM, Tony Lindgren <tony@atomide.com> wrote:
> * yegorslists@googlemail.com <yegorslists@googlemail.com> [120703 07:26]:
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> FORCE_MAX_ZONEORDER of 12 is needed to allocation more than 4MB
>> of consistent DMA memory (da8xx frame buffer driver).
>
> Sorry for the delay on this one, looks like this one is
> still valid. I'll apply it.

Thanks.

Yegor

>> Signed-off-by: Dejan Gacnik <dejan.gacnik@gmail.com>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>> ---
>>  arch/arm/Kconfig |    5 +++--
>>  1 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index e876819..ff14c1e 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1725,8 +1725,9 @@ config HW_PERF_EVENTS
>>  source "mm/Kconfig"
>>
>>  config FORCE_MAX_ZONEORDER
>> -     int "Maximum zone order" if ARCH_SHMOBILE
>> -     range 11 64 if ARCH_SHMOBILE
>> +     int "Maximum zone order"
>> +     depends on ARCH_SHMOBILE || SOC_AM33XX
>> +     range 11 64 if ARCH_SHMOBILE || SOC_AM33XX
>>       default "9" if SA1111
>>       default "11"
>>       help
>> --
>> 1.7.7
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
