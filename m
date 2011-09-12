From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP: omap_device: fix !CONFIG_SUSPEND case in _noirq
 handlers
Date: Mon, 12 Sep 2011 10:44:03 -0700
Message-ID: <4E6E44E3.1090607@ti.com>
References: <1314900722-10252-1-git-send-email-khilman@ti.com> <1876183.c78P8V3ZbL@wuerfel> <201109012357.39873.rjw@sisk.pl> <4E667EE1.1020808@ti.com> <4E668094.40108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:40922 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751618Ab1ILRoK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 13:44:10 -0400
Received: by mail-yx0-f179.google.com with SMTP id 8so326398yxk.10
        for <linux-omap@vger.kernel.org>; Mon, 12 Sep 2011 10:44:09 -0700 (PDT)
In-Reply-To: <4E668094.40108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

Arnd,

On 09/06/2011 01:20 PM, Kevin Hilman wrote:
> On 09/06/2011 01:13 PM, Kevin Hilman wrote:
>> On 09/01/2011 02:57 PM, Rafael J. Wysocki wrote:
>>> On Thursday, September 01, 2011, Arnd Bergmann wrote:
>>>> On Thursday 01 September 2011 11:12:02 Kevin Hilman wrote:
>>>>> The suspend/resume _noirq handlers were #ifdef'd out in the
>>>>> !CONFIG_SUSPEND case, but were still assigned to the dev_pm_ops
>>>>> struct. Fix by defining them to NULL in the !CONFIG_SUSPEND case.
>>>>>
>>>>> Reported-by: Arnd Bergmann<arnd@arndb.de>
>>>>> Signed-off-by: Kevin Hilman<khilman@ti.com>
>>>>
>>>> Acked-by: Arnd Bergmann<arnd@arndb.de>
>>>>
>>>> Thansk for the fast response!
>>>
>>> I'll apply the patch when kernel.org is back in order.
>>>
>>
>> Tony,
>>
>> I spoke w/Rafael and due to hera being down and Rafael traveling to LPC
>> he wont be able to queue this for v3.1. Can you queue up this fix? This
>> needs to go in to v3.1-rc.
>
> For convenience, this patch is in a branch in my backup gitorious repo
> with Arnd's ack added:
>
> git://gitorious.org/khilman/linux-omap-pm.git for_3.1/pm-fixes-2
>

Can you pick this up for v3.1-rc also?

Thanks,

Kevin

