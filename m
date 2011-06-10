From: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Subject: N900 USB fix (Was: Re: [PATCH/RFC 2/6] OMAP2+: PM: move runtime PM
 implementation to use device power domains)
Date: Fri, 10 Jun 2011 09:57:57 +0300
Message-ID: <4DF1C075.9080401@maxwell.research.nokia.com>
References: <1302134569-22825-1-git-send-email-khilman@ti.com>	<1302134569-22825-3-git-send-email-khilman@ti.com>	<4DF0D917.905@maxwell.research.nokia.com> <87boy73qrs.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:30827 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803Ab1FJG6S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jun 2011 02:58:18 -0400
In-Reply-To: <87boy73qrs.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Felipe Balbi <balbi@ti.com>

Kevin Hilman wrote:
> Sakari Ailus <sakari.ailus@maxwell.research.nokia.com> writes:
> 
>> Hi Kevin and Felipe,
>>
>> Kevin Hilman wrote:
>>> In commit 7538e3db6e015e890825fbd9f8659952896ddd5b (PM: add support
>>> for device power domains) a better way for handling platform-specific
>>> power hooks was introduced.
>>>
>>> Rather than using the platform_bus dev_pm_ops overrides
>>> (platform_bus_set_pm_ops()), this patch moves the OMAP runtime PM
>>> implementation over to using device power domains.
>>>
>>> Since OMAP is the only user of platform_bus_set_pm_ops(), that
>>> interface can be removed (and will be in a forthcoming patch.)
>>
>> I have little doubt of the correctness of the patch itself, but it
>> actually does break the USB on N900. I don't know PM so well that I
>> would have a good idea what might be going wrong here, so I'm not
>> certain that this is specific to the N900 either.
>>
>> It looks strange to me also but I've tested it several times so I'm
>> fairly certain that the culprit is this very patch. :-) 
> 
> You're correct, it's broken.
> 
> A fix has been posted (and pull req sent to Tony.)  Can you try my
> for_3.0/pm-fixes branch which fixes this problem?  It's available in my
> git tree:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

Hi, Kevin!

Many thanks to you! :-) The patches indeed fix the problem. I seem to
have used for_3.0/pm-fixes-2 branch, though. I guess that doesn't really
matter. :-)

Cheers,

-- 
Sakari Ailus
sakari.ailus@maxwell.research.nokia.com
