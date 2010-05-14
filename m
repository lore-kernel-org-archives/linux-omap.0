From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 00/17] omap: mailbox: reorganize init
Date: Fri, 14 May 2010 22:03:20 +0300
Message-ID: <AANLkTinzSJjupRMGWmlB6cyGpYMm5tpPvhcMFdROZNCL@mail.gmail.com>
References: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
	 <AANLkTildHTovAq6DZa2nPgYwX3BHsHuvM9oKGFssFH6-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61780 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab0ENTDW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 15:03:22 -0400
Received: by fxm6 with SMTP id 6so1834286fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 12:03:20 -0700 (PDT)
In-Reply-To: <AANLkTildHTovAq6DZa2nPgYwX3BHsHuvM9oKGFssFH6-@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>

On Fri, May 14, 2010 at 6:09 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Hi Felipe,
>
> On Fri, May 14, 2010 at 6:01 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> The main purpose of this patch series is to be able to compile mach platform
>> data as built-in. Otherwise, client modules such as bridgedriver will load the
>> platform code, but not the mach code when mailbox is built as a module.
>>
>> Unfortunately, there's no easy way to do that since plat and mach code are
>> deepely interrelated. So the first patches try to separate the mailbox
>> registering through a defined omap_mbox_platform_data.
>
> Have you considered converting mailbox to hwmod + omap_device ?

I don't know what's that... so no. Is there any good source of
information, or a good example? I think there is further tidying up
possible after this patch series independent of that, but I would like
to concentrate on getting this in first.

-- 
Felipe Contreras
