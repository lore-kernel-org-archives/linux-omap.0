From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 4/6] arm: omap3: add manual control for mpu_iva voltdm usecounting
Date: Wed, 15 Feb 2012 11:29:37 -0800
Message-ID: <871upvao9q.fsf@ti.com>
References: <1329237402-26008-1-git-send-email-t-kristo@ti.com>
	<1329237402-26008-5-git-send-email-t-kristo@ti.com>
	<8762f96wdk.fsf@ti.com> <1329293765.4102.335.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:37217 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753984Ab2BOT3l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 14:29:41 -0500
Received: by mail-pz0-f41.google.com with SMTP id v6so1169813dad.28
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 11:29:40 -0800 (PST)
In-Reply-To: <1329293765.4102.335.camel@sokoban> (Tero Kristo's message of
	"Wed, 15 Feb 2012 10:16:05 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> On Tue, 2012-02-14 at 11:35 -0800, Kevin Hilman wrote:
>> Tero Kristo <t-kristo@ti.com> writes:
>> 
>> > mpu_iva voltdm usecount is now decreased during idle. This will
>> > allow the voltagedomain to reflect actual usage, and will allow
>> > proper usage of vc callbacks.
>> 
>> I don't follow why this is needed in the idle path.
>> 
>> Why aren't the usecounts from clock/powerdomain disables (enables) causing this
>> voltdm disable (enable) to happen automatcially?
>
> The main issue is mpu powerdomain which doesn't contain any clocks that
> are controlled actively. Without adding a "virtual" usecount
> enable/disable hook, the usecount for mpu_iva will always remain at 0
> (or just follow the iva domain on omap3.) 

Rather than faking the MPU clock gating by disabling the voltage/power
domains, why not just gate the MPU clock in idle?   That would trigger
all the rest and would also be much clearer what is happening in the
idle path.

> We want the usecount to reflect the actual idling of this domain also,
> so that we can control SR / auto-ret based on MPU activity.

Yes, makes sense now.  Thanks for the explanation.

>> If these are needed, seems like they should be in the
>> pwrdm_[pre|post]_transition() hooks so they can be generic.
>
> This is actually a good idea, I could move them here. I could also add a
> manual triggering for core domain here, as I have a feeling it might be
> good to have so that core will also follow the idle cycle more tightly
> (basically as a virtual follow for sdrc clock which is idled by HW
> during wfi.)

In the comments on the new version, you should also describe in detail
the reasons for the "manual" idling of CORE (due to clocks that are
hardware managed.)

Kevin

