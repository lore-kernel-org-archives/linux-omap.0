From: Kevin Hilman <khilman@linaro.org>
Subject: Re: OMAP EHCI having clock problems?
Date: Fri, 15 Feb 2013 07:54:47 -0800
Message-ID: <87fw0x608o.fsf@linaro.org>
References: <87halea4s3.fsf@linaro.org> <511DE9AB.5080403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f47.google.com ([209.85.210.47]:62278 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935835Ab3BOPyu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Feb 2013 10:54:50 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so1512276dak.6
        for <linux-omap@vger.kernel.org>; Fri, 15 Feb 2013 07:54:49 -0800 (PST)
In-Reply-To: <511DE9AB.5080403@ti.com> (Roger Quadros's message of "Fri, 15
	Feb 2013 09:54:19 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Roger Quadros <rogerq@ti.com> writes:

> Hi Kevin,
>
> On 02/15/2013 12:50 AM, Kevin Hilman wrote:
>> Felipe, Roger,
>> 
>> Using Tony's current master branch, and enabling EHCI support, I see 
>> the clock framework spitting loudly about the EHCI driver (full boot log
>> below.)   The same thing happens on v3.8-rc7.
>> 
>> Any idea what's going on?  Am I missing a set of fixes that's already
>> been posted?
>
> Thanks for pointing out. This series should fix the issues
> https://lkml.org/lkml/2013/1/23/155
>
> They should be on their way to linux-next.

Great.  But what about v3.8?  I see the same problems in v3.8-rc7.

>> 
>> On a related note, is anyone planning to fix the runtime PM problems in
>> this driver?  It's still disabled by default in omap2plus_defconfig
>> because the driver keeps CORE from hitting retention, even when no
>> devices are attached.
>
> I would be working on it. It is all about getting the silicon erratas
> worked around and making sure USB suspend/resume works.

Good to know,  Thanks.

Kevin
