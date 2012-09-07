From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] gpio/omap: fix possible memory leak in omap2_gpio_dev_init()
Date: Fri, 07 Sep 2012 15:37:39 -0700
Message-ID: <87har9ihn0.fsf@deeprootsystems.com>
References: <CAPgLHd-XS_AtLr+8R6yNkSXdNxO3i-NapK7o5zBUado-7R99=w@mail.gmail.com>
	<871uidjxmr.fsf@deeprootsystems.com>
	<20120907222416.GR1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62143 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757683Ab2IGWhn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 18:37:43 -0400
Received: by pbbrr13 with SMTP id rr13so257284pbb.19
        for <linux-omap@vger.kernel.org>; Fri, 07 Sep 2012 15:37:43 -0700 (PDT)
In-Reply-To: <20120907222416.GR1303@atomide.com> (Tony Lindgren's message of
	"Fri, 7 Sep 2012 15:24:17 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, linux@arm.linux.org.uk, paul@pwsan.com, yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@deeprootsystems.com> [120907 15:07]:
>> Wei Yongjun <weiyj.lk@gmail.com> writes:
>> 
>> > From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>> >
>> > pdata and pdata->regs have been allocated in this function and 
>> > should be freed before leaving it, and in the other error handling
>> > cases too.
>> >
>> > spatch with a semantic match is used to found this problem.
>> > (http://coccinelle.lip6.fr/)
>> >
>> > Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>> 
>> Acked-by: Kevin Hilman <khilman@ti.com>
>> 
>> Tony, can you pick this one up for fixes?
>
> Sure, is fixes-noncritical OK for this one?

Yes.

Kevin
