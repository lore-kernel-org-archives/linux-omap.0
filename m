From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: pm.c correct the initcall for an early init.
Date: Mon, 13 Dec 2010 17:06:36 -0800
Message-ID: <87zks92meb.fsf@deeprootsystems.com>
References: <1291201283-21185-1-git-send-email-thara@ti.com>
	<878w0847vo.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03736F4913@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43927 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758782Ab0LNBGm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 20:06:42 -0500
Received: by pwj3 with SMTP id 3so20438pwj.19
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 17:06:42 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03736F4913@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Fri, 3 Dec 2010 14:17:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Gopinath, Thara" <thara@ti.com> writes:

>>>-----Original Message-----
>>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>Sent: Thursday, December 02, 2010 7:03 PM
>>>To: Gopinath, Thara
>>>Cc: linux-omap@vger.kernel.org
>>>Subject: Re: [PATCH] OMAP: pm.c correct the initcall for an early init.
>>>
>>>Thara Gopinath <thara@ti.com> writes:
>>>
>>>> omap2_common_pm_init is the API where generic system devices like
>>>> mpu, l3 etc get initialized. This has to happen really early on
>>>> during the boot and not at a later time. This is especially important
>>>> with the new opp changes as these devices need to be built before the
>>>> opp tables init happen. Today both are device initcalls and it works
>>>> just because of the order of compilation
>>>
>>>Why postcore?  there are several other inicalls earlier than
>>>device_initcall.
>
> Because the init in omap_device is a core_initcall. With respect
> to opp layer, making this anything above device_initcall will work. But
> then tomorrow some other module needs these generic devices in their init,
> we will again have to bump up the init priority of this fn.
> It is a good thing to do this early on in the boot cycle rather
> than later.

OK, please describe this in more detail the changelog.

Thanks,

Kevin

