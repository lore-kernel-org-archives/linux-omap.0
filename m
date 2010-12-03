From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH] OMAP: pm.c correct the initcall for an early init.
Date: Fri, 3 Dec 2010 14:17:10 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03736F4913@dbde02.ent.ti.com>
References: <1291201283-21185-1-git-send-email-thara@ti.com>
 <878w0847vo.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54118 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631Ab0LCIrQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 03:47:16 -0500
In-Reply-To: <878w0847vo.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Thursday, December 02, 2010 7:03 PM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org
>>Subject: Re: [PATCH] OMAP: pm.c correct the initcall for an early init.
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> omap2_common_pm_init is the API where generic system devices like
>>> mpu, l3 etc get initialized. This has to happen really early on
>>> during the boot and not at a later time. This is especially important
>>> with the new opp changes as these devices need to be built before the
>>> opp tables init happen. Today both are device initcalls and it works
>>> just because of the order of compilation
>>
>>Why postcore?  there are several other inicalls earlier than
>>device_initcall.

Because the init in omap_device is a core_initcall. With respect
to opp layer, making this anything above device_initcall will work. But
then tomorrow some other module needs these generic devices in their init,
we will again have to bump up the init priority of this fn.
It is a good thing to do this early on in the boot cycle rather
than later.

>>
>>Also, does this actually work?  Is the driver core initialized at
>>postcore_initcall time such that omap_devices w/platform_device
>>creation actually works?

Yes by post_initcall the omap_device initializations would
have happened. In fact these initializations happen as
core_initcall.

>>
>>Kevin
>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/pm.c |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
>>> index 59ca03b..6ec2ee1 100644
>>> --- a/arch/arm/mach-omap2/pm.c
>>> +++ b/arch/arm/mach-omap2/pm.c
>>> @@ -143,5 +143,5 @@ static int __init omap2_common_pm_init(void)
>>>
>>>  	return 0;
>>>  }
>>> -device_initcall(omap2_common_pm_init);
>>> +postcore_initcall(omap2_common_pm_init);
