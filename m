From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 12/13 v5] OMAP: GPIO: Use dev_pm_ops instead of sys_dev_class
Date: Thu, 12 Aug 2010 07:07:38 -0700
Message-ID: <87pqxnvs9h.fsf@deeprootsystems.com>
References: <1281098065-24177-1-git-send-email-charu@ti.com>
	<1281098065-24177-2-git-send-email-charu@ti.com>
	<1281098065-24177-3-git-send-email-charu@ti.com>
	<1281098065-24177-4-git-send-email-charu@ti.com>
	<1281098065-24177-5-git-send-email-charu@ti.com>
	<1281098065-24177-6-git-send-email-charu@ti.com>
	<1281098065-24177-7-git-send-email-charu@ti.com>
	<1281098065-24177-8-git-send-email-charu@ti.com>
	<1281098065-24177-9-git-send-email-charu@ti.com>
	<1281098065-24177-10-git-send-email-charu@ti.com>
	<1281098065-24177-11-git-send-email-charu@ti.com>
	<1281098065-24177-12-git-send-email-charu@ti.com>
	<1281098065-24177-13-git-send-email-charu@ti.com>
	<871va79v28.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E80AC458@dbde02.ent.ti.com>
	<87fwym5og4.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E80ACFD0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47890 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159Ab0HLOHk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 10:07:40 -0400
Received: by pwi4 with SMTP id 4so137561pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 12 Aug 2010 07:07:40 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E80ACFD0@dbde02.ent.ti.com>
	(Partha Basak's message of "Thu, 12 Aug 2010 13:19:52 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Basak, Partha" <p-basak2@ti.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

"Basak, Partha" <p-basak2@ti.com> writes:

[...]

>> >>
>> >> Why is this better than passing the next power state?
>> >
>> > This would keep the GPIO function omap2_gpio_prepare_for_idle agnostic
>> of Power state definition dependencies.
>> >
>> 
>> And why is this better?
>> 
>> Personally, I think the GPIO code should be told about the powerdomain
>> state so it can make it's own decision about whether or not to save
>> context.
>> 
>
> I see your point. 
>
> But, in the approach we have followed so far, we are trying to
> localize all Power domain related logic and information in
> pm_34xxx.c. If we refer to all other such functions like
> omap_uart_prepare_idle(),omap3_intc_prepare_idle(),
> musb_context_save_restore()(newly introduced by USB patches for
> HWMOD), they are all following the same paradigm. None of these
> functions receive the Power state information as a parameter. The idea
> is to segregate the Power domain related information into the power
> layer.
>
> In omap2_gpio_prepare_for_idle() implementation, we are just being
> consistent with this approach.
>

Yes, you're following the existing approach, but the existing approach
is wrong, so I'm suggesting you change.  There was no common design for
any of these, and they all behave slightly differently.

For example, we should be passing the power state in the UART hook so
the UART code doesn't have to check 'enable_off_mode' to know whether or
not to save context.

IOW, instead of keeping the decision making centralized in the PM core,
we should just be notifiying the drivers about the state change.  The
idle loop is kept simple, and all the inteligence should be in the
drivers.

Also, the PM core should no be telling a module to save context.  It
should be notifying the module of a state change.  IOW, instead of
calling these functions save/restore context, they should be called
prepare/resume idle.

In the linux-pm community, there are increasing discussions on how to
combine CPUidle and runtime PM.  So in the medium term, we'll probably
be coming up with a more standard way for the idle path to notify
drivers using runtime PM.  Until that happens, all these prepare/resume
idle hooks are just temporary.

Kevin




