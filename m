From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: omap2plus_defconfig: EHCI driver is not stable, disable it
Date: Mon, 09 Jul 2012 09:36:03 -0700
Message-ID: <87obnox570.fsf@ti.com>
References: <1341598828-31410-1-git-send-email-khilman@ti.com>
	<20120709084032.GZ1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:32981 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752131Ab2GIQgI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jul 2012 12:36:08 -0400
Received: by pbbro8 with SMTP id ro8so21387487pbb.11
        for <linux-omap@vger.kernel.org>; Mon, 09 Jul 2012 09:36:06 -0700 (PDT)
In-Reply-To: <20120709084032.GZ1122@atomide.com> (Tony Lindgren's message of
	"Mon, 9 Jul 2012 01:40:33 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@ti.com> [120706 11:25]:
>> The EHCI driver is not stable enough to be enabled by default.  In v3.5,
>> it has at least the following problems:
>> 
>> - warning dump during bootup
>> - hang during suspend
>> - prevents CORE powerdomain from entering retention during idle (even
>>   when no USB devices connected.)
>> 
>> This demonstrates that this driver has not been thoroughly tested and
>> therfore should not be enabled in the default defconfig.
>> 
>> In addition, the problems above cause new PM regressions which need be
>> addressed before this driver should be enabled in the default
>> defconfig.
>> 
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> Tony, this applies to your current fixes branch.   Please queue up for v3.5-rc
>> so this PM regression is fixed in v3.5.  Thanks.
>
> OK adding, 

Thanks.

> although I don't like the idea of having to disable drivers in the
> defconfig to fix issues :(

Neither do I, that's why I've been complaining about it since v3.5 came
out so it would be properly addressed by the driver writers.  It hasn't,
so this is the last resort.

> The hang during suspend case would
> be potentially hit by many people.. Should the driver/usb/host/ehci-omap.c
> be patched to disable suspend or at least warn about it?

Russ Dill has posted fixes already for several of the problems, and
Keshava has posted a revert, but I don't see them beling addressed for
v3.5. 

However, those fixes still don't address the CORE retention in idle
issue which breaks PM for the whole SoC, so IMO this driver is still not
ready to be enabled by default.

Kevin
