From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH] OMAP: pm.c correct the initcall for an early init.
Date: Wed, 15 Dec 2010 21:08:07 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037395C306@dbde02.ent.ti.com>
References: <1291201283-21185-1-git-send-email-thara@ti.com>
	<878w0847vo.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03736F4913@dbde02.ent.ti.com>
 <87zks92meb.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54087 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193Ab0LOPiG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Dec 2010 10:38:06 -0500
In-Reply-To: <87zks92meb.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Tuesday, December 14, 2010 6:37 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org
>>Subject: Re: [PATCH] OMAP: pm.c correct the initcall for an early init.
>>
>>"Gopinath, Thara" <thara@ti.com> writes:
>>
>>>>>-----Original Message-----
>>>>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>>>Sent: Thursday, December 02, 2010 7:03 PM
>>>>>To: Gopinath, Thara
>>>>>Cc: linux-omap@vger.kernel.org
>>>>>Subject: Re: [PATCH] OMAP: pm.c correct the initcall for an early init.
>>>>>
>>>>>Thara Gopinath <thara@ti.com> writes:
>>>>>
>>>>>> omap2_common_pm_init is the API where generic system devices like
>>>>>> mpu, l3 etc get initialized. This has to happen really early on
>>>>>> during the boot and not at a later time. This is especially important
>>>>>> with the new opp changes as these devices need to be built before the
>>>>>> opp tables init happen. Today both are device initcalls and it works
>>>>>> just because of the order of compilation
>>>>>
>>>>>Why postcore?  there are several other inicalls earlier than
>>>>>device_initcall.
>>>
>>> Because the init in omap_device is a core_initcall. With respect
>>> to opp layer, making this anything above device_initcall will work. But
>>> then tomorrow some other module needs these generic devices in their
>>init,
>>> we will again have to bump up the init priority of this fn.
>>> It is a good thing to do this early on in the boot cycle rather
>>> than later.
>>
>>OK, please describe this in more detail the changelog.
Ok Will repost 

Regards
Thara

