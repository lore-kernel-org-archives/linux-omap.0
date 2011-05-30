From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH/RFC 4/4] OMAP2: PM debug: move wakeup timer into clockevent
 code
Date: Mon, 30 May 2011 12:51:12 +0530
Message-ID: <4DE34568.9060901@ti.com>
References: <1306450971-27732-1-git-send-email-khilman@ti.com> <1306450971-27732-5-git-send-email-khilman@ti.com> <4DDF3421.30308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:48135 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752069Ab1E3HVS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 May 2011 03:21:18 -0400
Received: by mail-yw0-f51.google.com with SMTP id 4so1365952ywg.10
        for <linux-omap@vger.kernel.org>; Mon, 30 May 2011 00:21:17 -0700 (PDT)
In-Reply-To: <4DDF3421.30308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, p-titiano@ti.com

Kevin,

On 5/27/2011 10:48 AM, Santosh Shilimkar wrote:
> On 5/27/2011 4:32 AM, Kevin Hilman wrote:
>> Move suspend wakeup timer from suspend path to be triggered based
>> on clockevent suspend path.
>>
>> When gptimers are eventually converted to be a driver, the wakeup
>> timer feature can be made to be a driver-specific feature using the
>> driver's suspend method.
>>
> Excellent idea and patch. Never crossed my mind that we could
> have used "CLOCK_EVT_MODE_SHUTDOWN" instead of our long old
> hack.
>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>


I will use this patch and other series for my OMAP4 re-basing
since it's all necessary and good clean-up.

Is that ok with you ?

Regards
Santosh




