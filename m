From: Benoit <b-cousson@ti.com>
Subject: Re: [PATCH 0/9] OMAP: DMTIMER: Convert platform driver so as to make
 use of hwmod + omap device framework for OMAP2 PLUS
Date: Fri, 04 Jun 2010 00:29:23 +0200
Message-ID: <4C082CC3.80800@ti.com>
References: <1275143831-7629-1-git-send-email-thara@ti.com>	<4C02E275.2080202@ti.com> <878w6vn4gu.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59672 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752413Ab0FCWaG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jun 2010 18:30:06 -0400
In-Reply-To: <878w6vn4gu.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Sawant, Anand" <sawant@ti.com>

On 6/4/2010 12:20 AM, Kevin Hilman wrote:
> Benoit Cousson<b-cousson@ti.com>  writes:
>
>> On 5/29/2010 4:37 PM, Gopinath, Thara wrote:
>>> This patch series converts the OMAP Dual Mode Timer into a
>>> platform driver. This involves using of hwmod structures and
>>> omap_device layer for OMAP2/3/4 dmtimers and generic
>>> linux platform device layer for OMAP1.
>>>
>>> As a result of this patch series the dmtimer platform driver
>>> resides in arch/arm/plat-omap directory and arch specific
>>> implementations and device registerations reside in
>>> arch/arm/mach-omap1 and arch/arm/mach-omap2 for OMAP1
>>> and OMAP2 PLUS respectively.
>>
>> Hi Thara,
>>
>> The Dual timer terminology is not used anymore since 2420.
>> It was replaced by gptimer and will be simplified going forward
>> using timer. This IP is almost the same since 1610, but will have 3
>> different names.
>> It might be the good opportunity to align the names?
>
> If we were to align the names, what should be the "aligned" name?
> gptimer or timer?  I tend to prefer gptimer as 'timer' is rather
> ambiguous in this context.

Arrrgs, too late... After many discussions we agreed on 'timer' with HW 
folks. Neither dmtimer not gptimer bring any useful information. Timer 
that are not regular timers will have some prefix / postfix like wd_ for 
the watchdog. And synctimer not being a timer at all will then be 
renamed counter.
Why do you think 'timer' is ambiguous?

Benoit

> For now, we could leave the names of all the functions and structs as
> 'dm_timer', but at least this serious could name the new files and the
> platform devices with the new name.  At the end of the series, one
> final patch to s/dm_timer/new_beautiful_name/ would be an easy patch.
>
> Kevin


