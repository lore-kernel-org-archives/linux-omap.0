From: Aneesh V <aneesh@ti.com>
Subject: Re: [PATCH 1/7] OMAP: ID: introduce chip detection for OMAP4460
Date: Fri, 01 Jul 2011 15:45:11 +0530
Message-ID: <4E0D9E2F.5030601@ti.com>
References: <1309486081-8257-1-git-send-email-rnayak@ti.com> <1309486081-8257-2-git-send-email-rnayak@ti.com> <20110701062505.GW23145@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:50235 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755677Ab1GAKPz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 06:15:55 -0400
Received: by gwb17 with SMTP id 17so1490894gwb.29
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 03:15:54 -0700 (PDT)
In-Reply-To: <20110701062505.GW23145@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, Nishanth Menon <nm@ti.com>

On Friday 01 July 2011 11:55 AM, Tony Lindgren wrote:
> * Rajendra Nayak<rnayak@ti.com>  [110630 19:03]:
>> --- a/arch/arm/mach-omap2/id.c
>> +++ b/arch/arm/mach-omap2/id.c
>> @@ -331,8 +331,8 @@ static void __init omap3_check_revision(void)
>>   static void __init omap4_check_revision(void)
>>   {
>>   	u32 idcode;
>> -	u16 hawkeye;
>>   	u8 rev;
>> +	u16 hawkeye;
>>
>>   	/*
>>   	 * The IC rev detection is done with hawkeye and rev.
>
> Please leave out this change, there's no need for it.

Ok. I will fix this.

br,
Aneesh
