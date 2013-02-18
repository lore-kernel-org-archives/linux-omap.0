From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Mon, 18 Feb 2013 06:52:35 -0800
Message-ID: <87vc9p4qto.fsf@linaro.org>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
	<1360840554-26901-2-git-send-email-balbi@ti.com>
	<87obfl60x7.fsf@linaro.org> <511F1245.60208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:60528 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab3BROwi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Feb 2013 09:52:38 -0500
Received: by mail-pb0-f42.google.com with SMTP id xb4so1708506pbc.15
        for <linux-omap@vger.kernel.org>; Mon, 18 Feb 2013 06:52:38 -0800 (PST)
In-Reply-To: <511F1245.60208@ti.com> (Santosh Shilimkar's message of "Sat, 16
	Feb 2013 10:29:49 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On Friday 15 February 2013 09:10 PM, Kevin Hilman wrote:
>> Felipe Balbi <balbi@ti.com> writes:
>>
>>> Currently the omap-serial driver will not
>>> work properly if booted via DT with CPUIDLE
>>> enabled because it depends on function pointers
>>> provided by hwmod to change its own SYSCONFIG
>>> register.
>>>
>>> Remove that relyance on hwmod by moving SYSCONFIG
>>> handling to driver itself. Note that this also
>>> fixes a possible corner case bug where we could
>>> be putting UART in Force Idle mode if we called
>>> omap_serial_enable_wakeup(up, false) after setting
>>> NOIDLE to the idle mode. This is because hwmod
>>> has no protection against that situation.
>>>
>>> NYET-Signed-off-by: Felipe Balbi <balbi@ti.com>
>>
>> Here's another approach to getting rid of the sysconfig twiddling in the
>> driver.  I wrote this some time ago at my former company ;) but don't
>> think I ever got around to posting it.
>>
>> It doesn't solve the whole problem (e.g. doesn't address the
>> context_loss or enable_wakeup func pointers), but at least gets rid of
>> the need for any SYSCONFIG access in the driver for the idle modes.
>>
>> Needs more thorough testing.
>>
> I posted similar patch series[1] yesterday after testing it on OMAP4/5
> devices. OMAP3 testing seems to be ok as well. AM3XXX and OMAP2 test
> results is what am waiting for.

Yeah, I saw yours after I posted mine.  Just continue with yours, I'll
be glad to have someone else take this on.

> Good to know that you had similar idea in mind to get rid of
> UART sysc hackery.

Likewise.

Kevin
