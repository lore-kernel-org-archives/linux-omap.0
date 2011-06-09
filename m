From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFC 2/6] OMAP2+: PM: move runtime PM implementation to use device power domains
Date: Thu, 09 Jun 2011 09:37:11 -0700
Message-ID: <87boy73qrs.fsf@ti.com>
References: <1302134569-22825-1-git-send-email-khilman@ti.com>
	<1302134569-22825-3-git-send-email-khilman@ti.com>
	<4DF0D917.905@maxwell.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:55873 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752056Ab1FIQhO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 12:37:14 -0400
Received: by mail-pw0-f43.google.com with SMTP id 4so917793pwj.30
        for <linux-omap@vger.kernel.org>; Thu, 09 Jun 2011 09:37:13 -0700 (PDT)
In-Reply-To: <4DF0D917.905@maxwell.research.nokia.com> (Sakari Ailus's message
	of "Thu, 09 Jun 2011 17:30:47 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Cc: linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Felipe Balbi <balbi@ti.com>

Sakari Ailus <sakari.ailus@maxwell.research.nokia.com> writes:

> Hi Kevin and Felipe,
>
> Kevin Hilman wrote:
>> In commit 7538e3db6e015e890825fbd9f8659952896ddd5b (PM: add support
>> for device power domains) a better way for handling platform-specific
>> power hooks was introduced.
>> 
>> Rather than using the platform_bus dev_pm_ops overrides
>> (platform_bus_set_pm_ops()), this patch moves the OMAP runtime PM
>> implementation over to using device power domains.
>> 
>> Since OMAP is the only user of platform_bus_set_pm_ops(), that
>> interface can be removed (and will be in a forthcoming patch.)
>
> I have little doubt of the correctness of the patch itself, but it
> actually does break the USB on N900. I don't know PM so well that I
> would have a good idea what might be going wrong here, so I'm not
> certain that this is specific to the N900 either.
>
> It looks strange to me also but I've tested it several times so I'm
> fairly certain that the culprit is this very patch. :-) 

You're correct, it's broken.

A fix has been posted (and pull req sent to Tony.)  Can you try my
for_3.0/pm-fixes branch which fixes this problem?  It's available in my
git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

Thanks,

Kevin

