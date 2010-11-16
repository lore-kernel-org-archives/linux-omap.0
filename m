From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 1/3] omap: opp: add OMAP3 OPP table data and common
 init
Date: Tue, 16 Nov 2010 05:54:50 -0600
Message-ID: <4CE2710A.3010804@ti.com>
References: <[PATCH 0/3 v2] omap: opp: Add opp data>	<1289849261-29767-2-git-send-email-nm@ti.com> <20101116122128.5c6cc050@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:44472 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933802Ab0KPLzC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Nov 2010 06:55:02 -0500
Received: by mail-yw0-f43.google.com with SMTP id 9so301544ywk.2
        for <linux-omap@vger.kernel.org>; Tue, 16 Nov 2010 03:55:01 -0800 (PST)
In-Reply-To: <20101116122128.5c6cc050@surf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony <tony@atomide.com>

Thomas Petazzoni wrote, on 11/16/2010 05:21 AM:
> Hello,
>
> On Mon, 15 Nov 2010 13:27:39 -0600
> Nishanth Menon<nm@ti.com>  wrote:
>
>> +	/*
>> +	 * Allow multiple calls, but initialize only if not already initalized
>
> Minor: s/initalized/initialized/.
aah thanks :)

>
>> +	 * even if the previous call failed, coz, no reason we'd succeed again
>> +	 */
>> +	if (omap_table_init)
>> +		return 0;
>> +	omap_table_init = 1;
>
> Do we really need this ? I personaly don't really like this quite of
> "Hey, I'm already initialized, let's do nothing silently then". Unless
> there are strong reasons for which this function could be called twice,
> I'd rather not have this, or turn this into a BUG_ON(omap_table_init ==
> 1).
Yes, it is needed. The intent here is different. See the documentation 
that I put along with this patch - At times, board files may need to do 
customization to opps - like enable 1GHz on that platform alone -> it 
can do it *only if* the defaults are registered, following which it can 
call opp_enable. when device_initcall follows this at a later point, it 
is still valid.

btw, BUG_ON is a strict NO NO for me here - if I dont have OPP table, ok 
fine, system can still survive without cpufreq, no need to stop system 
operations because of that.


-- 
Regards,
Nishanth Menon
