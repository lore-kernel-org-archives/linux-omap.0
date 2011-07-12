From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP2+: PM: fix watchdog boot when runtime PM is disabled
Date: Tue, 12 Jul 2011 07:55:00 -0700
Message-ID: <878vs3v9a3.fsf@ti.com>
References: <1310426484-30083-1-git-send-email-khilman@ti.com>
	<4E1B8B47.3020904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:39414 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751009Ab1GLOzF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jul 2011 10:55:05 -0400
Received: by mail-iy0-f178.google.com with SMTP id 26so6580557iyb.23
        for <linux-omap@vger.kernel.org>; Tue, 12 Jul 2011 07:55:04 -0700 (PDT)
In-Reply-To: <4E1B8B47.3020904@ti.com> (Santosh Shilimkar's message of "Mon,
	11 Jul 2011 16:46:15 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On 7/11/2011 4:21 PM, Kevin Hilman wrote:
>> Fix boot crash in watchdog driver when runtime PM is disabled.
>>
>> When runtime PM is disabled, devices should be left enabled so that
>> all device accesses in drivers will succeed even though the runtime PM
>> get/put calls are noops.
>>
>> This is already the case for all devices, but the WDT init has its
>> own hwmod postsetup which was not taking this into account.
>>
>> This fixes a boot crash where the first device access in the WDT probe
>> function would crash a booting kernel.
>>
>> Cc: Paul Walmsley<paul@pwsan.com>
>> Signed-off-by: Kevin Hilman<khilman@ti.com>
>> ---
>> Tony, as this is a boot crash, it should probably be queued for v3.0.
>> However, since OMAP2PLUS_TYPICAL always enables runtime PM, this is
>> unlikely to be seen unless specifically testing with runtime PM disabled.
>>
> This patch is exactly same as the one I submitted on Jan 5, 2011 for
> the same issue. Here is the patchwork link for the same.
>
> https://patchwork.kernel.org/patch/453481/
>
> Paul had a valid concern about the boot-loader leaving the watchdog
> enabled. More on this in below thread.
>
> http://www.spinics.net/lists/arm-kernel/msg110937.html
>

Paul's concern is valid, and could be addressed by making that init code
actually check if the WDT is currently active (as suggested by the
comment there.)

In the mean time, this simple fix should be applied to prevent a boot
crash, IMO.

Kevin
