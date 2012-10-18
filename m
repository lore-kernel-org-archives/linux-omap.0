From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/3] RTC: omap-rtc: enable pm_runtime
Date: Thu, 18 Oct 2012 18:19:44 +0200
Message-ID: <50802C20.9040408@gmail.com>
References: <1350575631-15523-1-git-send-email-zonque@gmail.com> <1350575631-15523-2-git-send-email-zonque@gmail.com> <50802A87.9010409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47829 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324Ab2JRQTw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 12:19:52 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so4268642bkc.19
        for <linux-omap@vger.kernel.org>; Thu, 18 Oct 2012 09:19:51 -0700 (PDT)
In-Reply-To: <50802A87.9010409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: rtc-linux@googlegroups.com, a.zummo@towertech.it, koen@dominion.thruhere.net, david-b@pacbell.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 18.10.2012 18:12, Vaibhav Hiremath wrote:
> 
> 
> On 10/18/2012 9:23 PM, Daniel Mack wrote:
>> This is needed as preparation for platforms where using pm runtime usage
>> is mandatory.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
> 
> It looks like, you just duplicated effort here.
> RTC patches have been already submitted quite some time back for AM33xx,
> probably you missed to do google before spending time on this.
> 
> Patch Series -
> http://www.mail-archive.com/davinci-linux-open-source@linux.davincidsp.com/msg23253.html

Heh, damn :) I would have thought that so shortly after the merge
window, that code either went in already or is yet missing. Oh well.

> Denial,
> It would be really helpful if you could test these patches and ack them.

Ok, will do tomorrow. What's missing there is support for writing to the
OMAP_RTC_OSC_REG (path 3/3 in my series). Would like me to rebase the
functionality? I need thatkind of setup for my board ...


> Just FYI, we have bunch of parallel activities going inside team to
> upstream all the patches/module/drivers/features, so to avoid such
> duplication of effort, I suggest you to google for the patches or ping
> on mailing list.

Yes, it's more difficult to participate in the AM33xx code than in other
platforms. I'm not complaining about other doing all the hard work
though, it's just a little different.

Anyway - thanks for the heads-up!


Daniel

