From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH v8 3/3] OMAP4:keypad: PM runtime
Date: Wed, 23 Feb 2011 19:49:33 +0530
Message-ID: <4D651775.8030308@ti.com>
References: <1293429106-16543-1-git-send-email-shubhrajyoti@ti.com> <1293429106-16543-2-git-send-email-shubhrajyoti@ti.com> <1293429106-16543-3-git-send-email-shubhrajyoti@ti.com> <1293429106-16543-4-git-send-email-shubhrajyoti@ti.com> <4D50FF42.1070401@ti.com> <4D5F33E3.7000501@ti.com> <20110219053111.GA6991@core.coreip.homeip.net> <AANLkTikCmiSrOZb3WvMZHcxRsSRxd1zUsWE59aexHdeF@mail.gmail.com> <20110223062900.GB19269@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:40692 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750741Ab1BWOTm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 09:19:42 -0500
In-Reply-To: <20110223062900.GB19269@core.coreip.homeip.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Abraham Arce <x0066660@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

On Wednesday 23 February 2011 11:59 AM, Dmitry Torokhov wrote:
> On Sat, Feb 19, 2011 at 01:44:32PM +0530, Datta, Shubhrajyoti wrote:
>> On Sat, Feb 19, 2011 at 11:01 AM, Dmitry Torokhov<dmitry.torokhov@gmail.com
>>> wrote:
>>> Hi Shubhrajyoti,
>>>
>>> On Sat, Feb 19, 2011 at 08:37:15AM +0530, Shubhrajyoti wrote:
>>>> Hello Dmitry,
>>>> If there are no further comments.
>>>> Can it be queued?
>>> I normally try not to merge board code leaving it to arch owner. Can we
>>> at least get arch/board maintainer ACKs on this?
>>>
>>> Also, I am wondering, what is the utility of this patch? Without it,
>>> as far as I understand, runtime PM is disabled for the device. With the
>>> patch we enable runtime PM but immediately bump up usage count, thus
>>> ensuring that the device is always powered on. So what changed? Or am I
>>> missing something?
>>>
>> After the hwmod changes the clocks are cut. So if it is not enabled then the
>> device is not usable.
>>
> OK, that makes sense. So since we are wiring up runtime PM I think we
> should go a strep further and do it in open/close methods. Does the
> patch below still work for you?
Yes it works I did some basic  testinig it on omap4 sdp. Thanks
> Thanks.
>

