From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
Date: Tue, 13 Mar 2012 19:37:16 +0800
Message-ID: <CACVXFVOqmC0OhT-Dim8dL9pWnmGwO2-Awc4V2Jziyf7DHQdYcQ@mail.gmail.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
	<1326983304-14619-2-git-send-email-hvaibhav@ti.com>
	<87mx9ej8fp.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41481 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab2CMLhQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Mar 2012 07:37:16 -0400
Received: by yenl12 with SMTP id l12so407508yen.19
        for <linux-omap@vger.kernel.org>; Tue, 13 Mar 2012 04:37:16 -0700 (PDT)
In-Reply-To: <87mx9ej8fp.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, johnstul@us.ibm.com, Felipe Balbi <balbi@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Hi,

On Tue, Jan 24, 2012 at 7:38 AM, Kevin Hilman <khilman@ti.com> wrote:
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
>
>> OMAP device has 32k-sync timer which is currently used as a
>> clocksource in the kernel (omap2plus_defconfig).
>> The current implementation uses compile time selection between
>> gp-timer and 32k-sync timer, which breaks multi-omap build for
>> the devices like AM33xx, where 32k-sync timer is not available.
>>
>> So use hwmod database lookup mechanism, through which at run-time
>> we can identify availability of 32k-sync timer on the device,
>> else fall back to gp-timer.
>
> With the runtime detection & fallback, I suggest also removing the
> Kconfig choice between the two as well.

IMO, under some situations, gp timer clocksource has high precision
and is very useful, so hope the Kconfig choice can be kept, or using
kernel parameter way,  and the patch need to be changed to support the
selection.


thanks,
-- 
Ming Lei
