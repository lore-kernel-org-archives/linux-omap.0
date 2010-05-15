From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 00/17] omap: mailbox: reorganize init
Date: Sat, 15 May 2010 11:36:20 +0300
Message-ID: <AANLkTimC2IoWwfqvnVMKgVeZ7iyx6quwRgYXEgjXZ6pP@mail.gmail.com>
References: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
	<AANLkTildHTovAq6DZa2nPgYwX3BHsHuvM9oKGFssFH6-@mail.gmail.com>
	<AANLkTinzSJjupRMGWmlB6cyGpYMm5tpPvhcMFdROZNCL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34896 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525Ab0EOIgm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 May 2010 04:36:42 -0400
Received: by gyg13 with SMTP id 13so1427142gyg.19
        for <linux-omap@vger.kernel.org>; Sat, 15 May 2010 01:36:40 -0700 (PDT)
In-Reply-To: <AANLkTinzSJjupRMGWmlB6cyGpYMm5tpPvhcMFdROZNCL@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>

Hi Felipe,

On Fri, May 14, 2010 at 10:03 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Fri, May 14, 2010 at 6:09 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> Hi Felipe,
>>
>> On Fri, May 14, 2010 at 6:01 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> The main purpose of this patch series is to be able to compile mach platform
>>> data as built-in. Otherwise, client modules such as bridgedriver will load the
>>> platform code, but not the mach code when mailbox is built as a module.
>>>
>>> Unfortunately, there's no easy way to do that since plat and mach code are
>>> deepely interrelated. So the first patches try to separate the mailbox
>>> registering through a defined omap_mbox_platform_data.
>>
>> Have you considered converting mailbox to hwmod + omap_device ?
>
> I don't know what's that... so no. Is there any good source of
> information, or a good example?

A good example (that also demonstrates runtime PM conversion)
would be the MMC conversion in Kevin's 'pm-wip/mmc' branch:

http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=log;h=pm-wip/mmc

> I think there is further tidying up
> possible after this patch series independent of that, but I would like
> to concentrate on getting this in first.

Sure thing.

Thanks,
Ohad.

>
> --
> Felipe Contreras
>
