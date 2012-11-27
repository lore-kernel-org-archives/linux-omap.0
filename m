From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 00/16] OMAP USB Host cleanup
Date: Tue, 27 Nov 2012 16:42:47 +0200
Message-ID: <50B4D167.4090205@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com> <87fw49cnvh.fsf@deeprootsystems.com> <50AA05C3.7010003@ti.com> <876251b2kq.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45393 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755442Ab2K0Omt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Nov 2012 09:42:49 -0500
In-Reply-To: <876251b2kq.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On 11/20/2012 01:22 AM, Kevin Hilman wrote:
> Roger Quadros <rogerq@ti.com> writes:
> 
>> Kevin,
>>
>> On 11/16/2012 10:08 PM, Kevin Hilman wrote:
>>> Roger Quadros <rogerq@ti.com> writes:
>>>
>>>> Hi,
>>>>
>>>> This patchset addresses the following
>>>>
>>>> - Avoid addressing clocks one by one by name and use a for loop + bunch
>>>>   of cleanups.
>>>> - Get number of channels/ports dynamically either from revision register
>>>>   or from platform data. Avoids getting clocks that are not present.
>>>> - Add OMAP5 and HSIC mode (Not tested)
>>>> - Save power on Panda when EHCI driver is not loaded.
>>>>
>>>
>>> Seeing the clock changes/cleanups, I gave this a spin on OMAP3
>>> (3530/Beagle, 3530/Overo, 3730/Beagle-xM, 3730/OveroSTORM) to see if it
>>> fixed up the problem where CORE does not hit retention in idle when USB
>>> host is enabled, even with no devices attached.
>>>
>>> Unfortunately, it didn't help. :(
>>
>> oh that's bad. But this series wasn't meant to fix that ;).
> 
> Oh, sorry.  Yeah, I didn't mean this as a nak.  Just an opportunity to
> complain to the maintainers that a long-standing issue needs to be
> addressed.
> 

Kevin,

I gave a quick look at the issue. It seems that the High Speed USB Host
module is kept in Software forced wakeup mode as a quick fix workaround
to a bunch of silicon erratas. And we do nothing on USB global suspend.
That's why CORE does not hit retention.

If we runtime_suspend the USB host module on USB global suspend then it
will be put in Force Idle mode. This will allow CORE to hit retention
but then we will no longer be able to detect USB device connect events.

So, till we have a better solution I will suggest to keep EHCI_HCD as a
module in omap2plus_defconfig.

--
regards,
-roger
