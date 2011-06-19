From: Leigh Brown <leigh@solinno.co.uk>
Subject: Re: [PATCH] input: keypad: lm8323: convert to threaded IRQ
Date: Sun, 19 Jun 2011 23:01:43 +0100
Message-ID: <694a51cff83de55276b804b23668447e@doppler.thel33t.co.uk>
References: <1307999812-3802-1-git-send-email-balbi@ti.com>
 <a07cbd61db83c3308dd76f7c0f481477@doppler.thel33t.co.uk>
 <20110619195604.GC14262@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from doppler.thel33t.co.uk ([193.110.88.198]:52010 "EHLO
	doppler.thel33t.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366Ab1FSWBp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Jun 2011 18:01:45 -0400
In-Reply-To: <20110619195604.GC14262@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Sun, 19 Jun 2011 22:56:06 +0300, Felipe Balbi wrote:
> Hi,
>
> On Sun, Jun 19, 2011 at 07:00:13PM +0000, Leigh Brown wrote:
>> Many thanks for trying to assist me with my problem. To recap,
>
> yeah, no problem ;-)
>
>> I'm seeing the keypad lock-up on my N810 using this driver,
>> when I type quickly.
>>
>> I tried your patch, and it doesn't fix the issue.  However, I've
>> read the datasheet for the lm8323 and it looks to me like the
>> interrupt should be level rather than edge triggered.
>>
>> The following additional patch makes things work for me.  I
>> couldn't tell you if it's the correct thing to do but I can no
>> longer cause the keypad to lock-up by typing too fast.
>
> good good. Looks like IRQF_ONESHOT is what did the trick.
>
> Did you check if IRQF_ONESHOT alone was enough ?

I tried that first, but it didn't fix it, although it makes it a
little bit harder to trigger.  I've just tried again to be sure,
but I got a lock-up quite easily.

Regards,

Leigh.

