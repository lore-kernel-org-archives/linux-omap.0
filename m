From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH/RFC 4/4] OMAP2: PM debug: move wakeup timer into clockevent
 code
Date: Mon, 30 May 2011 13:40:27 +0530
Message-ID: <4DE350F3.1080901@ti.com>
References: <1306450971-27732-1-git-send-email-khilman@ti.com>	<1306450971-27732-5-git-send-email-khilman@ti.com>	<4DDF3421.30308@ti.com>	<4DE34568.9060901@ti.com> <BANLkTikqpRdbixs-UhM1tAUTDM3k9LQ33A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:45517 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752952Ab1E3IKe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 May 2011 04:10:34 -0400
Received: by mail-yi0-f53.google.com with SMTP id 25so1626474yia.12
        for <linux-omap@vger.kernel.org>; Mon, 30 May 2011 01:10:33 -0700 (PDT)
In-Reply-To: <BANLkTikqpRdbixs-UhM1tAUTDM3k9LQ33A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, p-titiano@ti.com

On 5/30/2011 1:38 PM, Jean Pihet wrote:
> On Mon, May 30, 2011 at 9:21 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com>  wrote:
>> Kevin,
>>
>> On 5/27/2011 10:48 AM, Santosh Shilimkar wrote:
>>>
>>> On 5/27/2011 4:32 AM, Kevin Hilman wrote:
>>>>
>>>> Move suspend wakeup timer from suspend path to be triggered based
>>>> on clockevent suspend path.
>>>>
>>>> When gptimers are eventually converted to be a driver, the wakeup
>>>> timer feature can be made to be a driver-specific feature using the
>>>> driver's suspend method.
>>>>
>>> Excellent idea and patch. Never crossed my mind that we could
>>> have used "CLOCK_EVT_MODE_SHUTDOWN" instead of our long old
>>> hack.
>
> Great!
> Acked-by: Jean Pihet<j-pihet@ti.com>
>
> What platform has is been tested on?
>
I tried thos on OMAP4430 and it works as expected.
